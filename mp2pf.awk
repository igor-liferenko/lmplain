# THIS FILE BELONGS TO THE METATYPE1 PACKAGE
#
# It is an AWK script that does the main job of convertion from
# METAPOST output to (raw) Type 1 format
# History:
# 29.07.2010: 0.41, notdef handled: if data contains glyph `notdef',
#             it is stored under the name `.notdef' in pfb (and the definition
#             of `.notdef' is removed from the pfb prologue), and not stored in afm
#             it is assumed that `notdef' does not appear in kern pairs
# 20.04.2006: 0.40, another bug fixed in set_hint (a[5] and a[6]
#             used to be used instead of a[7] and a[8], respectively).
# 24.03.2006: ver. 0.39, a bug fixed in setting vstems using the old scheme
#             (hsb was not taken into account); local variable `k'
#             introduced in `find_stem3'
# 13-20.11.2005: ver. 0.385 adaptation to the new hinting scheme -- cont.
#             global hints are not collected (needed by old interpreters);
#             BJ: hit replacement corrected (param. stemx added in
#             hint_clash; clear_hint doest not touch triple stem data);
# 26.10.2005: adaptation to the new hinting scheme -- cont. (20.5->-20.5)
# 15.10.2005: beginnig of the adaptation to the new hinting scheme
# 09.07.2005: ver. 0.38, adaptation to the possibility of writing
#             implicit encodings (like StandardEncoding) and
#             to the handling of (optional) CharSet by afm2pfm
# 15.02.2005: ver. 0.37, doubled kerns and ligatures silently ignored by
#             default; they can be reported on demand by setting the
#             parameter NQ (Non-Quiet; newly introduced) to a `true' value;
#             messages prefixed with `MP2PF:'
# 18.09.2004: ver. 0.36, awk script no longer cares for fontdimen names
# 29.04.2003: ver. 0.35, a bug in gawk circumvented (in clear_hints)
# 18.01.2003: ver. 0.34, normal round function introduced; old one
#             renamed to fround (forced round); no more mess due
#             ADL comment in PFB and Ascender and Descender ones in AFM;
#             again fun. rational: superfluously robust ;-)
# 06.01.2003: ver. 0.33, fun. rational: unlikely case included (as a comment)
# 03.01.2003: ver. 0.32, fontdimens and headerbytes handled
# 31.07.2002: banner added
# 14.07.2002: comment (question) added in `pickup_stem'
# 22.09.2001: ver. 0.31 (remarks moved to an informal readme.his file)
# 26.01.2001: an empty set of KPX pairs admitted
# 14.01.2001: functions rational and approx added

BEGIN {
# HEAD
# CONSOLE="/dev/tty"
# for MS-DOS you may use:
  CONSOLE="CON"
  mess("This is mp2pf, ver. 0.41 (a converter from MP EPSes to PS Type 1 font)")
  if (NAME=="") {mess("MP2PF: NAME MUST NOT BE EMPTY"); exit(1);}
  if (LOG=="") LOG=NAME ".clg" # converter log
  if (AFM=="") AFM=NAME ".afm"
  if (PFB=="") PFB=NAME ".p"
  if (FD=="") FD=NAME ".pfi"
  if (KD=="") KD=NAME ".kpx"
  if (CD=="") CD="pfcommon.dat"
  if (PL=="") PL="piclist.tex"
  # NQ=1 # Non-Quiet mode is off by default
  max_font_dimen=99; max_header_byte=99;
  mllx=10000; mlly=10000; murx=-10000; mury=-10000
  get_data_files()
  # dominant stems chosen manually have the highest priority:
  if ("STDVW" in font_data) vstem_stat[font_data["STDVW"]]=10000
  if ("STDHW" in font_data) hstem_stat[font_data["STDHW"]]=10000
  subrs_base=4; xsubrs[""]=-1 # standard empty subr has number 3==subrs_base-1
  # the following code must be consistent with fontbase.mp and mpform.sty
  while (getline < PL >0) if (/^\\EPSNAMEandNUMBER{.*}{[0-9]+}/) {
    sub(/^\\EPSNAMEandNUMBER{.*}{/,""); sub(/} *$/,"")
    file[++file[0]]=NAME "." $0
  }
# BODY
  for (curr_file=1; curr_file<=file[0]; curr_file++)
    while (getline < file[curr_file] >0) {
      if (/^%%BoundingBox:/) {
        if (++n%4==0) printf "#" > CONSOLE
        clear_hints(1)
        name=""; code=0; hsb=width=0; x0=y0=0; #sentinels
        curr_path=acc_path=0;
        hsb=llx=$2; lly=$3; urx=$4; ury=$5
        if (mllx>llx) mllx=llx; if (mlly>lly) mlly=lly
        if (murx<urx) murx=urx; if (mury<ury) mury=ury
      }
      if (/^%GLYNFO:/) {
        if ($2=="NAME") {name=$3; code=$4}
        if ($2=="HSBW") {#hsb=$3; # obsolete
          width=$4; # if (int(width)!=width) width=round(width*1000)/1000
          x0=hsb; y0=0} # hsbw should precede hints
        if ($2=="ACC") {acc_path=$3}
        if ($2=="HINT-TRIPLE") {do_hstem3=$3; do_vstem3=$4;}
        if ($2=="HINT-FLEX") {do_hflex=$3; do_vflex=$4;}
        ## !!FLEX MUST BE PROCESSED!!
        if ($2~/^HHINT$/) {pickup_stem(hstemx,hstem,$3,$4)}
        if ($2~/^VHINT$/) {pickup_stem(vstemx,vstem,$3-hsb,$4)}
        if ($2~/^HHINTX$/) {stem_idx=pickup_stemx(hstemx,$3,$4)}
        if ($2~/^VHINTX$/) {stem_idx=pickup_stemx(vstemx,$3-hsb,$4)}
        if ($2~/^HHINTN$/) {add_stem_point(hnode,stem_idx,
          $3 " " $4 " " $5 " " $6 " " $7 " " $8 " " $9 " " $10)}
        if ($2~/^VHINTN$/) {add_stem_point(vnode,stem_idx,
          $3 " " $4 " " $5 " " $6 " " $7 " " $8 " " $9 " " $10)}
        if ($2=="BEGINCHAR") {
          if (do_hstem3) hstem3=find_stem3(hstemx)
          if (do_vstem3) vstem3=find_stem3(vstemx)
          if (name=="notdef") was_notdef=1
          store_pfb("/" (name=="notdef" ? "." : "") name\
            " {\n\t" fround(hsb) " " approx(width) " hsbw")
          hints_pos=-mark_pfb_pos() # virgin hint position
          if (name!="notdef") store_afm("C " code " ; WX " width " ; N " name\
            " ; B " llx " " lly " " urx " " ury " ;", code, name)
        }
      }
      if (/lineto/) {
        set_hints(x0 " " y0 " " x0 " " y0 " " $1 " " $2 " " $1 " " $2)
        make_lineto($1-x0,$2-y0)
        x0=$1; y0=$2
      } else
      if (/curveto/) {
        set_hints(x0 " " y0 " " $1 " " $2 " " $3 " " $4  " " $5 " " $6)
        make_curveto($1-x0,$2-y0,$3-$1,$4-$2,$5-$3,$6-$4)
        x0=$5; y0=$6
      } else
      if (/moveto/) {
        # $1=="newpath"
        # we treat an accent nearly as a new glyph
        if (++curr_path==acc_path) change_hints()
        make_moveto($2-x0,$3-y0)
        x0=$2; y0=$3; x_path0=x0; y_path0=y0
      }
      if (/closepath/) {
        if ((x0!=x_path0) || (y0!=y_path0)) # closing with implicit `lineto'
          set_hints(x0 " " y0 " " x0 " " y0 " " x_path0 " " y_path0 " " x_path0 " " y_path0)
        store_pfb("\tclosepath")
      }
      if (/showpage/) {
        change_hints() # actually only flush_hints is needed
        store_pfb("\tendchar\n\t} ND")
      }
    } # end while, for
# TAIL
  print "" > CONSOLE
  stdhw=make_stem_stat(hstem_stat,stemsnaph)
  stdvw=make_stem_stat(vstem_stat,stemsnapv)
  flush_afm(); flush_pfb()
}

# FUNCTIONS

function make_stem_stat(stat,snap, m,d,i,j,t) {
  while (snap[0]<12) {# 12 is max length of stemsnap array
    m=0; d=0
    for (i in stat) if (stat[i]>m) {m=stat[i]; d=i+0}
    if (m>1) # ignore single stems
      {snap[++snap[0]]=d; delete stat[d]} else break
  }
  d=snap[1]
  for (i=1; i<snap[0]; ++i) {
    m=i; for (j=i+1; j<=snap[0]; j++) if (snap[j]<snap[m]) m=j
    if (m!=i) {t=snap[i]; snap[i]=snap[m]; snap[m]=t}
  }
  return d
}

# HINTS DATA STRUCTURE:
#
# REMARK 1: below, `list' denotes a string containing
#   a single-space-separated series of numbers; leading
#   and trailing spaces should be ignored
# REMARK 2: new and old hinting schemes mustn't be mixed in a glyph
#
# hstemx[n], vstemx[n] -- position and width (two-element list) of n-th stem
#   (used in both old and new hinting scheme)
# hstem[y], vstem[x] -- list of ordering numbers (n) of hints
#    with edge at the position x or y (used in old hinting scheme)
# hnode[s], vnode[s] -- list of ordering numbers (n) of hints attached
#   to point ending the bezier segment s, the latter being
#   and eight-element list (used in new hinting scheme)
# curr_hstem, curr_vstem -- list of currently active hints
# hstem3, vstem3 -- info (in pfb_text format) about triple stems

function clear_hints(lev, i) {
  # lev==0 at hints replacement (clears current stems)
  curr_hstem=" "; curr_vstem=" "
  if (lev>0) {# lev==1 at the begin of a glyph (clears all stem info)
    # `i=i' is a circumvention of a gawk bug (improper typing
    # scalar vs. array)
    for (i in hstemx) {i=i; delete hstemx[i]}
    for (i in vstemx) {i=i; delete vstemx[i]}
    for (i in hstem) {i=i; delete hstem[i]}
    for (i in vstem) {i=i; delete vstem[i]}
    for (i in hnode) {i=i; delete hnode[i]}
    for (i in vnode) {i=i; delete vnode[i]}
  }
}

function pickup_stemx(stemx,b,d) {
  stemx[++stemx[0]]= b " " d
  return stemx[0]
}

function pickup_stem(stemx,stem,b,d) {
  stemx[++stemx[0]]= b " " d
  b+=0; d+=0 # should be numbers
  if ((d>0) || (d==-20)) {
    if (stem[b]=="") stem[b]=" " stemx[0] " "
    else if (stem[b]!~(" " stemx[0] " ")) stem[b]=stem[b] stemx[0] " "
  }
  if ((d>0) || (d==-21)) {
    if (stem[b+d]=="") stem[b+d]=" " stemx[0] " "
    else if (stem[b+d]!~(" " stemx[0] " ")) stem[b+d]=stem[b+d] stemx[0] " "
  }
  return 0
}

function add_stem_point(node,idx,tail) {
  if (node[tail]=="") node[tail]=" " idx " "
    else if (node[tail]!~(" " idx " ")) node[tail]=node[tail] idx " "
}

function hint_clash(cand,curr,stemx,  a,b,l1,r1,l2,r2,i,j,t,clash,cand_nc,cand_ac) {
  a[0]=split(cand,a); if (a[0]==0) return "0 0" # no hint candidate
  b[0]=split(curr,b)
  cand_nc=-1 # candidate to be set if no hint change occurs (if <0 -- do change)
  cand_ac=0  # candidate to be set after the (other) hint change
  for (i=1; i<=a[0]; ++i) {
    clash=0; split(stemx[a[i]],t)
    l1=min(t[1]+0,t[1]+t[2]); r1=max(t[1]+0,t[1]+t[2])
    for (j=1; j<=b[0]; ++j) {
      if (a[i]==b[j]) {cand_nc=0; break}
      split(stemx[b[j]],t)
      l2=min(t[1]+0,t[1]+t[2]); r2=max(t[1]+0,t[1]+t[2])
      if ((r2>=l1) && (l2<=r1)) {clash=1; break}
    }
    if (!clash) {
      if (cand_nc==0) {# exact match found
      } else if (cand_nc==-1) cand_nc=a[i]
      else cand_nc=optimal_hint(cand_nc,a[i])
    }
    if (cand_ac==0) cand_ac=a[i]
    else cand_ac=optimal_hint(cand_ac,a[i])
  }
  return cand_nc " " cand_ac
}

function optimal_hint(prev,act, ad,pd,t) {# here: optimal = minimal width
  split(stemx[act],t);  ad=abs(t[2])
  split(stemx[prev],t); pd=abs(t[2])
  return (ad<pd? act : prev)
}

function find_stem3(stemx, i,j,k,t,c,xcent,xsize,xbase,freq) {
  for (i=1; i<=stemx[0]; ++i) {
    split(stemx[i],t);
    if (t[2]+0>0) {
      c=2*t[1]+t[2] # c = doubled coordinate of the center of stem (integer)
      xcent[c]=i; xbase[c]=t[1]; xsize[c]=t[2]
      freq[t[2]]++
    }
  }
  for (i in xcent) if (freq[xsize[i]]>1)
    for (j in xcent) if (i!=j)
      if (xsize[i]==xsize[j]) {
        c=(i+j)/2
        if (c in xcent) {
          if (i>j) {k=i; i=j; j=k} # sorting stems (not required)
          return "\t" xbase[i] " " xsize[i] " " xbase[c] " " xsize[c] " " \
            xbase[j] " " xsize[j]
        }
      }
  return ""
}

function set_hints(tail, a,do_rep,vcand,hcand) {
  a[0]=split(tail,a)
  if (!hstem3) {
    if (tail in hnode) {
      hcand=hint_clash(hnode[tail], curr_hstem, hstemx)
      if (hcand+0<0) do_rep=1
    } else if (a[8] in hstem) {# new and old hinting schemes mustn't be mixed
      hcand=hint_clash(hstem[a[8]], curr_hstem, hstemx)
      if (hcand+0<0) do_rep=1
    }
  } else hcand=0
  if (!vstem3) {
    if (tail in vnode) {
      vcand=hint_clash(vnode[tail], curr_vstem, vstemx)
      if (vcand+0<0) do_rep=1
    } else if ((a[7]-hsb) in vstem) {# new and old hinting schemes mustn't be mixed
      vcand=hint_clash(vstem[a[7]-hsb], curr_vstem, vstemx)
      if (vcand+0<0) do_rep=1
    }
  } else vcand=0
  if (do_rep) {
    change_hints()
    if (!hstem3) {split(hcand,t); hcand=t[2]}
    if (!vstem3) {split(vcand,t); vcand=t[2]}
  }
  if (hcand+0>0) curr_hstem=curr_hstem (hcand+0) " " # set_hint
  if (vcand+0>0) curr_vstem=curr_vstem (vcand+0) " " # set_hint
}

function flush_hints( r) {
  if (hstem3) r=hstem3 " hstem3"
  else r=flush_curr_hints(curr_hstem, hstemx, " hstem")
  if (r!="") r=r "\n"
  if (vstem3) r=r vstem3 " vstem3"
  else r=r flush_curr_hints(curr_vstem, vstemx, " vstem")
  return r
}

function flush_curr_hints(curr_stem,stemx,sfx, i,a,b,r) {
  a[0]=b[0]=split(curr_stem, b)
  for (i=1; i<=b[0]; ++i) a[i]=stemx[b[i]]
  trivial_sort(a)
  for (i=1; i<=a[0]; ++i) {
    split(a[i],b);
    if ((sfx ~ "h") && (b[2]>0)) hstem_stat[b[2]]++
    if ((sfx ~ "v") && (b[2]>0)) vstem_stat[b[2]]++
    r=r (r==""?"":"\n") "\t" a[i] sfx
  }
  return r
}

function change_hints( h) {
  h=flush_hints()
  if (hints_pos<0) pfb_text[-hints_pos]=h
  else {
    if (!(h in xsubrs)) {subrs[++subrs[0]]=h; xsubrs[h]=subrs[0]}
    pfb_text[hints_pos]="\t" xsubrs[h]+subrs_base " 4 callsubr"
     # subr 4 performs hint replacement
  }
  hints_pos=mark_pfb_pos()
  clear_hints(0)
}

function tab2str(t, s) {
  for(i=1; i<=t[0]; ++i) s=s (s=="" ? "" : " ") t[i]
  return s
}

function mark_pfb_pos() {return ++pfb_text[0]}

function store_pfb(s) {pfb_text[++pfb_text[0]]=s}

function store_afm(s,n,m) {
  if (n==-1) afm_text_oth[++num_oth_chars] = s lig_data[m]
  else if (!(n in afm_text)) {
    ++num_enc_chars; afm_text[n]=s lig_data[m]; enc_name[n]=m
  } else mess("MP2PF: CHAR " n " ALREADY EXISTS")
}

function get_data_files( s,key,a) {
  while (getline s < CD >0) {
    if (s~/^<\//) key=""
    if (key~/<PFB PROLOG>/)  PFB_PRO[++PFB_PRO[0]]=s
    if (key~/<PFB TRAILER>/) PFB_TRA[++PFB_TRA[0]]=s
    if (key~/<AFM PROLOG>/)  AFM_PRO[++AFM_PRO[0]]=s
    if (key~/<AFM TRAILER>/) AFM_TRA[++AFM_TRA[0]]=s
    if (key~/<AFM KPX>/)     AFM_KPX[++AFM_KPX[0]]=s
    if (s~/^<[^\/]/) key=s
  }
#
  while (getline s < FD >0) {sub(/ +$/,"", s)
    if (split(s,a,/ +: */)==2) font_data[a[1]]=a[2]
    else mess("MP2PF: IMPROPER FONT INFO FILE")
  }
#
  while (getline s < KD >0) {
    if (s~/^KPX /) {split(s,a)
      if ((a[2],a[3]) in kpx_used) {
        if (NQ) {
          if (kpx_used[a[2],a[3]]==a[4])
            mess("MP2PF: REPEATED KERN PAIR: " a[2] " " a[3] " " a[4])
          else
            mess("MP2PF: INCONSISTENT KERN PAIR: "\
                 a[2] " " a[3] " " a[4] " (" kpx_used[a[2],a[3]] ")")
        }
      } else {
        kpx_used[a[2],a[3]]=a[4]
        kpx_data[++kpx_data[0]]=s
      }
    }
    if (s~/^L /) {split(s,a)
      if ((a[2],a[3]) in lig_used) {
        if (NQ) {
          if (lig_used[a[2],a[3]]==a[4])
            mess("MP2PF: REPEATED LIGATURE: " a[2] " " a[3] " " a[4])
          else
            mess("MP2PF: INCONSISTENT LIGATURE: "\
                 a[2] " " a[3] " " a[4] " (" lig_used[a[2],a[3]] ")")
        }
      } else {
        lig_used[a[2],a[3]]=a[4]
        lig_data[a[2]]=lig_data[a[2]] " L " a[3] " " a[4] " ;"
      }
    }
  }
}

function flush_pfb( s,i,n) {
  if (was_notdef) {
    s=""; for (n=1; n<=PFB_PRO[0]; n++) s=s (s=="" ? "" : "\n" ) PFB_PRO[n]
    sub(/\/\.notdef[^}]*}[ \t\n]*ND[ \t\n]*/,"",s)
    PFB_PRO[0]=split(s,PFB_PRO,"\n")
  }
  for (n=1; n<=PFB_PRO[0]; n++) {
    s=PFB_PRO[n]
    for (i in font_data)
      while (match(s,"##" i "##"))
       if (font_data[i]=="") s="" # no empty key values
       else s=substr(s,1,RSTART-1) font_data[i] substr(s,RSTART+RLENGTH)
    if (match(s,"##OTHER_BLUES##")) s="" # no empty `other blues'
#
    if (match(s,"##ENCODING_DATA##")) {
     if (("ENCODING_NAME" in font_data) && (font_data["ENCODING_NAME"]!=""))
       s="/Encoding " font_data["ENCODING_NAME"] " def"
     else {
       s="/Encoding 256 array\n0 1 255 {1 index exch /.notdef put} for\n"
       for (i=0; i<=255; ++i) if (i in enc_name) {
         s=s "dup " i "/" enc_name[i] " put\n"
       }
       s=s "readonly def"
      }
    }
    if (match(s,"##FONT_BOUNDING_BOX##"))
      s=substr(s,1,RSTART-1) mllx " " mlly " " murx " " mury\
        substr(s,RSTART+RLENGTH)
    if (match(s,"##STDHW##"))
      if (stdhw==0) s=""
      else s=substr(s,1,RSTART-1) stdhw substr(s,RSTART+RLENGTH)
    if (match(s,"##STDVW##"))
      if (stdvw==0) s=""
      else s=substr(s,1,RSTART-1) stdvw substr(s,RSTART+RLENGTH)
    if (match(s,"##STEMSNAPH##"))
      if (stdhw==0) s=""
      else s=substr(s,1,RSTART-1) tab2str(stemsnaph) substr(s,RSTART+RLENGTH)
    if (match(s,"##STEMSNAPV##"))
      if (stdvw==0) s=""
      else s=substr(s,1,RSTART-1) tab2str(stemsnapv) substr(s,RSTART+RLENGTH)
    if (match(s,"##NUMBER_OF_SUBRS##"))
      s=substr(s,1,RSTART-1) (1+subrs_base+subrs[0])\
        substr(s,RSTART+RLENGTH) # 1+subrs_base = number of standard subrs
    if (match(s,"##SUBROUTINES##")) {
      s=""
      for (i=1; i<=subrs[0]; ++i) {
        s=s (s=="" ? "" : "\n")\
          "dup " i+subrs_base " {\n" subrs[i] "\n\treturn\n\t} NP"
      }
    }
    if (match(s,"##NUMBER_OF_CHARSTRINGS##"))
      s=substr(s,1,RSTART-1)\
        (num_enc_chars+num_oth_chars+1)\
        substr(s,RSTART+RLENGTH) # +1 because of /.notdef
    if (match(s,"##[^#]+##"))
      mess("MP2PF: EXTRA TAG: " substr(s,RSTART,RLENGTH))
    if (s!="") print s > PFB
  }
#
  for (i=1; i<=pfb_text[0]; ++i)
    if (pfb_text[i]!="") # lines reserved for hints can be empty
      print pfb_text[i] > PFB
#
  for (n=1; n<=PFB_TRA[0]; n++) print PFB_TRA[n] > PFB
}

function flush_afm( s,i,a,n, font_dimen, dimen_name, header_byte) {
  for (n=0; n<=max_font_dimen; n++) for (i in font_data) {
    if (match(i, "FONT_DIMEN" n "$")) font_dimen[n]=font_data[i]
    if (match(i, "DIMEN_NAME" n "$")) dimen_name[n]=font_data[i]
  }
  for (n=0; n<=max_header_byte; n++) {
    for (i in font_data)
      if (match(i, "HEADER_BYTE" n "$")) header_byte[n]=font_data[i]
  }
  for (n=1; n<=AFM_PRO[0]; n++) {
    s=AFM_PRO[n]
    if (match(s,"##FONT_BOUNDING_BOX##"))
      s=substr(s,1,RSTART-1) mllx " " mlly " " murx " " mury\
        substr(s,RSTART+RLENGTH)
    for (i in font_data)
      while (match(s,"##" i "##"))
        if (font_data[i]=="") s="" # no empty key values
        else s=substr(s,1,RSTART-1) font_data[i] substr(s,RSTART+RLENGTH)
    while (match(s,"##PFM_[A-Z]+##")) # asterisk == "undefined" for afm2pf.pl:
      s=substr(s,1,RSTART-1) "*" substr(s,RSTART+RLENGTH)
    if (match(s,"TFM designsize")) {# append remaining TFM data:
      for (i=0; i<=max_font_dimen; ++i) if (i in font_dimen)
        s=s "\nComment TFM fontdimen " sprintf("%2d", i) ": "\
          sprintf("%-11s", font_dimen[i]) dimen_name[i]
      for (i=0; i<=max_header_byte; ++i) if (i in header_byte)
        s=s "\nComment TFM headerbyte " sprintf("%2d", i) ": " header_byte[i]
    }
    if (match(s,"##NUMBER_OF_CHARNAMES##"))
      s=substr(s,1,RSTART-1) (num_enc_chars+num_oth_chars)\
        substr(s,RSTART+RLENGTH)
    if (match(s,"##[^#]+##"))
      mess("MP2PF: EXTRA TAG: " substr(s,RSTART,RLENGTH))
    if (s!="") print s > AFM
  }
#
  for (i=0; i<=255; ++i) if (i in afm_text) {
    print afm_text[i] > AFM
    delete afm_text[i]
  }
  for (i in afm_text) mess("MP2PF: CHAR OF CODE " i)
  for (i=1; i<=num_oth_chars; ++i) print afm_text_oth[i] > AFM
#
  for (n=1; n<=AFM_TRA[0]; n++) {
    s=AFM_TRA[n]
    if (match(s,"##AFM_KPX##")) {
      s=""
      if (kpx_data[0]>0) flush_kpx(kpx_data)
    }
    if (s!="") print s > AFM
  }
}

function flush_kpx(k, s,i,a,l) {
  for (l=1; l<=AFM_KPX[0]; l++) {
    s=AFM_KPX[l]
    if (match(s,"##NUMBER_OF_KPX##"))
      s=substr(s,1,RSTART-1) k[0] substr(s,RSTART+RLENGTH)
    if (match(s,"##KPX_DATA##")) {
      s=""
      for(i=1; i<=k[0]; ++i) s=s (s==""?"":"\n") k[i]
    }
    print s > AFM
  }
}

function make_lineto(dx,dy) {
  if ((dx!=0) || (dy!=0)) {# emergency test
    if (dx==0) {store_pfb("\t" fround(dy) " vlineto")}
    else
      if (dy==0) {store_pfb("\t" fround(dx) " hlineto")}
      else {store_pfb("\t" fround(dx) " " fround(dy) " rlineto")}
  }
}

function make_moveto(dx,dy) {
  if ((dx!=0) || (dy!=0)) {# emergency test
    if (dx==0) {store_pfb("\t" fround(dy) " vmoveto")}
    else
      if (dy==0) {store_pfb("\t" fround(dx) " hmoveto")}
      else {store_pfb("\t" fround(dx) " " fround(dy) " rmoveto")}
  }
}

function make_curveto(dx1,dy1,dx2,dy2,dx3,dy3) {
  if ((dx1+dx2+dx3!=0) || (dy1+dy2+dy3!=0)) {# no loops (emergency test)
    if ((dy1==0) && (dx3==0))
      store_pfb("\t" fround(dx1) " " fround(dx2) " "\
        fround(dy2) " " fround(dy3) " hvcurveto")
    else
    if ((dx1==0) && (dy3==0))
      store_pfb("\t" fround(dy1) " " fround(dx2) " "\
      fround(dy2) " " fround(dx3) " vhcurveto")
    else
      store_pfb("\t" fround(dx1) " " fround(dy1) " " fround(dx2) " "\
        fround(dy2) " " fround(dx3) " " fround(dy3) " rrcurveto")
  }
}

function rational(x,nlimit,dlimit, p0,q0,p1,q1,p2,q2,s,ds) {
  # a simplified version of the code kindly sent us by Berthold K. P. Horn
  if (x == 0.0) return "0 1" # if (x == 0.0) return "0/1"
  if (x < 0.0) return "-" rational(-x, nlimit, dlimit)
  # if (int(x) > nlimit) return round(x) # unlikely (in Type 1 fonts)
  p0=0; q0=1; p1=1; q1=0; s=x;
  while (1) {
    # in general, it is advisable to avoid crossing limits;
    # here, it is perhaps a bit of pedantry:
    if ( int(s)!=0 &&\
      ((p1 > (nlimit-p0)/int(s)) || (q1 > (dlimit-q0)/int(s))) )
      {p2=p1; q2=q1; break}
    p2=p0+int(s)*p1; q2=q0+int(s)*q1;
#   printf("%ld %ld %ld %ld %ld %ld %lg\n", p0, q0, p1, q1, p2, q2, s)
    if (p2/q2==x) break
    ds=s-int(s)
    if (ds == 0.0) break
    p0=p1; q0=q1; p1=p2; q1=q2; s=1/ds
  }
  # q2 != 0
  return p2 " " q2 # the answer is p2/q2
}

function approx(x, r,a) {
  # 32767 is a limit due to old (DOS?) implementations of t1utils
  r=rational(x,32767,32767); split(r,a); return (a[2]==1 ? a[1] : r " div")
}

function abs(x) {return (x>=0 ? x : -x)}

function min(x,y) {return (x<y ? x : y)}
function max(x,y) {return (x>y ? x : y)}

function round(x) {# round
  return (x>=0 ? int(x+.5) : -int(-x+.5))
}

function fround(x) {# forced round
  if (x!=int(x)) {
    mess("MP2PF: WRONG ROUNDING IN METAPOST " x " IN " name)
    return (x>=0 ? int(x+.5) : -int(-x+.5))
  } else return x
}

function trivial_sort(a, i,j,t) {
  for (i=1; i<=a[0]; ++i)
    for (j=i; j>1; --j)
      if (a[j-1]>a[j]) {t=a[j]; a[j]=a[j-1]; a[j-1]=t}
      else break
}

function mess(s) {print s > CONSOLE; if (LOG!="") print s > LOG}

