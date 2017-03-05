%%%% This file belongs to the Latin Modern package. The work is released
%%%% under the GUST Font License. See the MANIFEST-Latin-Modern.txt and
%%%% README-Latin-Modern.txt files for the details. For the most recent version of
%%%% this license see http://www.gust.org.pl/fonts/licenses/GUST-FONT-LICENSE.txt
%%%% or http://tug.org/fonts/licenses/GUST-FONT-LICENSE.txt

% LM-oriented variables:
% is_bold, is_csc, is_ital, is_ssq, is_vtt, do_light, do_dark

if (unknown do_light) and (unknown do_dark):
 input gly_euro.mp;
 input gly_guil.mp;
 input gly_vspa.mp;
fi

input gly_inft.mp;

%%%% if known generating:
%%%%  if generating=0:
%%%%   extra_endglyph:=extra_endglyph & "message str !!glyph_name;";
%%%%  fi
%%%% fi

%% \def\vb{\vfill\break}

% i and j are somewhat special

%% \vb\- The letter i:\- Litera i\PICT{i}\-
if known is_csc:
 dup_glyph(_dotlessi)(_i);
else:
 acc_glyph(_dotlessi)(_dotaccent)(_i);
fi

%% \vb\- The letter i.TRK:\- \PICT{i.TRK}\-
% duplicate of `i' for Turkish (OTF manipulation) -- obsolete

%% \vb\- The letter j:\- Litera j\PICT{j}\-
if known is_csc:
 dup_glyph(_dotlessj)(_j);
else:
 acc_glyph(_dotlessj)(_dotaccent)(_j);
fi

begingroup

interim finding_triple_hstems:=finding_triple_vstems:=0;
interim ignore_nib_limit:=3;

%% \vb\- ringhalfleft:\- \PICT{ringhalfleft}\-
if feasible_two_glyphs(_c)(_ringhalfleft):
 beginglyph(_ringhalfleft);
  save loose_fix_stem;
  save p; path p[];
  save f_; f_:=((if known is_ssq: 12 else: designsize fi-5)/(17.28-5))[.8,.6]; % scaling factor;
  save q_; q_:=if known do_condensed: 10 else: 12 fi; % thickening pen
  p1=correct_close_doublets(
      glyph_stored._c 1 scaled f_
    )(10);
  p2=p1 shifted (0,uc_height-ypart(urcorner(p1))-vair);
  interim pen_stroke_method:=2;
  % with |pen_stroke_method:=0| and scaling factor .45, the fonts lmbx7,
  % lmbx9, and lmbx12 contained a bad incision near the bulb
  local default_nib=fix_nib(q_,q_,0);
   % for lmtlo10 |ignore_nib_limit=3| is too small (degenerated bezier)
   interim ignore_nib_limit:=4;
   pen_stroke()(p2)(p3);
  endlocal;
  if monospace:
    wd._ringhalfleft:=mono_charwd;
    p4:=round_node_values( p3r shifted
       (1/2(wd._ringhalfleft-xpart(urcorner p3r + llcorner p3r)),0)
     );
    draw p2 italicized shifted
     (1/2(wd._ringhalfleft-xpart(urcorner p3r + llcorner p3r)),0);
  else:
    p4:=round_node_values(p3r shifted (-xpart(llcorner p3r)+round u,0));
    wd._ringhalfleft:=xpart(urcorner p4)+round u;
    draw p2 italicized shifted (-xpart(llcorner p3r)+round u,0);
  fi
  Fill p4;
  for i_:=1 upto hstem_stored._c.num:
   fix_hstem(+q_+1+round(f_*ypart(hstem_stored._c[i_])))(p4) x < 3/4wd._ringhalfleft;
   fix_hstem(+q_+0+round(f_*ypart(hstem_stored._c[i_])))(p4) x < 3/4wd._ringhalfleft;
   fix_hstem(+q_-1+round(f_*ypart(hstem_stored._c[i_])))(p4) x < 3/4wd._ringhalfleft;
  endfor
  for i_:=1 upto vstem_stored._c.num:
   fix_vstem(+q_+1+round(f_*ypart(vstem_stored._c[i_])))(p4);
   fix_vstem(+q_+0+round(f_*ypart(vstem_stored._c[i_])))(p4);
   fix_vstem(+q_-1+round(f_*ypart(vstem_stored._c[i_])))(p4);
  endfor
  standard_exact_hsbw("ringhalfleft");
 endglyph;
fi

%% \vb\- ringhalfright:\- \PICT{ringhalfright}\-
if feasible_two_glyphs(_ringhalfleft)(_ringhalfright):
 beginglyph(_ringhalfright);
  save loose_fix_stem;
  save p; path p[];
  p1=glyph_stored._ringhalfleft1;
  p2=p1 rotatedaround (center p1,180);
  Fill p2;
  wd._ringhalfright:=wd._ringhalfleft;
  for i_:=1 upto hstem_stored._ringhalfleft.num:
   fix_hstem(ypart(hstem_stored._ringhalfleft[i_]))(p2) x > 1/4wd._ringhalfright;
  endfor
  for i_:=1 upto vstem_stored._ringhalfleft.num:
   fix_vstem(ypart(vstem_stored._ringhalfleft[i_]))(p2);
  endfor
  standard_exact_hsbw("ringhalfright");
 endglyph;
fi

endgroup;

%% \vb\- macron.alt:\- \PICT{macron.alt}\-
if feasible_two_glyphs(_macron)(_macron.alt):
 beginglyph(_macron.alt);
  save p,s; path p[];
  wd._macron.alt:=wd._macron;
  p1=glyph_stored._macron1;
  s=round (if known is_ital: 1/8 else: 1/6 fi wd._macron);
  for i_:=0 upto length(p1)-1:
   z0[i_]=point i_ of p1;
   z0[i_]a=postcontrol i_ of p1;
   z0[i_+1]b=precontrol i_+1 of p1;
   x0[i_]:=x0[i_] if x0[i_]<1/2wd._macron: + else: - fi s;
   x0[i_]a:=x0[i_]a if x0[i_]a<1/2wd._macron: + else: - fi s;
   x0[i_+1]b:=x0[i_+1]b if x0[i_+1]b<1/2wd._macron: + else: - fi s;
  endfor
  z0[length(p1)]=z 0 0; p2=compose_path.z0(length(p1));
  Fill p2;
  fix_hstem(ypart(urcorner p2 - llcorner p2))(p2);
  standard_exact_hsbw("macron.alt");
 endglyph;
fi

%% \vb\- Macron.alt:\- \PICT{Macron.alt}\-
if feasible_two_glyphs(_Macron)(_Macron.alt):
 beginglyph(_Macron.alt);
  save p,s; path p[];
  wd._Macron.alt:=wd._Macron;
  p1=glyph_stored._Macron1;
  s=round (if known is_ital: 1/7 else: 1/6 fi wd._Macron);
  for i_:=0 upto length(p1)-1:
   z0[i_]=point i_ of p1;
   z0[i_]a=postcontrol i_ of p1;
   z0[i_+1]b=precontrol i_+1 of p1;
   x0[i_]:=x0[i_] if x0[i_]<1/2wd._Macron: + else: - fi s;
   x0[i_]a:=x0[i_]a if x0[i_]a<1/2wd._Macron: + else: - fi s;
   x0[i_+1]b:=x0[i_+1]b if x0[i_+1]b<1/2wd._Macron: + else: - fi s;
  endfor
  z0[length(p1)]=z 0 0; p2=compose_path.z0(length(p1));
  Fill p2;
  fix_hstem(ypart(urcorner p2 - llcorner p2))(p2);
  standard_exact_hsbw("Macron.alt");
 endglyph;
fi

%% \vb\- breveinverted:\- \PICT{breveinverted}\-
if feasible_two_glyphs(_breve)(_breveinverted):
 beginglyph(_breveinverted);
  save loose_fix_stem;
  save p; path p[];
  p1=glyph_stored._breve1 rotatedaround (center glyph_stored._breve1,180);
  Fill p1;
  wd._breveinverted:=wd._breve;
  for i_:=1 upto hstem_stored._breve.num:
   if ypart(hstem_stored._breve[i_])>0:
    fix_hstem(ypart(hstem_stored._breve[i_]))(p1);
   else:
    % |if ypart(hstem_stored._breve[i_])=-20: ghost_stem top; fi % normally|
    % |if ypart(hstem_stored._breve[i_])=-21: ghost_stem bot; fi % normally|
    if ypart(hstem_stored._breve[i_])=-21: ghost_stem top; fi % rotated
    if ypart(hstem_stored._breve[i_])=-20: ghost_stem bot; fi % rotated
   fi
  endfor
  for i_:=1 upto vstem_stored._breve.num:
   if ypart(vstem_stored._breve[i_])>0:
    fix_vstem(ypart(vstem_stored._breve[i_]))(p1);
   else:
    % |if ypart(vstem_stored._breve[i_])=-20: ghost_stem rt; fi % normally|
    % |if ypart(vstem_stored._breve[i_])=-21: ghost_stem lft; fi % normally|
    if ypart(vstem_stored._breve[i_])=-21: ghost_stem rt; fi % rotated
    if ypart(vstem_stored._breve[i_])=-20: ghost_stem lft; fi % rotated
   fi
  endfor
  standard_exact_hsbw("breveinverted");
 endglyph;
fi

%% \vb\- Breveinverted:\- \PICT{Breveinverted}\-
if feasible_two_glyphs(_Breve)(_Breveinverted):
 beginglyph(_Breveinverted);
  save loose_fix_stem;
  save p; path p[];
  p1=glyph_stored._Breve1 rotatedaround (center glyph_stored._Breve1,180);
  Fill p1;
  wd._Breveinverted:=wd._Breve;
  for i_:=1 upto hstem_stored._Breve.num:
   if ypart(hstem_stored._Breve[i_])>0:
    fix_hstem(ypart(hstem_stored._Breve[i_]))(p1);
   else:
    % |if ypart(hstem_stored._Breve[i_])=-20: ghost_stem top; fi % normally|
    % |if ypart(hstem_stored._Breve[i_])=-21: ghost_stem bot; fi % normally|
    if ypart(hstem_stored._Breve[i_])=-21: ghost_stem top; fi % rotated
    if ypart(hstem_stored._Breve[i_])=-20: ghost_stem bot; fi % rotated
   fi
  endfor
  for i_:=1 upto vstem_stored._Breve.num:
   if ypart(vstem_stored._Breve[i_])>0:
    fix_vstem(ypart(vstem_stored._Breve[i_]))(p1);
   else:
    % |if ypart(vstem_stored._Breve[i_])=-20: ghost_stem rt; fi % normally|
    % |if ypart(vstem_stored._Breve[i_])=-21: ghost_stem lft; fi % normally|
    if ypart(vstem_stored._Breve[i_])=-21: ghost_stem rt; fi % rotated
    if ypart(vstem_stored._Breve[i_])=-20: ghost_stem lft; fi % rotated
   fi
  endfor
  standard_exact_hsbw("Breveinverted");
 endglyph;
fi

%% \vb\- brevebelow:\- \PICT{brevebelow}\-
dup_glyph(_Breve)(_brevebelow)
  (0,accent_baxis-ypart(center(glyph_stored._Breve1)));

%% \vb\- brevebelowinverted:\- \PICT{brevebelowinverted}\-
dup_glyph(_Breveinverted)(_brevebelowinverted)
  (0,accent_baxis-ypart(center(glyph_stored._Breveinverted1)));

%% \vb\- macronbelow:\- \PICT{macronbelow}\-
dup_glyph(_Macron)(_macronbelow)
  (0,accent_baxis-ypart(center(glyph_stored._Macron1)));

%% \vb\- linebelow:\- \PICT{linebelow}\-
dup_glyph(_macronbelow)(_linebelow); % unicode idiosyncrasy (insanity?)

%% \vb\- tildebelow:\- \PICT{tildebelow}\-
% needed for (a better) completeness of the set of combining accents 
dup_glyph(_Tilde)(_tildebelow)
  (0,accent_baxis-ypart(center(glyph_stored._Tilde1)));

%% \vb \- Acutecomb \- \PICT{Acutecomb} \-
lap_glyph(_acute)(_Acutecomb)(-1/2wd._a,uc_height-lc_height);

%% \vb \- acutecomb \- \PICT{acutecomb} \-
lap_glyph(_acute)(_acutecomb)(-1/2wd._a,0);

%% \vb \- Brevecomb \- \PICT{Brevecomb} \-
lap_glyph(_breve)(_Brevecomb)(-1/2wd._a,uc_height-lc_height);

%% \vb \- brevecomb \- \PICT{brevecomb} \-
lap_glyph(_breve)(_brevecomb)(-1/2wd._a,0);

%% \vb \- brevebelowcomb \- \PICT{brevebelowcomb} \-
lap_glyph(_brevebelow)(_brevebelowcomb)(-1/2wd._a,0);

%% \vb \- brevebelowinvertedcomb \- \PICT{brevebelowinvertedcomb} \-
lap_glyph(_brevebelowinverted)(_brevebelowinvertedcomb)(-1/2wd._a,0);

%% \vb \- Breveinvertedcomb \- \PICT{Breveinvertedcomb} \-
lap_glyph(_breveinverted)(_Breveinvertedcomb)(-1/2wd._a,uc_height-lc_height);

%% \vb \- breveinvertedcomb \- \PICT{breveinvertedcomb} \-
lap_glyph(_breveinverted)(_breveinvertedcomb)(-1/2wd._a,0);

%% \vb \- Caroncomb \- \PICT{Caroncomb} \-
lap_glyph(_caron)(_Caroncomb)(-1/2wd._a,uc_height-lc_height);

%% \vb \- caroncomb \- \PICT{caroncomb} \-
lap_glyph(_caron)(_caroncomb)(-1/2wd._a,0);

%% \vb \- Circumflexcomb \- \PICT{Circumflexcomb} \-
lap_glyph(_circumflex)(_Circumflexcomb)(-1/2wd._a,uc_height-lc_height);

%% \vb \- circumflexcomb \- \PICT{circumflexcomb} \-
lap_glyph(_circumflex)(_circumflexcomb)(-1/2wd._a,0);

%% \vb \- commaaccentcomb \- \PICT{commaaccentcomb} \-
lap_glyph(_commaaccent)(_commaaccentcomb)(-1/2wd._a,0);

% |lap_glyph(_commaturnedabove)(_Commaturnedabovecomb)(-1/2wd._a,uc_height-lc_height);|
% |lap_glyph(_commaturnedabove)(_commaturnedabovecomb)(-1/2wd._a,0);|

%% \vb \- dblGravecomb \- \PICT{dblGravecomb} \-
lap_glyph(_dblgrave)(_dblGravecomb)(-1/2wd._a,uc_height-lc_height);

%% \vb \- dblgravecomb \- \PICT{dblgravecomb} \-
lap_glyph(_dblgrave)(_dblgravecomb)(-1/2wd._a,0);

%% \vb \- Dieresiscomb \- \PICT{Dieresiscomb} \-
lap_glyph(_dieresis)(_Dieresiscomb)(-1/2wd._a,uc_height-lc_height);

%% \vb \- dieresiscomb \- \PICT{dieresiscomb} \-
lap_glyph(_dieresis)(_dieresiscomb)(-1/2wd._a,0);

%% \vb \- Dotaccentcomb \- \PICT{Dotaccentcomb} \-
lap_glyph(_dotaccent)(_Dotaccentcomb)(-1/2wd._a,uc_height-lc_height);

%% \vb \- dotaccentcomb \- \PICT{dotaccentcomb} \-
lap_glyph(_dotaccent)(_dotaccentcomb)(-1/2wd._a,0);

%% \vb \- dotbelowcomb \- \PICT{dotbelowcomb} \-
lap_glyph(_dotbelow)(_dotbelowcomb)(-1/2wd._a,0);

%% \vb \- Gravecomb \- \PICT{Gravecomb} \-
lap_glyph(_grave)(_Gravecomb)(-1/2wd._a,uc_height-lc_height);

%% \vb \- gravecomb \- \PICT{gravecomb} \-
lap_glyph(_grave)(_gravecomb)(-1/2wd._a,0);

%% \vb \- Hookabovecomb \- \PICT{Hookabovecomb} \-
lap_glyph(_hookabove)(_Hookabovecomb)(-1/2wd._a,uc_height-lc_height);

%% \vb \- hookabovecomb \- \PICT{hookabovecomb} \-
lap_glyph(_hookabove)(_hookabovecomb)(-1/2wd._a,0);

%% \vb \- Hungarumlautcomb \- \PICT{Hungarumlautcomb} \-
lap_glyph(_hungarumlaut)(_Hungarumlautcomb)(-1/2wd._a,uc_height-lc_height);

%% \vb \- hungarumlautcomb \- \PICT{hungarumlautcomb} \-
lap_glyph(_hungarumlaut)(_hungarumlautcomb)(-1/2wd._a,0);

%% \vb \- linebelowcomb \- \PICT{linebelowcomb} \-
lap_glyph(_linebelow)(_linebelowcomb)(-1/2wd._a,0);

%% \vb \- macronbelowcomb \- \PICT{macronbelowcomb} \-
lap_glyph(_macronbelow)(_macronbelowcomb)(-1/2wd._a,0);

%% \vb \- Macroncomb \- \PICT{Macroncomb} \-
lap_glyph(_macron)(_Macroncomb)(-1/2wd._a,uc_height-lc_height);

%% \vb \- macroncomb \- \PICT{macroncomb} \-
lap_glyph(_macron)(_macroncomb)(-1/2wd._a,0);

%% \vb \- Ringcomb \- \PICT{Ringcomb} \-
lap_glyph(_ring)(_Ringcomb)(-1/2wd._a,uc_height-lc_height);

%% \vb \- ringcomb \- \PICT{ringcomb} \-
lap_glyph(_ring)(_ringcomb)(-1/2wd._a,0);

%% \vb \- Tildecomb \- \PICT{Tildecomb} \-
lap_glyph(_tilde)(_Tildecomb)(-1/2wd._a,uc_height-lc_height);

%% \vb \- tildecomb \- \PICT{tildecomb} \-
lap_glyph(_tilde)(_tildecomb)(-1/2wd._a,0);

%% \vb \- tildebelowcomb \- \PICT{tildebelowcomb} \-
lap_glyph(_tildebelow)(_tildebelowcomb)(-1/2wd._a,0);

% selected double accents

%% \vb\- Dieresisacute:\- \PICT{Dieresisacute}\-
glyph_axis._Dieresisacute:=glyph_axis._dieresis;
acc_glyph(_Dieresis)(_Acute)(_Dieresisacute);

%% \vb\- dieresisacute:\- \PICT{dieresisacute}\-
glyph_axis._dieresisacute:=glyph_axis._dieresis;
acc_glyph(_dieresis)(_Acute)(_dieresisacute);

%% \vb\- Dieresisgrave:\- \PICT{Dieresisgrave}\-
glyph_axis._Dieresisgrave:=glyph_axis._dieresis;
acc_glyph(_Dieresis)(_Grave)(_Dieresisgrave);

%% \vb\- dieresisgrave:\- \PICT{dieresisgrave}\-
glyph_axis._dieresisgrave:=glyph_axis._dieresis;
acc_glyph(_dieresis)(_Grave)(_dieresisgrave);

%% \vb\- Dieresiscaron:\- \PICT{Dieresiscaron}\-
glyph_axis._Dieresiscaron:=glyph_axis._dieresis;
acc_glyph(_Dieresis)(_Caron)(_Dieresiscaron);

%% \vb\- dieresiscaron:\- \PICT{dieresiscaron}\-
glyph_axis._dieresiscaron:=glyph_axis._dieresis;
acc_glyph(_dieresis)(_Caron)(_dieresiscaron);

% accented glyphs

%% \vb\- Aacute:\- \PICT{Aacute}\-
acc_glyph(_A)(_Acute)(_Aacute);

%% \vb\- aacute:\- \PICT{aacute}\-
acc_glyph(_a)(_acute)(_aacute);

%% \vb\- Abreve:\- \PICT{Abreve}\-
acc_glyph(_A)(_Breve)(_Abreve);
glyph_axis._Abreve:=glyph_axis._A;

%% \vb\- abreve:\- \PICT{abreve}\-
acc_glyph(_a)(_breve)(_abreve);
glyph_axis._abreve:=glyph_axis._a;

%% \vb\- Abreveacute:\- \PICT{Abreveacute}\-
acc_glyph(_A)(_Breveacute)(_Abreveacute);

%% \vb\- abreveacute:\- \PICT{abreveacute}\-
acc_glyph(_a)(_breveacute)(_abreveacute);

%% \vb\- Abrevedotbelow:\- \PICT{Abrevedotbelow}\-
local glyph_axis._Abreve:=whatever;
acc_glyph(_Abreve)(_dotbelow)(_Abrevedotbelow);
endlocal;

%% \vb\- abrevedotbelow:\- \PICT{abrevedotbelow}\-
if known is_csc: local glyph_axis._abreve:=whatever; fi
acc_glyph(_abreve)(_dotbelow)(_abrevedotbelow);
if known is_csc: endlocal; fi

%% \vb\- Abrevegrave:\- \PICT{Abrevegrave}\-
acc_glyph(_A)(_Brevegrave)(_Abrevegrave);

%% \vb\- abrevegrave:\- \PICT{abrevegrave}\-
acc_glyph(_a)(_brevegrave)(_abrevegrave);

%% \vb\- Abrevehookabove:\- \PICT{Abrevehookabove}\-
acc_glyph(_A)(_Brevehookabove)(_Abrevehookabove);

%% \vb\- abrevehookabove:\- \PICT{abrevehookabove}\-
acc_glyph(_a)(_brevehookabove)(_abrevehookabove);

%% \vb\- Abrevetilde:\- \PICT{Abrevetilde}\-
acc_glyph(_A)(_Brevetilde)(_Abrevetilde);

%% \vb\- abrevetilde:\- \PICT{abrevetilde}\-
acc_glyph(_a)(_brevetilde)(_abrevetilde);

%% \vb\- Acaron:\- \PICT{Acaron}\-
acc_glyph(_A)(_Caron)(_Acaron);
glyph_axis._Acaron:=glyph_axis._A;

%% \vb\- acaron:\- \PICT{acaron}\-
acc_glyph(_a)(_caron)(_acaron);
glyph_axis._acaron:=glyph_axis._a;

%% \vb\- Acircumflex:\- \PICT{Acircumflex}\-
acc_glyph(_A)(_Circumflex)(_Acircumflex);
glyph_axis._Acircumflex:=glyph_axis._A;

%% \vb\- acircumflex:\- \PICT{acircumflex}\-
acc_glyph(_a)(_circumflex)(_acircumflex);
glyph_axis._acircumflex:=glyph_axis._a;

%% \vb\- Acircumflexacute:\- \PICT{Acircumflexacute}\-
acc_glyph(_A)(_Circumflexacute)(_Acircumflexacute);

%% \vb\- acircumflexacute:\- \PICT{acircumflexacute}\-
acc_glyph(_a)(_circumflexacute)(_acircumflexacute);

%% \vb\- Acircumflexdotbelow:\- \PICT{Acircumflexdotbelow}\-
local glyph_axis._Acircumflex:=whatever;
acc_glyph(_Acircumflex)(_dotbelow)(_Acircumflexdotbelow);
endlocal;

%% \vb\- acircumflexdotbelow:\- \PICT{acircumflexdotbelow}\-
if known is_csc: local glyph_axis._acircumflex:=whatever; fi
acc_glyph(_acircumflex)(_dotbelow)(_acircumflexdotbelow);
if known is_csc: endlocal; fi

%% \vb\- Acircumflexgrave:\- \PICT{Acircumflexgrave}\-
acc_glyph(_A)(_Circumflexgrave)(_Acircumflexgrave);

%% \vb\- acircumflexgrave:\- \PICT{acircumflexgrave}\-
acc_glyph(_a)(_circumflexgrave)(_acircumflexgrave);

%% \vb\- Acircumflexhookabove:\- \PICT{Acircumflexhookabove}\-
acc_glyph(_A)(_Circumflexhookabove)(_Acircumflexhookabove);

%% \vb\- acircumflexhookabove:\- \PICT{acircumflexhookabove}\-
acc_glyph(_a)(_circumflexhookabove)(_acircumflexhookabove);

%% \vb\- Acircumflextilde:\- \PICT{Acircumflextilde}\-
acc_glyph(_A)(_Circumflextilde)(_Acircumflextilde);

%% \vb\- acircumflextilde:\- \PICT{acircumflextilde}\-
acc_glyph(_a)(_circumflextilde)(_acircumflextilde);

%% \vb\- Adblgrave:\- \PICT{Adblgrave}\-
acc_glyph(_A)(_dblGrave)(_Adblgrave)(-1/2u,0);

%% \vb\- adblgrave:\- \PICT{adblgrave}\-
acc_glyph(_a)(_dblgrave)(_adblgrave)(0 if known is_csc: -2/5u fi, 0);

%% \vb\- Adieresis:\- \PICT{Adieresis}\-
acc_glyph(_A)(_Dieresis)(_Adieresis);

%% \vb\- adieresis:\- \PICT{adieresis}\-
acc_glyph(_a)(_dieresis)(_adieresis);

%% \vb\- Adotbelow:\- \PICT{Adotbelow}\-
local glyph_axis._A:=whatever;
acc_glyph(_A)(_dotbelow)(_Adotbelow);
endlocal;

%% \vb\- adotbelow:\- \PICT{adotbelow}\-
if known is_csc: local glyph_axis._a:=whatever; fi
acc_glyph(_a)(_dotbelow)(_adotbelow);
if known is_csc: endlocal; fi

%% \vb\- AEacute:\- \PICT{AEacute}\-
acc_glyph(_AE)(_Acute)(_AEacute);

%% \vb\- aeacute:\- \PICT{aeacute}\-
acc_glyph(_ae)(_acute)(_aeacute);

%% \vb\- Agrave:\- \PICT{Agrave}\-
acc_glyph(_A)(_Grave)(_Agrave);

%% \vb\- agrave:\- \PICT{agrave}\-
acc_glyph(_a)(_grave)(_agrave);

%% \vb\- Ahookabove:\- \PICT{Ahookabove}\-
acc_glyph(_A)(_Hookabove)(_Ahookabove) if serifs: (0,o) fi;

%% \vb\- ahookabove:\- \PICT{ahookabove}\-
acc_glyph(_a)(_hookabove)(_ahookabove);

%% \vb\- Amacron:\- \PICT{Amacron}\-
acc_glyph(_A)(_Macron)(_Amacron);

%% \vb\- amacron:\- \PICT{amacron}\-
acc_glyph(_a)(_macron)(_amacron);

%% \vb\- Aogonekacute:\- \PICT{Aogonekacute}\-
acc_glyph(_Aogonek)(_Acute)(_Aogonekacute);

%% \vb\- aogonekacute:\- \PICT{aogonekacute}\-
acc_glyph(_aogonek)(_acute)(_aogonekacute);

%% \vb\- Aring:\- \PICT{Aring}\-
acc_glyph(_A)(_Ring)(_Aring);

%% \vb\- aring:\- \PICT{aring}\-
acc_glyph(_a)(_ring)(_aring);

%% \vb\- Aringacute:\- \PICT{Aringacute}\-
acc_glyph(_A)(_Ringacute)(_Aringacute);

%% \vb\- aringacute:\- \PICT{aringacute}\-
acc_glyph(_a)(_ringacute)(_aringacute);

%% \vb\- Atilde:\- \PICT{Atilde}\-
acc_glyph(_A)(_Tilde)(_Atilde);

%% \vb\- atilde:\- \PICT{atilde}\-
acc_glyph(_a)(_tilde)(_atilde);

%% \vb\- Cacute:\- \PICT{Cacute}\-
acc_glyph(_C)(_Acute)(_Cacute);

%% \vb\- cacute:\- \PICT{cacute}\-
acc_glyph(_c)(_acute)(_cacute);

%% \vb\- Ccaron:\- \PICT{Ccaron}\-
acc_glyph(_C)(_Caron)(_Ccaron);

%% \vb\- ccaron:\- \PICT{ccaron}\-
acc_glyph(_c)(_caron)(_ccaron);

%% \vb\- Ccircumflex:\- \PICT{Ccircumflex}\-
acc_glyph(_C)(_Circumflex)(_Ccircumflex);

%% \vb\- ccircumflex:\- \PICT{ccircumflex}\-
acc_glyph(_c)(_circumflex)(_ccircumflex);

%% \vb\- Cdotaccent:\- \PICT{Cdotaccent}\-
acc_glyph(_C)(_Dotaccent)(_Cdotaccent) if serifs: (0,o) fi;

%% \vb\- cdotaccent:\- \PICT{cdotaccent}\-
acc_glyph(_c)(_dotaccent)(_cdotaccent);

%% \vb\- Dcaron:\- \PICT{Dcaron}\-
acc_glyph(_D)(_Caron)(_Dcaron);

%% \vb\- dcaron:\- \PICT{dcaron}\-
if known is_csc:
 acc_glyph(_d)(_caron)(_dcaron);
else:
 if feasible_three_glyphs(_d)(_commaaccent)(_dcaron):
  beginglyph(_dcaron);
   wd._dcaron:=wd._d;
   save p_,rmost_,s_; path p_; pair s_;
   p_:=if ypart(urcorner(glyph_stored._d1))>ypart(urcorner(glyph_stored._d2)):
    glyph_stored._d1 else: glyph_stored._d2 fi;
   rmost_:=ypart(x_spreading(p_)(y_>.66h_));
   p_:=glyph_stored._commaaccent1;
   s_:=(rmost_+round 2/3u,ht._d)-ulcorner(p_);
   use_glyph("d"); Fill p_ shifted s_;
   use_stems("d"); use_stems("commaaccent") s_;
   standard_exact_hsbw("dcaron");
  endglyph;
 fi
fi

%% \vb\- Ddotbelow:\- \PICT{Ddotbelow}\-
acc_glyph(_D)(_dotbelow)(_Ddotbelow);

%% \vb\- ddotbelow:\- \PICT{ddotbelow}\-
acc_glyph(_d)(_dotbelow)(_ddotbelow);

%% \vb\- Dlinebelow:\- \PICT{Dlinebelow}\-
acc_glyph(_D)(_linebelow)(_Dlinebelow);

%% \vb\- dlinebelow:\- \PICT{dlinebelow}\-
acc_glyph(_d)(_linebelow)(_dlinebelow);

%% \vb\- Eacute:\- \PICT{Eacute}\-
acc_glyph(_E)(_Acute)(_Eacute);

%% \vb\- eacute:\- \PICT{eacute}\-
acc_glyph(_e)(_acute)(_eacute);

%% \vb\- Ebreve:\- \PICT{Ebreve}\-
acc_glyph(_E)(_Breve)(_Ebreve);

%% \vb\- ebreve:\- \PICT{ebreve}\-
acc_glyph(_e)(_breve)(_ebreve);

%% \vb\- Ecaron:\- \PICT{Ecaron}\-
acc_glyph(_E)(_Caron)(_Ecaron);

%% \vb\- ecaron:\- \PICT{ecaron}\-
acc_glyph(_e)(_caron)(_ecaron);

%% \vb\- Ecircumflex:\- \PICT{Ecircumflex}\-
acc_glyph(_E)(_Circumflex)(_Ecircumflex);
glyph_axis._Ecircumflex:=glyph_axis._E;

%% \vb\- ecircumflex:\- \PICT{ecircumflex}\-
acc_glyph(_e)(_circumflex)(_ecircumflex);
glyph_axis._ecircumflex:=glyph_axis._e;

%% \vb\- Ecircumflexacute:\- \PICT{Ecircumflexacute}\-
acc_glyph(_E)(_Circumflexacute)(_Ecircumflexacute);

%% \vb\- ecircumflexacute:\- \PICT{ecircumflexacute}\-
acc_glyph(_e)(_circumflexacute)(_ecircumflexacute);

%% \vb\- Ecircumflexdotbelow:\- \PICT{Ecircumflexdotbelow}\-
local glyph_axis._Ecircumflex:=whatever;
acc_glyph(_Ecircumflex)(_dotbelow)(_Ecircumflexdotbelow);
endlocal;

%% \vb\- ecircumflexdotbelow:\- \PICT{ecircumflexdotbelow}\-
if known is_csc: local glyph_axis._ecircumflex:=whatever; fi
acc_glyph(_ecircumflex)(_dotbelow)(_ecircumflexdotbelow);
if known is_csc: endlocal; fi

%% \vb\- Ecircumflexgrave:\- \PICT{Ecircumflexgrave}\-
acc_glyph(_E)(_Circumflexgrave)(_Ecircumflexgrave);

%% \vb\- ecircumflexgrave:\- \PICT{ecircumflexgrave}\-
acc_glyph(_e)(_circumflexgrave)(_ecircumflexgrave);

%% \vb\- Ecircumflexhookabove:\- \PICT{Ecircumflexhookabove}\-
acc_glyph(_E)(_Circumflexhookabove)(_Ecircumflexhookabove);

%% \vb\- ecircumflexhookabove:\- \PICT{ecircumflexhookabove}\-
acc_glyph(_e)(_circumflexhookabove)(_ecircumflexhookabove);

%% \vb\- Ecircumflextilde:\- \PICT{Ecircumflextilde}\-
acc_glyph(_E)(_Circumflextilde)(_Ecircumflextilde);

%% \vb\- ecircumflextilde:\- \PICT{ecircumflextilde}\-
acc_glyph(_e)(_circumflextilde)(_ecircumflextilde);

%% \vb\- Edblgrave:\- \PICT{Edblgrave}\-
acc_glyph(_E)(_dblGrave)(_Edblgrave);

%% \vb\- edblgrave:\- \PICT{edblgrave}\-
acc_glyph(_e)(_dblgrave)(_edblgrave);

%% \vb\- Edieresis:\- \PICT{Edieresis}\-
acc_glyph(_E)(_Dieresis)(_Edieresis);

%% \vb\- edieresis:\- \PICT{edieresis}\-
acc_glyph(_e)(_dieresis)(_edieresis);

%% \vb\- Edotaccent:\- \PICT{Edotaccent}\-
acc_glyph(_E)(_Dotaccent)(_Edotaccent) if serifs: (0,o) fi;

%% \vb\- edotaccent:\- \PICT{edotaccent}\-
acc_glyph(_e)(_dotaccent)(_edotaccent);

%% \vb\- Edotbelow:\- \PICT{Edotbelow}\-
local glyph_axis._E:=whatever;
acc_glyph(_E)(_dotbelow)(_Edotbelow);
endlocal;

%% \vb\- edotbelow:\- \PICT{edotbelow}\-
if known is_csc: local glyph_axis._e:=whatever; fi
acc_glyph(_e)(_dotbelow)(_edotbelow);
if known is_csc: endlocal; fi

%% \vb\- Egrave:\- \PICT{Egrave}\-
acc_glyph(_E)(_Grave)(_Egrave);

%% \vb\- egrave:\- \PICT{egrave}\-
acc_glyph(_e)(_grave)(_egrave);

%% \vb\- Ehookabove:\- \PICT{Ehookabove}\-
acc_glyph(_E)(_Hookabove)(_Ehookabove) if serifs: (0,o) fi;

%% \vb\- ehookabove:\- \PICT{ehookabove}\-
acc_glyph(_e)(_hookabove)(_ehookabove);

%% \vb\- Emacron:\- \PICT{Emacron}\-
acc_glyph(_E)(_Macron)(_Emacron);

%% \vb\- emacron:\- \PICT{emacron}\-
acc_glyph(_e)(_macron)(_emacron);

%% \vb\- Eogonekacute:\- \PICT{Eogonekacute}\-
acc_glyph(_Eogonek)(_Acute)(_Eogonekacute);

%% \vb\- eogonekacute:\- \PICT{eogonekacute}\-
acc_glyph(_eogonek)(_acute)(_eogonekacute);

%% \vb\- Ereversed:\- \PICT{Ereversed}\-
if feasible_two_glyphs(_E)(_Ereversed):
 beginglyph(_Ereversed);
  save p; path p[];
  restore_glyph("E")(p); z0=center(p1);
  p1:=reverse(p1 reflectedabout ((x0,0),(x0,1)));
  Fill p1;
  for i_:=1 upto hstem_stored._E.num:
   fix_hstem(ypart hstem_stored._E[i_])(p1);
  endfor
  for i_:=1 upto vstem_stored._E.num:
   fix_vstem(ypart vstem_stored._E[i_])(p1);
  endfor
  standard_hsbw("E");
 endglyph;
fi

%% \vb\- ereversed:\- \PICT{ereversed}\-
if feasible_two_glyphs(_e)(_ereversed):
 beginglyph(_ereversed);
 save p; path p[];
  if known is_csc:
   restore_glyph("e")(p); z0=center(p1);
   p1:=reverse(p1 reflectedabout ((x0,0),(x0,1)));
   Fill p1;
   for i_:=1 upto hstem_stored._e.num:
    fix_hstem(ypart hstem_stored._e[i_])(p1);
   endfor
   for i_:=1 upto vstem_stored._e.num:
    fix_vstem(ypart vstem_stored._e[i_])(p1);
   endfor
  else:
   restore_glyph("e")(p);
   if xpart(urcorner p1)>xpart(urcorner p2):
    z0=center(p1);
    p3=p1 reflectedabout ((x0,0),(x0,1));
    p4=p2 reflectedabout ((x0,0),(x0,1));
   else:
    z0=center(p2);
    p3=p2 reflectedabout ((x0,0),(x0,1));
    p4=p1 reflectedabout ((x0,0),(x0,1));
   fi
   Fill reverse p3;  unFill reverse p4;
   for i_:=1 upto hstem_stored._e.num:
    fix_hstem(ypart hstem_stored._e[i_])(p3,p4);
   endfor
   for i_:=1 upto vstem_stored._e.num:
    fix_vstem(ypart vstem_stored._e[i_])(p3,p4);
   endfor
  fi
  standard_hsbw("e");
 endglyph;
fi

%% \vb\- Etilde:\- \PICT{Etilde}\-
acc_glyph(_E)(_Tilde)(_Etilde);

%% \vb\- etilde:\- \PICT{etilde}\-
acc_glyph(_e)(_tilde)(_etilde);

%% \vb\- eturned:\- \PICT{eturned}\-
if feasible_two_glyphs(_e)(_eturned):
 beginglyph(_eturned);
 save p; path p[];
  if known is_csc:
   restore_glyph("e")(p); z0=center(p1);
   p1:=p1 rotatedaround (z0,180);
   Fill p1;
   for i_:=1 upto hstem_stored._e.num:
    fix_hstem(ypart hstem_stored._e[i_])(p1);
   endfor
   for i_:=1 upto vstem_stored._e.num:
    fix_vstem(ypart vstem_stored._e[i_])(p1);
   endfor
  else:
   restore_glyph("e")(p);
   if xpart(urcorner p1)>xpart(urcorner p2):
    z0=center(p1);
    p3=p1 rotatedaround (z0,180);
    p4=p2 rotatedaround (z0,180);
   else:
    z0=center(p2);
    p3=p2 rotatedaround (z0,180);
    p4=p1 rotatedaround (z0,180);
   fi
   Fill p3; unFill p4;
   for i_:=1 upto hstem_stored._e.num:
    fix_hstem(ypart hstem_stored._e[i_])(p3,p4);
   endfor
   for i_:=1 upto vstem_stored._e.num:
    fix_vstem(ypart vstem_stored._e[i_])(p3,p4);
   endfor
  fi
  standard_hsbw("e");
 endglyph;
fi

dup_glyph(_eturned)(_schwa); % `schwa' seems to be a fairly popular glyph...

%% \vb\- Gacute:\- \PICT{Gacute}\-
acc_glyph(_G)(_Acute)(_Gacute);

%% \vb\- gacute:\- \PICT{gacute}\-
acc_glyph(_g)(_acute)(_gacute);

%% \vb\- Gbreve:\- \PICT{Gbreve}\-
acc_glyph(_G)(_Breve)(_Gbreve);

%% \vb\- gbreve:\- \PICT{gbreve}\-
acc_glyph(_g)(_breve)(_gbreve);

%% \vb\- Gcaron:\- \PICT{Gcaron}\-
acc_glyph(_G)(_Caron)(_Gcaron);

%% \vb\- gcaron:\- \PICT{gcaron}\-
acc_glyph(_g)(_caron)(_gcaron);

%% \vb\- Gcircumflex:\- \PICT{Gcircumflex}\-
acc_glyph(_G)(_Circumflex)(_Gcircumflex);

%% \vb\- gcircumflex:\- \PICT{gcircumflex}\-
acc_glyph(_g)(_circumflex)(_gcircumflex);

%% \vb\- Gcommaaccent:\- \PICT{Gcommaaccent}\-
acc_glyph(_G)(_commaaccent)(_Gcommaaccent);

%% \vb\- gcommaaccent:\- \PICT{gcommaaccent}\-
if known is_csc:
 acc_glyph(_g)(_commaaccent)(_gcommaaccent);
else:
 if feasible_three_glyphs(_g)(_commaaccent)(_gcommaaccent):
  wd._gcommaaccent:=wd._g;
  beginglyph(_gcommaaccent);
   save p_, was_ghost_top_; path p_;
   p_=glyph_stored._commaaccent1;
   z0=round(center p_);
   p_:=p_ rotatedaround (z0,180);
   p_:=p_ shifted (glyph_axis._g-x0,
    accent_haxis-y0+o if known is_ssq: +25 if known is_bold: +35 fi fi);
   Fill p_; use_glyph("g"); use_stems("g");
   for i_:=1 upto hstem_stored._commaaccent.num:
    if ypart(hstem_stored._commaaccent[i_])>0:
     fix_hstem(ypart(hstem_stored._commaaccent[i_]))(p_);
    fi
   endfor  
   if slang=0:
    for i_:=1 upto vstem_stored._commaaccent.num:
     if ypart(vstem_stored._commaaccent[i_])>0:
      fix_vstem(ypart(vstem_stored._commaaccent[i_]))(p_);
     fi
    endfor
   fi
   ghost_stem top;
   standard_exact_hsbw("gcommaaccent");
  endglyph;
 fi
fi

%% \vb\- Gdotaccent:\- \PICT{Gdotaccent}\-
acc_glyph(_G)(_Dotaccent)(_Gdotaccent) if serifs: (0,o) fi;

%% \vb\- gdotaccent:\- \PICT{gdotaccent}\-
acc_glyph(_g)(_dotaccent)(_gdotaccent);

%% \vb\- Hbrevebelow:\- \PICT{Hbrevebelow}\-
acc_glyph(_H)(_brevebelow)(_Hbrevebelow);

%% \vb\- hbrevebelow:\- \PICT{hbrevebelow}\-
local glyph_axis._h:=
  if is_stored(_h): round(xpart(center(glyph_stored._h1)));
  else: whatever fi;
 acc_glyph(_h)(_brevebelow)(_hbrevebelow);
endlocal;

%% \vb\- Hcircumflex:\- \PICT{Hcircumflex}\-
acc_glyph(_H)(_Circumflex)(_Hcircumflex);

%% \vb\- hcircumflex:\- \PICT{hcircumflex}\-
if known is_csc:
 acc_glyph(_h)(_circumflex)(_hcircumflex);
else:
 local glyph_axis._h:=whatever;
  acc_glyph(_h)(_Circumflex)(_hcircumflex);
 endlocal;
fi

%% \vb\- Hdieresis:\- \PICT{Hdieresis}\-
acc_glyph(_H)(_Dieresis)(_Hdieresis);

%% \vb\- hdieresis:\- \PICT{hdieresis}\-
if known is_csc:
 acc_glyph(_h)(_dieresis)(_hdieresis);
else:
 local glyph_axis._h:=whatever;
  acc_glyph(_h)(_Dieresis)(_hdieresis);
 endlocal;
fi

%% \vb\- Hdotbelow:\- \PICT{Hdotbelow}\-
acc_glyph(_H)(_dotbelow)(_Hdotbelow);

%% \vb\- hdotbelow:\- \PICT{hdotbelow}\-
if known is_csc:
 acc_glyph(_h)(_dotbelow)(_hdotbelow);
else:
 local glyph_axis._h:=
   if is_stored(_h): round(xpart(center(glyph_stored._h1)));
   else: whatever fi;
  acc_glyph(_h)(_dotbelow)(_hdotbelow);
 endlocal;
fi

%% \vb\- Htilde:\- \PICT{Htilde}\-
acc_glyph(_H)(_Tilde)(_Htilde);

%% \vb\- htilde:\- \PICT{htilde}\-
if known is_csc:
 acc_glyph(_h)(_tilde)(_htilde);
else:
 local glyph_axis._h:=whatever;
  acc_glyph(_h)(_Tilde)(_htilde);
 endlocal;
fi

%% \vb\- Iacute:\- \PICT{Iacute}\-
def xb_acc_glyph =
 if not serifs:
  local glyph_axis._Acute:=xpart(llcorner(glyph_stored._Acute1));
  local glyph_axis._I:=xpart(llcorner(glyph_stored._I1));
 fi
enddef;
def xe_acc_glyph =
 if not serifs: endlocal; endlocal; fi
enddef;
acc_glyph(_I)(_Acute)(_Iacute);

%% \vb\- iacute:\- \PICT{iacute}\-
def xb_acc_glyph =
 if not serifs:
  local glyph_axis._acute:=xpart(llcorner(glyph_stored._acute1));
  local glyph_axis._dotlessi:=xpart(llcorner(glyph_stored._dotlessi1));
 fi
enddef;
def xe_acc_glyph =
 if not serifs: endlocal; endlocal; fi
enddef;
acc_glyph(_dotlessi)(_acute)(_iacute);

%% \vb\- Ibreve:\- \PICT{Ibreve}\-
acc_glyph(_I)(_Breve)(_Ibreve);

%% \vb\- ibreve:\- \PICT{ibreve}\-
acc_glyph(_dotlessi)(_breve)(_ibreve);

%% \vb\- Icaron:\- \PICT{Icaron}\-
acc_glyph(_I)(_Caron)(_Icaron);

%% \vb\- icaron:\- \PICT{icaron}\-
acc_glyph(_dotlessi)(_caron)(_icaron);

%% \vb\- Icircumflex:\- \PICT{Icircumflex}\-
acc_glyph(_I)(_Circumflex)(_Icircumflex);

%% \vb\- icircumflex:\- \PICT{icircumflex}\-
acc_glyph(_dotlessi)(_circumflex)(_icircumflex);

%% \vb\- Idblgrave:\- \PICT{Idblgrave}\-
acc_glyph(_I)(_dblGrave)(_Idblgrave);

%% \vb\- idblgrave:\- \PICT{idblgrave}\-
acc_glyph(_dotlessi)(_dblgrave)(_idblgrave);

%% \vb\- Idieresis:\- \PICT{Idieresis}\-
acc_glyph(_I)(_Dieresis)(_Idieresis);

%% \vb\- idieresis:\- \PICT{idieresis}\-
acc_glyph(_dotlessi)(_dieresis)(_idieresis);

%% \vb\- Idieresisacute:\- \PICT{Idieresisacute}\-
acc_glyph(_I)(_Dieresisacute)(_Idieresisacute);

%% \vb\- idieresisacute:\- \PICT{idieresisacute}\-
acc_glyph(_dotlessi)(_dieresisacute)(_idieresisacute);

%% \vb\- Idotaccent:\- \PICT{Idotaccent}\-
acc_glyph(_I)(_Dotaccent)(_Idotaccent) if serifs: (0,o) fi;

%% \vb\- Idotbelow:\- \PICT{Idotbelow}\-
acc_glyph(_I)(_dotbelow)(_Idotbelow);

%% \vb\- idotbelow:\- \PICT{idotbelow}\-
acc_glyph(_i)(_dotbelow)(_idotbelow);

%% \vb\- Igrave:\- \PICT{Igrave}\-
def xb_acc_glyph =
 if not serifs:
  local glyph_axis._Grave:=xpart(urcorner(glyph_stored._Grave1));
  local glyph_axis._I:=xpart(urcorner(glyph_stored._I1));
 fi
enddef;
def xe_acc_glyph =
 if not serifs: endlocal; endlocal; fi
enddef;
acc_glyph(_I)(_Grave)(_Igrave);

%% \vb\- igrave:\- \PICT{igrave}\-
def xb_acc_glyph =
 if not serifs:
  local glyph_axis._grave:=xpart(urcorner(glyph_stored._grave1));
  local glyph_axis._dotlessi:=xpart(urcorner(glyph_stored._dotlessi1));
 fi
enddef;
def xe_acc_glyph =
 if not serifs: endlocal; endlocal; fi
enddef;
acc_glyph(_dotlessi)(_grave)(_igrave);

%% \vb\- Ihookabove:\- \PICT{Ihookabove}\-
acc_glyph(_I)(_Hookabove)(_Ihookabove) if serifs: (0,o) fi;

%% \vb\- ihookabove:\- \PICT{ihookabove}\-
acc_glyph(_dotlessi)(_hookabove)(_ihookabove);

%% \vb\- Imacron:\- \PICT{Imacron}\-
acc_glyph(_I)(_Macron)(_Imacron);

%% \vb\- imacron:\- \PICT{imacron}\-
acc_glyph(_dotlessi)(_macron)(_imacron);

%% \vb\- Imacron.alt:\- \PICT{Imacron.alt}\-
acc_glyph(_I)(_Macron.alt)(_Imacron.alt);

%% \vb\- imacron.alt:\- \PICT{imacron.alt}\-
acc_glyph(_dotlessi)(_macron.alt)(_imacron.alt);

%% \vb\- Iogonekacute:\- \PICT{Iogonekacute}\-
def xb_acc_glyph =
 if not serifs:
  local glyph_axis._Acute:=xpart(llcorner(glyph_stored._Acute1));
  local glyph_axis._Iogonek:=xpart(x_spreading(glyph_stored._Iogonek1)(y_>0));
 fi
enddef;
def xe_acc_glyph =
 if not serifs: endlocal; endlocal; fi
enddef;
acc_glyph(_Iogonek)(_Acute)(_Iogonekacute);

%% \vb\- iogonekacute:\- \PICT{iogonekacute}\-
if known is_csc: % so far, there are no ss csc...
 acc_glyph(_iogonek)(_acute)(_iogonekacute);
else:
 if feasible_three_glyphs(_iogonek)(_acute)(_iogonekacute):
  beginglyph(_iogonekacute);
   save p_,q_,s_; path p_,q_;
   wd._iogonekacute:=wd._iogonek;
   p_:=if ypart(urcorner(glyph_stored._iogonek1))>
     ypart(urcorner(glyph_stored._iogonek2)):
    glyph_stored._iogonek2 else: glyph_stored._iogonek1 fi;
   q_:=glyph_stored._acute1;
   if not serifs:
    local glyph_axis._acute:=xpart(llcorner(q_));
    local glyph_axis._iogonek:=xpart(x_spreading(p_)(y_>0));
   fi
   s_:=if known glyph_axis._iogonek: glyph_axis._iogonek
     else: 1/2wd._iogonekacute fi -
    if known glyph_axis._acute: glyph_axis._acute
     else: 1/2wd._acute fi;
   Fill p_; Fill q_ shifted (s_,0);
   use_stems("iogonek"); use_stems("acute") (s_,0);
   standard_exact_hsbw("iogonekacute");
   if not serifs: endlocal; endlocal; fi
  endglyph;
 fi
fi

%% \vb\- Itilde:\- \PICT{Itilde}\-
acc_glyph(_I)(_Tilde)(_Itilde);

%% \vb\- itilde:\- \PICT{itilde}\-
acc_glyph(_dotlessi)(_tilde)(_itilde);

%% \vb\- Jacute (see T\~a{\'\j}a in D.~E.~Knuth's testfont):\- \PICT{Jacute}\-
def xb_acc_glyph =
 if not serifs:
  local glyph_axis._Acute:=xpart(llcorner(glyph_stored._Acute1));
  local glyph_axis._J:=xpart(x_spreading(glyph_stored._J1)(y_>0.5h_));
 fi
enddef;
def xe_acc_glyph =
 if not serifs: endlocal; endlocal; fi
enddef;
acc_glyph(_J)(_Acute)(_Jacute);

%% \vb\- jacute (see T\~a{\'\j}a in D.~E.~Knuth's testfont):\- \PICT{jacute}\-
def xb_acc_glyph =
 if not serifs:
  local glyph_axis._acute:=xpart(llcorner(glyph_stored._acute1));
  local glyph_axis._dotlessj:=xpart(x_spreading(glyph_stored._dotlessj1)(y_>0.5h_));
 fi
enddef;
def xe_acc_glyph =
 if not serifs: endlocal; endlocal; fi
enddef;
acc_glyph(_dotlessj)(_acute)(_jacute);

%% \vb\- J_caron (sic!):\- \PICT{J_caron}\-
if feasible_three_glyphs(_J)(_commaaccent)(_J_caron):
 wd._J_caron:=wd._J;
 beginglyph(_J_caron);
  save p_,rmost_,s_; path p_; pair s_;
  p_=glyph_stored._commaaccent1;
  rmost_:=ypart(x_spreading(glyph_stored._J1)(y_>.66h_));
  s_=(rmost_+round 2/3u, ht._J)-ulcorner(p_);
  use_glyph("J"); Fill p_ shifted s_;
  use_stems("J"); use_stems("commaaccent") s_;
  standard_exact_hsbw("J_caron");
 endglyph;
fi

%% \vb\- jcaron:\- \PICT{jcaron}\-
acc_glyph(_dotlessj)(_caron)(_jcaron);

%% \vb\- Jcircumflex:\- \PICT{Jcircumflex}\-
acc_glyph(_J)(_Circumflex)(_Jcircumflex);

%% \vb\- jcircumflex:\- \PICT{jcircumflex}\-
acc_glyph(_dotlessj)(_circumflex)(_jcircumflex);

%% \vb\- Kcommaaccent:\- \PICT{Kcommaaccent}\-
acc_glyph(_K)(_commaaccent)(_Kcommaaccent);

%% \vb\- kcommaaccent:\- \PICT{kcommaaccent}\-
acc_glyph(_k)(_commaaccent)(_kcommaaccent);

%% \vb\- Lacute:\- \PICT{Lacute}\-
def xb_acc_glyph =
 if not serifs:
  local glyph_axis._Acute:=xpart(llcorner(glyph_stored._Acute1));
  local glyph_axis._L:=xpart(x_spreading(glyph_stored._L1)(y_>0));
 fi
enddef;
def xe_acc_glyph =
 if not serifs: endlocal; endlocal; fi
enddef;
acc_glyph(_L)(_Acute)(_Lacute);

%% \vb\- lacute:\- \PICT{lacute}\-
def xb_acc_glyph =
 if not serifs:
  if known is_csc: % at the moment, |is_csc| is unknown for sans serif fonts
   local glyph_axis._acute:=xpart(llcorner(glyph_stored._acute1));
  else:
   local glyph_axis._Acute:=xpart(llcorner(glyph_stored._Acute1));
  fi
  local glyph_axis._l:=xpart(x_spreading(glyph_stored._l1)(y_>0));
 fi
enddef;
def xe_acc_glyph =
 if not serifs: endlocal; endlocal; fi
enddef;
if known is_csc:
 acc_glyph(_l)(_acute)(_lacute);
else:
 acc_glyph(_l)(_Acute)(_lacute);
fi

%% \vb\- Lcaron (sic!):\- \PICT{Lcaron}\-
if feasible_three_glyphs(_L)(_commaaccent)(_Lcaron):
 wd._Lcaron:=wd._L;
 beginglyph(_Lcaron);
  save p_,rmost_,s_; path p_; pair s_;
  p_=glyph_stored._commaaccent1;
  rmost_:=ypart(x_spreading(glyph_stored._L1)(y_>.66h_));
  s_=(rmost_+round u, ht._L)-ulcorner(p_);
  use_glyph("L"); Fill p_ shifted s_;
  use_stems("L"); use_stems("commaaccent") s_;
  standard_exact_hsbw("Lcaron");
 endglyph;
fi

%% \vb\- lcaron (sic!):\- \PICT{lcaron}\-
if feasible_three_glyphs(_l)(_commaaccent)(_lcaron):
 wd._lcaron:=wd._l;
 beginglyph(_lcaron);
  save p_,rmost_,s_; path p_; pair s_;
  p_=glyph_stored._commaaccent1;
  rmost_:=ypart(x_spreading(glyph_stored._l1)(y_>.66h_));
  s_=(rmost_+round 2/3u, ht._l)-ulcorner(p_);
  use_glyph("l"); Fill p_ shifted s_;
  use_stems("l"); use_stems("commaaccent") s_;
  standard_exact_hsbw("lcaron");
 endglyph;
fi

%% \vb\- Lcommaaccent:\- \PICT{Lcommaaccent}\-
local glyph_axis._L:=whatever;
acc_glyph(_L)(_commaaccent)(_Lcommaaccent);
endlocal;

%% \vb\- lcommaaccent:\- \PICT{lcommaaccent}\-
if known is_csc: local glyph_axis._l:=whatever; fi
acc_glyph(_l)(_commaaccent)(_lcommaaccent);
if known is_csc: endlocal; fi

%% \vb\- Ldot:\- \PICT{Ldot}\-
if feasible_three_glyphs(_L)(_dotaccent)(_Ldot):
 wd._Ldot:=wd._L;
 beginglyph(_Ldot);
  save a_,c_,p_; path p_;
  a_:=round(if not serifs or monospace or known is_vtt: 1/2 
               else: if known is_bold: 3/5 else: 5/9 fi fi asc_height);
  p_=glyph_stored._dotaccent1; z0=round center(p_); p_:=p_ shifted -z0;
  y=overshoot+a_ if known Ldot_ycor: + Ldot_ycor fi;
  (x.l,x.r)=left_vstem_pos(glyph_stored._L1,y);
  x=round 1/2(wd._Ldot+x.r+x.l);
  use_glyph("L"); Fill p_ shifted z; use_stems("dotaccent") (x-x0,y-y0);
  standard_hsbw("Ldot");
  % |draw glyph_stored._L1 italicized shifted (wd._Ldot,0);|
 endglyph;
fi

%% \vb\- ldot:\- \PICT{ldot}\-
if feasible_three_glyphs(_l)(_dotaccent)(_ldot):
 wd._ldot:=wd._l;
 beginglyph(_ldot);
  save a_,c_,d_,p_; path p_;
  p_=glyph_stored._dotaccent1; z0=round center(p_); p_:=p_ shifted -z0;
  if known is_csc:
   a_=round(if monospace: 1/2asc_height else: math_axis + 3/4stem fi);
   y=overshoot+a_ if known ldot_ycor: + ldot_ycor fi;
   (x.l,x.r)=left_vstem_pos(glyph_stored._l1,y);
  else:
   a_=round 1/2asc_height;
   d_=xpart(urcorner p_ - llcorner p_);
   y:=overshoot+a_ if known ldot_ycor: + ldot_ycor fi;
   (x.l,x.r)=left_vstem_pos(glyph_stored._l1,y);
   x:=round 1/2(wd._ldot+x.r+x.l); % if |wd._ldot| changes, |x| may change
   if not monospace:
    if (x-1/2d_-x.r)<if serifs: hair else: vair fi: 
     wd._ldot:=wd._ldot+2if serifs: hair else: vair fi-2x+d_+2x.r; 
    fi
   fi
  fi
  x:=round 1/2(wd._ldot+x.r+x.l);
  use_glyph("l"); Fill p_ shifted z; use_stems("dotaccent") (x-x0,y-y0);
  standard_hsbw("ldot");
  % |draw glyph_stored._l1 italicized shifted (wd._ldot,0);|
 endglyph;
fi

%% \vb\- Ldotbelow:\- \PICT{Ldotbelow}\-
local glyph_axis._L:=whatever;
acc_glyph(_L)(_dotbelow)(_Ldotbelow);
endlocal;

%% \vb\- ldotbelow:\- \PICT{ldotbelow}\-
local glyph_axis._l:=whatever;
acc_glyph(_l)(_dotbelow)(_ldotbelow);
endlocal;

%% \vb\- Ldotbelowmacron:\- \PICT{Ldotbelowmacron}\-
def xb_acc_glyph =
 save xsl_, xsr_; (xsl_, xsr_)=x_spreading(glyph_stored._L1)(y_>2/3h_);
 local glyph_axis._Ldotbelow:=1/2[xsl_, xsr_];
enddef;
def xe_acc_glyph =
 endlocal;
enddef;
acc_glyph(_Ldotbelow)(_Macron)(_Ldotbelowmacron);

%% \vb\- ldotbelowmacron:\- \PICT{ldotbelowmacron}\-
def xe_acc_glyph =
 endlocal;
enddef;
if known is_csc:
 def xb_acc_glyph =
  save xsl_, xsr_; (xsl_, xsr_)=x_spreading(glyph_stored._l1)(y_>2/3h_);
  local glyph_axis._ldotbelow:=1/2[xsl_, xsr_];
 enddef;
 acc_glyph(_ldotbelow)(_macron)(_ldotbelowmacron);
else:
 def xb_acc_glyph =
  save xsl_, xsr_; (xsl_, xsr_)=x_spreading(glyph_stored._l1)(y_>2/3h_);
  local glyph_axis._ldotbelow:=round 2/3[xsl_, xsr_];
 enddef;
 acc_glyph(_ldotbelow)(_Macron)(_ldotbelowmacron);
fi

%% \vb\- Ltilde:\- \PICT{Ltilde}\-
acc_glyph(_L)(_Tilde)(_Ltilde);

%% \vb\- ltilde:\- \PICT{ltilde}\-
if known is_csc:
 acc_glyph(_l)(_tilde)(_ltilde);
else:
 acc_glyph(_l)(_Tilde)(_ltilde);
fi

%% \vb\- Mdotbelow:\- \PICT{Mdotbelow}\-
acc_glyph(_M)(_dotbelow)(_Mdotbelow);

%% \vb\- mdotbelow:\- \PICT{mdotbelow}\-
acc_glyph(_m)(_dotbelow)(_mdotbelow);

%% \vb\- Nacute:\- \PICT{Nacute}\-
acc_glyph(_N)(_Acute)(_Nacute);

%% \vb\- nacute:\- \PICT{nacute}\-
acc_glyph(_n)(_acute)(_nacute);

%% \vb\- Ncaron:\- \PICT{Ncaron}\-
acc_glyph(_N)(_Caron)(_Ncaron);

%% \vb\- ncaron:\- \PICT{ncaron}\-
acc_glyph(_n)(_caron)(_ncaron);

%% \vb\- Ncommaaccent:\- \PICT{Ncommaaccent}\-
acc_glyph(_N)(_commaaccent)(_Ncommaaccent);

%% \vb\- ncommaaccent:\- \PICT{ncommaaccent}\-
acc_glyph(_n)(_commaaccent)(_ncommaaccent);

%% \vb\- Ndotaccent:\- \PICT{Ndotaccent}\-
acc_glyph(_N)(_Dotaccent)(_Ndotaccent);

%% \vb\- ndotaccent:\- \PICT{ndotaccent}\-
acc_glyph(_n)(_dotaccent)(_ndotaccent);

%% \vb\- Ndotbelow:\- \PICT{Ndotbelow}\-
acc_glyph(_N)(_dotbelow)(_Ndotbelow);

%% \vb\- ndotbelow:\- \PICT{ndotbelow}\-
acc_glyph(_n)(_dotbelow)(_ndotbelow);

%% \vb\- Ntilde:\- \PICT{Ntilde}\-
acc_glyph(_N)(_Tilde)(_Ntilde);

%% \vb\- ntilde:\- \PICT{ntilde}\-
acc_glyph(_n)(_tilde)(_ntilde);

%% \vb\- Oacute:\- \PICT{Oacute}\-
acc_glyph(_O)(_Acute)(_Oacute);

%% \vb\- oacute:\- \PICT{oacute}\-
acc_glyph(_o)(_acute)(_oacute);

%% \vb\- Obreve:\- \PICT{Obreve}\-
acc_glyph(_O)(_Breve)(_Obreve);

%% \vb\- obreve:\- \PICT{obreve}\-
acc_glyph(_o)(_breve)(_obreve);

%% \vb\- Ocaron:\- \PICT{Ocaron}\-
acc_glyph(_O)(_Caron)(_Ocaron);

%% \vb\- ocaron:\- \PICT{ocaron}\-
acc_glyph(_o)(_caron)(_ocaron);

%% \vb\- Ocircumflex:\- \PICT{Ocircumflex}\-
acc_glyph(_O)(_Circumflex)(_Ocircumflex);

%% \vb\- ocircumflex:\- \PICT{ocircumflex}\-
acc_glyph(_o)(_circumflex)(_ocircumflex);

%% \vb\- Ocircumflexacute:\- \PICT{Ocircumflexacute}\-
acc_glyph(_O)(_Circumflexacute)(_Ocircumflexacute);

%% \vb\- ocircumflexacute:\- \PICT{ocircumflexacute}\-
acc_glyph(_o)(_circumflexacute)(_ocircumflexacute);

%% \vb\- Ocircumflexdotbelow:\- \PICT{Ocircumflexdotbelow}\-
acc_glyph(_Ocircumflex)(_dotbelow)(_Ocircumflexdotbelow);

%% \vb\- ocircumflexdotbelow:\- \PICT{ocircumflexdotbelow}\-
acc_glyph(_ocircumflex)(_dotbelow)(_ocircumflexdotbelow);

%% \vb\- Ocircumflexgrave:\- \PICT{Ocircumflexgrave}\-
acc_glyph(_O)(_Circumflexgrave)(_Ocircumflexgrave);

%% \vb\- ocircumflexgrave:\- \PICT{ocircumflexgrave}\-
acc_glyph(_o)(_circumflexgrave)(_ocircumflexgrave);

%% \vb\- Ocircumflexhookabove:\- \PICT{Ocircumflexhookabove}\-
acc_glyph(_O)(_Circumflexhookabove)(_Ocircumflexhookabove);

%% \vb\- ocircumflexhookabove:\- \PICT{ocircumflexhookabove}\-
acc_glyph(_o)(_circumflexhookabove)(_ocircumflexhookabove);

%% \vb\- Ocircumflextilde:\- \PICT{Ocircumflextilde}\-
acc_glyph(_O)(_Circumflextilde)(_Ocircumflextilde);

%% \vb\- ocircumflextilde:\- \PICT{ocircumflextilde}\-
acc_glyph(_o)(_circumflextilde)(_ocircumflextilde);

%% \vb\- Odblgrave:\- \PICT{Odblgrave}\-
acc_glyph(_O)(_dblGrave)(_Odblgrave);

%% \vb\- odblgrave:\- \PICT{odblgrave}\-
acc_glyph(_o)(_dblgrave)(_odblgrave);

%% \vb\- Odieresis:\- \PICT{Odieresis}\-
acc_glyph(_O)(_Dieresis)(_Odieresis);

%% \vb\- odieresis:\- \PICT{odieresis}\-
acc_glyph(_o)(_dieresis)(_odieresis);

%% \vb\- Odotbelow:\- \PICT{Odotbelow}\-
acc_glyph(_O)(_dotbelow)(_Odotbelow);

%% \vb\- odotbelow:\- \PICT{odotbelow}\-
acc_glyph(_o)(_dotbelow)(_odotbelow);

%% \vb\- Ograve:\- \PICT{Ograve}\-
acc_glyph(_O)(_Grave)(_Ograve);

%% \vb\- ograve:\- \PICT{ograve}\-
acc_glyph(_o)(_grave)(_ograve);

%% \vb\- Ohookabove:\- \PICT{Ohookabove}\-
acc_glyph(_O)(_Hookabove)(_Ohookabove) if serifs: (0,o) fi;

%% \vb\- ohookabove:\- \PICT{ohookabove}\-
acc_glyph(_o)(_hookabove)(_ohookabove);

%% \vb\- Ohornacute:\- \PICT{Ohornacute}\-
local ht._Ohorn:=uc_height;
acc_glyph(_Ohorn)(_Acute)(_Ohornacute)(-1/2u,0);
endlocal

%% \vb\- ohornacute:\- \PICT{ohornacute}\-
local ht._ohorn:=x_height;
acc_glyph(_ohorn)(_acute)(_ohornacute)(-1/2u,0);
endlocal

%% \vb\- Ohorndotbelow:\- \PICT{Ohorndotbelow}\-
local glyph_axis._Ohorn:=whatever;
acc_glyph(_Ohorn)(_dotbelow)(_Ohorndotbelow);
endlocal;

%% \vb\- ohorndotbelow:\- \PICT{ohorndotbelow}\-
local glyph_axis._ohorn:=whatever;
acc_glyph(_ohorn)(_dotbelow)(_ohorndotbelow);
endlocal;

%% \vb\- Ohorngrave:\- \PICT{Ohorngrave}\-
local ht._Ohorn:=uc_height;
acc_glyph(_Ohorn)(_Grave)(_Ohorngrave) if monospace: (-1/2u,0) fi;
endlocal;

%% \vb\- ohorngrave:\- \PICT{ohorngrave}\-
local ht._ohorn:=x_height;
acc_glyph(_ohorn)(_grave)(_ohorngrave) if monospace: (-1/2u,0) fi;
endlocal;

%% \vb\- Ohornhookabove:\- \PICT{Ohornhookabove}\-
local ht._Ohorn:=uc_height;
acc_glyph(_Ohorn)(_Hookabove)(_Ohornhookabove) if serifs: (0,o) fi;
endlocal;

%% \vb\- ohornhookabove:\- \PICT{ohornhookabove}\-
local ht._ohorn:=x_height;
acc_glyph(_ohorn)(_hookabove)(_ohornhookabove);
endlocal;

%% \vb\- Ohorntilde:\- \PICT{Ohorntilde}\-
local ht._Ohorn:=uc_height;
acc_glyph(_Ohorn)(_Tilde)(_Ohorntilde)
 if monospace or known is_vtt or known is_ssq: (-1/2u,0) fi;
endlocal;

%% \vb\- ohorntilde:\- \PICT{ohorntilde}\-
local ht._ohorn:=x_height;
acc_glyph(_ohorn)(_tilde)(_ohorntilde)
 if monospace or known is_vtt or known is_ssq: (-1/2u,0) fi;
endlocal;

%% \vb\- Ohungarumlaut:\- \PICT{Ohungarumlaut}\-
acc_glyph(_O)(_Hungarumlaut)(_Ohungarumlaut);

%% \vb\- ohungarumlaut:\- \PICT{ohungarumlaut}\-
acc_glyph(_o)(_hungarumlaut)(_ohungarumlaut);

%% \vb\- Omacron:\- \PICT{Omacron}\-
acc_glyph(_O)(_Macron)(_Omacron);

%% \vb\- omacron:\- \PICT{omacron}\-
acc_glyph(_o)(_macron)(_omacron);

%% \vb\- Oogonekacute:\- \PICT{Oogonekacute}\-
acc_glyph(_Oogonek)(_Acute)(_Oogonekacute);

%% \vb\- oogonekacute:\- \PICT{oogonekacute}\-
acc_glyph(_oogonek)(_acute)(_oogonekacute);

%% \vb\- Oslashacute:\- \PICT{Oslashacute}\-
local ht._Oslash:=uc_height;
acc_glyph(_Oslash)(_Acute)(_Oslashacute);
endlocal

%% \vb\- oslashacute:\- \PICT{oslashacute}\-
local ht._oslash:=x_height;
acc_glyph(_oslash)(_acute)(_oslashacute);
endlocal

%% \vb\- Otilde:\- \PICT{Otilde}\-
acc_glyph(_O)(_Tilde)(_Otilde);

%% \vb\- otilde:\- \PICT{otilde}\-
acc_glyph(_o)(_tilde)(_otilde);

%% \vb\- Racute:\- \PICT{Racute}\-
acc_glyph(_R)(_Acute)(_Racute);

%% \vb\- racute:\- \PICT{racute}\-
def xb_acc_glyph =
 if unknown is_csc:
  if not serifs:
   local glyph_axis._acute:=xpart(llcorner(glyph_stored._acute1));
   local glyph_axis._r:=xpart(llcorner(glyph_stored._r1));
  else:
   local glyph_axis._r:=whatever; 
  fi
 fi
enddef;
def xe_acc_glyph =
 if unknown is_csc:
  if not serifs: endlocal; endlocal; else: endlocal; fi
 fi
enddef;
acc_glyph(_r)(_acute)(_racute);

%% \vb\- Rcaron:\- \PICT{Rcaron}\-
acc_glyph(_R)(_Caron)(_Rcaron);

%% \vb\- rcaron:\- \PICT{rcaron}\-
if unknown is_csc: local glyph_axis._r:=whatever; fi
acc_glyph(_r)(_caron)(_rcaron);
if unknown is_csc: endlocal; fi

%% \vb\- Rcommaaccent:\- \PICT{Rcommaaccent}\-
acc_glyph(_R)(_commaaccent)(_Rcommaaccent);

%% \vb\- rcommaaccent:\- \PICT{rcommaaccent}\-
acc_glyph(_r)(_commaaccent)(_rcommaaccent);

%% \vb\- Rdblgrave:\- \PICT{Rdblgrave}\-
acc_glyph(_R)(_dblGrave)(_Rdblgrave) (-1/2u,0);

%% \vb\- rdblgrave:\- \PICT{rdblgrave}\-
if unknown is_csc: local glyph_axis._r:=whatever; fi
 acc_glyph(_r)(_dblgrave)(_rdblgrave);
if unknown is_csc: endlocal; fi

%% \vb\- Rdotaccent (see {\L}au\.ra in D.~E.~Knuth's testfont):\- \PICT{Rdotaccent}\-
acc_glyph(_R)(_Dotaccent)(_Rdotaccent) if serifs: (0,o) fi;

%% \vb\- rdotaccent (see {\L}au\.ra in D.~E.~Knuth's testfont):\- \PICT{rdotaccent}\-
if unknown is_csc: local glyph_axis._r:=whatever; fi
 acc_glyph(_r)(_dotaccent)(_rdotaccent);
if unknown is_csc: endlocal; fi

%% \vb\- Rdotbelow:\- \PICT{Rdotbelow}\-
acc_glyph(_R)(_dotbelow)(_Rdotbelow);

%% \vb\- rdotbelow:\- \PICT{rdotbelow}\-
if unknown is_csc:
 def xb_acc_glyph =
  save xsl_, xsr_; (xsl_, xsr_)=x_spreading(glyph_stored._r1)(y_<1/2h_);
  local glyph_axis._r:=1/2[xsl_, xsr_];
 enddef;
 def xe_acc_glyph =
  endlocal;
 enddef;
fi
acc_glyph(_r)(_dotbelow)(_rdotbelow);

%% \vb\- Rdotbelowmacron:\- \PICT{Rdotbelowmacron}\-
acc_glyph(_Rdotbelow)(_Macron)(_Rdotbelowmacron);

%% \vb\- rdotbelowmacron:\- \PICT{rdotbelowmacron}\-
acc_glyph(_rdotbelow)(_macron)(_rdotbelowmacron);

%% \vb\- Sacute:\- \PICT{Sacute}\-
acc_glyph(_S)(_Acute)(_Sacute);

%% \vb\- sacute:\- \PICT{sacute}\-
acc_glyph(_s)(_acute)(_sacute);

%% \vb\- Scaron:\- \PICT{Scaron}\-
acc_glyph(_S)(_Caron)(_Scaron);

%% \vb\- scaron:\- \PICT{scaron}\-
acc_glyph(_s)(_caron)(_scaron);

%% \vb\- Scircumflex:\- \PICT{Scircumflex}\-
acc_glyph(_S)(_Circumflex)(_Scircumflex);

%% \vb\- scircumflex:\- \PICT{scircumflex}\-
acc_glyph(_s)(_circumflex)(_scircumflex);

%% \vb\- Scommaaccent:\- \PICT{Scommaaccent}\-
acc_glyph(_S)(_commaaccent)(_Scommaaccent);

%% \vb\- scommaaccent:\- \PICT{scommaaccent}\-
acc_glyph(_s)(_commaaccent)(_scommaaccent);

%% \vb\- Sdotbelow:\- \PICT{Sdotbelow}\-
acc_glyph(_S)(_dotbelow)(_Sdotbelow);

%% \vb\- sdotbelow:\- \PICT{sdotbelow}\-
acc_glyph(_s)(_dotbelow)(_sdotbelow);

%% \vb\- Tcaron:\- \PICT{Tcaron}\-
acc_glyph(_T)(_Caron)(_Tcaron);

%% \vb\- tcaron (sic!):\- \PICT{tcaron}\-
if known is_csc:
 acc_glyph(_t)(_caron)(_tcaron);
else:
 if feasible_three_glyphs(_t)(_commaaccent)(_tcaron):
  wd._tcaron:=wd._t;
  beginglyph(_tcaron);
   save p_,s_,rmost_; path p_; pair s_;
   rmost_:=ypart(x_spreading(glyph_stored._t1)(y_>.9h_));
   p_:=glyph_stored._commaaccent1;
   s_:=(rmost_+round(2/3u), round(x_height+2/3u))-llcorner(p_);
   use_glyph("t"); Fill p_ shifted s_;
   use_stems("t"); use_stems("commaaccent") s_;
   standard_exact_hsbw("tcaron");
  endglyph;
 fi
fi

%% \vb\- Tcommaaccent:\- \PICT{Tcommaaccent}\-
acc_glyph(_T)(_commaaccent)(_Tcommaaccent);

%% \vb\- tcommaaccent:\- \PICT{tcommaaccent}\-
acc_glyph(_t)(_commaaccent)(_tcommaaccent);

%% \vb\- Tcedilla:\- \PICT{Tcedilla}\-
if feasible_three_glyphs(_T)(_cedilla)(_Tcedilla):
 wd._Tcedilla:=wd._T;
 beginglyph(_Tcedilla)
  save p,q,r,s; path p[];
  q=if monospace or known is_vtt: -3 else: 0 fi;
  p1=glyph_stored._T1;
  p2=glyph_stored._cedilla1;
  z.T=(x_spreading(p1)(y_<1/3h_));
  z.c=(x_spreading(p2)(y_>(h_-10)));
  s=1/2[x.T,y.T]-1/2[x.c,y.c];
  find_outlines(p1,p2 shifted (s,q))(r);
  Fill r1; if r.num=-2: Fill r2; fi
  use_stems(_T); use_stems(_cedilla)(s,q);
  standard_exact_hsbw("Tcedilla");
 endglyph;
fi

%% \vb\- tcedilla:\- \PICT{tcedilla}\-
if feasible_three_glyphs(_t)(_cedilla)(_tcedilla):
 wd._tcedilla:=wd._t;
 beginglyph(_tcedilla)
  save p,q,r,s; path p[];
  q=if monospace or known is_vtt: -3 else: 0 fi;
  p1=glyph_stored._t1;
  p2=glyph_stored._cedilla1;
  z.t=x_spreading(p1)(y_<2/5h_);
  z.c=(x_spreading(p2)(y_>(h_-10)));
  s=1/2[x.t,y.t] - 1/2[x.c,y.c] - 5;
  find_outlines(p1,p2 shifted (s,q))(r);
  Fill r1; if r.num=-2: Fill r2; fi
  use_stems(_t); use_stems(_cedilla)(s,q);
  standard_exact_hsbw("tcedilla");
 endglyph;
fi

%% \vb\- Tdieresis:\- \PICT{Tdieresis}\-
acc_glyph(_T)(_Dieresis)(_Tdieresis);

%% \vb\- tdieresis:\- \PICT{tdieresis}\-
if known is_csc:
 acc_glyph(_t)(_dieresis)(_tdieresis);
else:
 if (not serifs or monospace) and (known glyph_stored._t1):
  local glyph_axis._t:=
   1/2[xpart(x_spreading(glyph_stored._t1)(y_>x_height+20)),
       ypart(x_spreading(glyph_stored._t1)(y_>x_height+20))];
 fi
 acc_glyph(_t)(_Dieresis)(_tdieresis);
 if (not serifs or monospace) and (known glyph_stored._t1): endlocal; fi
fi

%% \vb\- Tdotbelow:\- \PICT{Tdotbelow}\-
acc_glyph(_T)(_dotbelow)(_Tdotbelow);

%% \vb\- tdotbelow:\- \PICT{tdotbelow}\-
acc_glyph(_t)(_dotbelow)(_tdotbelow);

%% \vb\- Tlinebelow:\- \PICT{Tlinebelow}\-
acc_glyph(_T)(_linebelow)(_Tlinebelow);

%% \vb\- tlinebelow:\- \PICT{tlinebelow}\-
acc_glyph(_t)(_linebelow)(_tlinebelow);

%% \vb\- Ttilde:\- \PICT{Ttilde}\-
acc_glyph(_T)(_Tilde)(_Ttilde);

%% \vb\- ttilde:\- \PICT{ttilde}\-
if known is_csc:
 acc_glyph(_t)(_tilde)(_ttilde);
else:
 if (not serifs or monospace) and (known glyph_stored._t1):
  local glyph_axis._t:=
   1/2[xpart(x_spreading(glyph_stored._t1)(y_>x_height+20)),
       ypart(x_spreading(glyph_stored._t1)(y_>x_height+20))];
 fi
 acc_glyph(_t)(_Tilde)(_ttilde);
 if (not serifs or monospace) and (known glyph_stored._t1): endlocal; fi
fi

%% \vb\- Uacute:\- \PICT{Uacute}\-
acc_glyph(_U)(_Acute)(_Uacute);

%% \vb\- uacute:\- \PICT{uacute}\-
acc_glyph(_u)(_acute)(_uacute);

%% \vb\- Ubreve:\- \PICT{Ubreve}\-
acc_glyph(_U)(_Breve)(_Ubreve);

%% \vb\- ubreve:\- \PICT{ubreve}\-
acc_glyph(_u)(_breve)(_ubreve);

%% \vb\- Ubrevebelowinverted:\- \PICT{Ubrevebelowinverted}\-
acc_glyph(_U)(_brevebelowinverted)(_Ubrevebelowinverted); % for Mojca M.

%% \vb\- ubrevebelowinverted:\- \PICT{ubrevebelowinverted}\-
acc_glyph(_u)(_brevebelowinverted)(_ubrevebelowinverted); % ditto

%% \vb\- Ucaron:\- \PICT{Ucaron}\-
acc_glyph(_U)(_Caron)(_Ucaron);

%% \vb\- ucaron:\- \PICT{ucaron}\-
acc_glyph(_u)(_caron)(_ucaron);

%% \vb\- Ucircumflex:\- \PICT{Ucircumflex}\-
acc_glyph(_U)(_Circumflex)(_Ucircumflex);

%% \vb\- ucircumflex:\- \PICT{ucircumflex}\-
acc_glyph(_u)(_circumflex)(_ucircumflex);

%% \vb\- Udblgrave:\- \PICT{Udblgrave}\-
acc_glyph(_U)(_dblGrave)(_Udblgrave);

%% \vb\- udblgrave:\- \PICT{udblgrave}\-
acc_glyph(_u)(_dblgrave)(_udblgrave);

%% \vb\- Udieresis:\- \PICT{Udieresis}\-
acc_glyph(_U)(_Dieresis)(_Udieresis);

%% \vb\- udieresis:\- \PICT{udieresis}\-
acc_glyph(_u)(_dieresis)(_udieresis);

%% \vb\- Udieresisacute:\- \PICT{Udieresisacute}\-
acc_glyph(_U)(_Dieresisacute)(_Udieresisacute);

%% \vb\- udieresisacute:\- \PICT{udieresisacute}\-
acc_glyph(_u)(_dieresisacute)(_udieresisacute);

%% \vb\- Udieresiscaron:\- \PICT{Udieresiscaron}\-
acc_glyph(_U)(_Dieresiscaron)(_Udieresiscaron);

%% \vb\- udieresiscaron:\- \PICT{udieresiscaron}\-
acc_glyph(_u)(_dieresiscaron)(_udieresiscaron);

%% \vb\- Udieresisgrave:\- \PICT{Udieresisgrave}\-
acc_glyph(_U)(_Dieresisgrave)(_Udieresisgrave);

%% \vb\- udieresisgrave:\- \PICT{udieresisgrave}\-
acc_glyph(_u)(_dieresisgrave)(_udieresisgrave);

%% \vb\- Udotbelow:\- \PICT{Udotbelow}\-
acc_glyph(_U)(_dotbelow)(_Udotbelow);

%% \vb\- udotbelow:\- \PICT{udotbelow}\-
acc_glyph(_u)(_dotbelow)(_udotbelow);

%% \vb\- Ugrave:\- \PICT{Ugrave}\-
acc_glyph(_U)(_Grave)(_Ugrave);

%% \vb\- ugrave:\- \PICT{ugrave}\-
acc_glyph(_u)(_grave)(_ugrave);

%% \vb\- Uhookabove:\- \PICT{Uhookabove}\-
acc_glyph(_U)(_Hookabove)(_Uhookabove) if serifs: (0,o) fi;

%% \vb\- uhookabove:\- \PICT{uhookabove}\-
acc_glyph(_u)(_hookabove)(_uhookabove);

%% \vb\- Uhornacute:\- \PICT{Uhornacute}\-
local ht._Uhorn:=uc_height;
acc_glyph(_Uhorn)(_Acute)(_Uhornacute)(-1/2u,0);
endlocal;

%% \vb\- uhornacute:\- \PICT{uhornacute}\-
local ht._uhorn:=x_height;
acc_glyph(_uhorn)(_acute)(_uhornacute)(-1/2u,0);
endlocal;

%% \vb\- Uhorndotbelow:\- \PICT{Uhorndotbelow}\-
local glyph_axis._Uhorn:=whatever;
acc_glyph(_Uhorn)(_dotbelow)(_Uhorndotbelow);
endlocal;

%% \vb\- uhorndotbelow:\- \PICT{uhorndotbelow}\-
local glyph_axis._uhorn:=whatever;
acc_glyph(_uhorn)(_dotbelow)(_uhorndotbelow);
endlocal;

%% \vb\- Uhorngrave:\- \PICT{Uhorngrave}\-
local ht._Uhorn:=uc_height;
acc_glyph(_Uhorn)(_Grave)(_Uhorngrave) if monospace: (-1/2u,0) fi;
endlocal;

%% \vb\- uhorngrave:\- \PICT{uhorngrave}\-
local ht._uhorn:=x_height;
acc_glyph(_uhorn)(_grave)(_uhorngrave) if monospace: (-1/2u,0) fi;
endlocal;

%% \vb\- Uhornhookabove:\- \PICT{Uhornhookabove}\-
local ht._Uhorn:=uc_height;
acc_glyph(_Uhorn)(_Hookabove)(_Uhornhookabove) if serifs: (0,o) fi;
endlocal;

%% \vb\- uhornhookabove:\- \PICT{uhornhookabove}\-
local ht._uhorn:=x_height;
acc_glyph(_uhorn)(_hookabove)(_uhornhookabove);
endlocal;

%% \vb\- Uhorntilde:\- \PICT{Uhorntilde}\-
local ht._Uhorn:=uc_height;
acc_glyph(_Uhorn)(_Tilde)(_Uhorntilde)
  if monospace: (-1/2u,0) fi;
endlocal;

%% \vb\- uhorntilde:\- \PICT{uhorntilde}\-
local ht._uhorn:=x_height;
acc_glyph(_uhorn)(_tilde)(_uhorntilde)
 if monospace: (-1/2u,0) fi;
endlocal;

%% \vb\- Uhungarumlaut:\- \PICT{Uhungarumlaut}\-
acc_glyph(_U)(_Hungarumlaut)(_Uhungarumlaut);

%% \vb\- uhungarumlaut:\- \PICT{uhungarumlaut}\-
acc_glyph(_u)(_hungarumlaut)(_uhungarumlaut);

%% \vb\- Umacron:\- \PICT{Umacron}\-
acc_glyph(_U)(_Macron)(_Umacron);

%% \vb\- umacron:\- \PICT{umacron}\-
acc_glyph(_u)(_macron)(_umacron);

%% \vb\- Uring:\- \PICT{Uring}\-
acc_glyph(_U)(_Ring)(_Uring);

%% \vb\- uring:\- \PICT{uring}\-
acc_glyph(_u)(_ring)(_uring);

%% \vb\- Utilde:\- \PICT{Utilde}\-
acc_glyph(_U)(_Tilde)(_Utilde);

%% \vb\- utilde:\- \PICT{utilde}\-
acc_glyph(_u)(_tilde)(_utilde);

%% \vb\- Wacute:\- \PICT{Wacute}\-
acc_glyph(_W)(_Acute)(_Wacute);

%% \vb\- wacute:\- \PICT{wacute}\-
acc_glyph(_w)(_acute)(_wacute);

%% \vb\- Wcircumflex:\- \PICT{Wcircumflex}\-
acc_glyph(_W)(_Circumflex)(_Wcircumflex);

%% \vb\- wcircumflex:\- \PICT{wcircumflex}\-
acc_glyph(_w)(_circumflex)(_wcircumflex);

%% \vb\- Wdieresis:\- \PICT{Wdieresis}\-
acc_glyph(_W)(_Dieresis)(_Wdieresis);

%% \vb\- wdieresis:\- \PICT{wdieresis}\-
acc_glyph(_w)(_dieresis)(_wdieresis);

%% \vb\- Wgrave:\- \PICT{Wgrave}\-
acc_glyph(_W)(_Grave)(_Wgrave);

%% \vb\- wgrave:\- \PICT{wgrave}\-
acc_glyph(_w)(_grave)(_wgrave);

%% \vb\- Yacute:\- \PICT{Yacute}\-
acc_glyph(_Y)(_Acute)(_Yacute);

%% \vb\- yacute:\- \PICT{yacute}\-
acc_glyph(_y)(_acute)(_yacute);

%% \vb\- Ycircumflex:\- \PICT{Ycircumflex}\-
acc_glyph(_Y)(_Circumflex)(_Ycircumflex);

%% \vb\- ycircumflex:\- \PICT{ycircumflex}\-
acc_glyph(_y)(_circumflex)(_ycircumflex);

%% \vb\- Ydieresis:\- \PICT{Ydieresis}\-
acc_glyph(_Y)(_Dieresis)(_Ydieresis);

%% \vb\- ydieresis:\- \PICT{ydieresis}\-
acc_glyph(_y)(_dieresis)(_ydieresis);

%% \vb\- Ydotbelow:\- \PICT{Ydotbelow}\-
local glyph_axis._Ydotbelow:=whatever;
acc_glyph(_Y)(_dotbelow)(_Ydotbelow);
endlocal;

%% \vb\- ydotbelow:\- \PICT{ydotbelow}\-
if known is_csc:
 acc_glyph(_y)(_dotbelow)(_ydotbelow);
else:
 if feasible_three_glyphs(_y)(_dotbelow)(_ydotbelow):
  beginglyph(_ydotbelow);
   save c_,d_,s_,w_;
   wd._ydotbelow:=wd._y;
   w_:=xpart(urcorner glyph_stored._y1); % width
   c_:=1/2[xpart(llcorner glyph_stored._dotbelow1),
      xpart(urcorner glyph_stored._dotbelow1)]; % center
   d_:=xpart(urcorner glyph_stored._dotbelow1)-
      xpart(llcorner glyph_stored._dotbelow1); % diameter
   if known is_ital:
    s_=w_-c_+if monospace: 1 else: 4/5 fi d_;
   else:
    s_:=round(min(max(3/4wd._y-c_, 1/2wd._y-c_+6/5d_), w_-c_-1/2d_));
   fi
   use_glyph(_y); use_glyph(_dotbelow)(round(s_),0);
   use_stems(_y); use_stems(_dotbelow)(round(s_),0);
   standard_exact_hsbw("ydotbelow");
  endglyph;
 fi
fi

%% \vb\- Ygrave:\- \PICT{Ygrave}\-
acc_glyph(_Y)(_Grave)(_Ygrave);

%% \vb\- ygrave:\- \PICT{ygrave}\-
acc_glyph(_y)(_grave)(_ygrave);

%% \vb\- Yhookabove:\- \PICT{Yhookabove}\-
acc_glyph(_Y)(_Hookabove)(_Yhookabove) if serifs: (0,o) fi;

%% \vb\- yhookabove:\- \PICT{yhookabove}\-
acc_glyph(_y)(_hookabove)(_yhookabove);

%% \vb\- Ytilde:\- \PICT{Ytilde}\-
acc_glyph(_Y)(_Tilde)(_Ytilde);

%% \vb\- ytilde:\- \PICT{ytilde}\-
acc_glyph(_y)(_tilde)(_ytilde);

%% \vb\- Zacute:\- \PICT{Zacute}\-
acc_glyph(_Z)(_Acute)(_Zacute);

%% \vb\- zacute:\- \PICT{zacute}\-
acc_glyph(_z)(_acute)(_zacute);

%% \vb\- Zcaron:\- \PICT{Zcaron}\-
acc_glyph(_Z)(_Caron)(_Zcaron);

%% \vb\- zcaron:\- \PICT{zcaron}\-
acc_glyph(_z)(_caron)(_zcaron);

%% \vb\- Zdotaccent:\- \PICT{Zdotaccent}\-
acc_glyph(_Z)(_Dotaccent)(_Zdotaccent) if serifs: (0,o) fi;

%% \vb\- zdotaccent:\- \PICT{zdotaccent}\-
acc_glyph(_z)(_dotaccent)(_zdotaccent);

%% \vb\- Zdotbelow:\- \PICT{Zdotbelow}\-
acc_glyph(_Z)(_dotbelow)(_Zdotbelow);

%% \vb\- zdotbelow:\- \PICT{zdotbelow}\-
acc_glyph(_z)(_dotbelow)(_zdotbelow);

% SPACES
beginglyph(_nbspace); standard_exact_hsbw("nbspace"); endglyph;
beginglyph(_space); standard_exact_hsbw("space"); endglyph;

% DUPLICATES
%% \vb\- symbol mho:\- \PICT{mho}\-
if feasible_two_glyphs(_Omega)(_mho):
 beginglyph(_mho); % uni 2127, TS1 encoding, nearly a duplicate
  wd._mho:=wd._Omega;
  save p_; path p_;
  p_:=glyph_stored._Omega1
   rotatedaround (round(1/2wd._mho,1/2uc_height),180);
  Fill p_;
  for i_:=1 upto hstem_stored._Omega.num:
   fix_hstem(ypart hstem_stored._Omega[i_])(p_);
  endfor
  for i_:=1 upto vstem_stored._Omega.num:
   fix_vstem(ypart vstem_stored._Omega[i_])(p_);
  endfor
  standard_exact_hsbw("mho");
 endglyph;
fi

%% \vb
% Proportional digits
if not monospace:
 local u:=round(4/3u);
 begingroup
 save la_, ra_; la_:=u; ra_:=u;
%% \- hyphen.prop: \- \PICT{hyphen.prop}\-
 dup_glyph(_hyphen)(_hyphen.prop) % CM's hyphen is shifted to the left
  (round(-xpart(center glyph_stored._hyphen1)+1/2wd._hyphen.prop),
   round(1/4x_height));
%% \vb\- zero.prop: \- \PICT{zero.prop}\-
 trunc_glyph(_zero)(_zero.prop)   (la_, ra_);
%% \vb\- one.prop: \- \PICT{one.prop}\-
 trunc_glyph(_one)(_one.prop)     (1/2la_, 1/2ra_);
%% \vb\- two.prop: \- \PICT{two.prop}\-
 trunc_glyph(_two)(_two.prop)     (la_,ra_);
%% \vb\- three.prop: \- \PICT{three.prop}\-
 trunc_glyph(_three)(_three.prop) (la_, ra_);
%% \vb\- four.prop: \- \PICT{four.prop}\-
 trunc_glyph(_four)(_four.prop)   (1/2la_, 1/2ra_);
%% \vb\- five.prop: \- \PICT{five.prop}\-
 trunc_glyph(_five)(_five.prop)   (la_, ra_);
%% \vb\- six.prop: \- \PICT{six.prop}\-
 trunc_glyph(_six)(_six.prop)     (la_, ra_);
%% \vb\- seven.prop: \- \PICT{seven.prop}\-
 trunc_glyph(_seven)(_seven.prop) (1/2la_, 1/2ra_);
%% \vb\- eight.prop: \- \PICT{eight.prop}\-
 trunc_glyph(_eight)(_eight.prop) (la_,ra_);
%% \vb\- nine.prop: \- \PICT{nine.prop}\-
 trunc_glyph(_nine)(_nine.prop)   (la_, ra_);
 endgroup;
 LK("seven.prop")
  KP("hyphen.prop")(-1/2u)
  KP("four.prop")(-u)
  KP("six.prop")(-1/4u)
 KL;
 LK("hyphen.prop")
  KP("one.prop")(-1/2u)
  KP("two.prop")(-1/4u)
  KP("seven.prop")(-3/4u)
 KL;
 endlocal;
fi

%% \vb
% Old style proportional digits
if not monospace:
 local u:=round(4/3u);
 begingroup
 save la_, ra_; la_:=u; ra_:=u;
%% \- zero.oldstyle: \- \PICT{zero.oldstyle}\-
 trunc_glyph(_zero.taboldstyle)(_zero.oldstyle)   (la_, ra_);
%% \vb\- one.oldstyle: \- \PICT{one.oldstyle}\-
 trunc_glyph(_one.taboldstyle)(_one.oldstyle)     (1/2la_, 1/2ra_);
%% \vb\- two.oldstyle: \- \PICT{two.oldstyle}\-
 trunc_glyph(_two.taboldstyle)(_two.oldstyle)     (la_, ra_);
%% \vb\- three.oldstyle: \- \PICT{three.oldstyle}\-
 trunc_glyph(_three.taboldstyle)(_three.oldstyle) (la_, ra_);
%% \vb\- four.oldstyle: \- \PICT{four.oldstyle}\-
 trunc_glyph(_four.taboldstyle)(_four.oldstyle)   (1/2la_, 1/2ra_);
%% \vb\- five.oldstyle: \- \PICT{five.oldstyle}\-
 trunc_glyph(_five.taboldstyle)(_five.oldstyle)   (la_, ra_);
%% \vb\- six.oldstyle: \- \PICT{six.oldstyle}\-
 trunc_glyph(_six.taboldstyle)(_six.oldstyle)     (la_, ra_);
%% \vb\- seven.oldstyle: \- \PICT{seven.oldstyle}\-
 trunc_glyph(_seven.taboldstyle)(_seven.oldstyle) (1/2la_, 1/2ra_);
%% \vb\- eight.oldstyle: \- \PICT{eight.oldstyle}\-
 trunc_glyph(_eight.taboldstyle)(_eight.oldstyle) (la_, ra_);
%% \vb\- nine.oldstyle: \- \PICT{nine.oldstyle}\-
 trunc_glyph(_nine.taboldstyle)(_nine.oldstyle)   (la_, ra_);
 endgroup;
 LK("seven.oldstyle")
  KP("four.oldstyle")(-u)
 KL;
 endlocal;
fi

%% \vb\- zero.slash: \- \PICT{zero.slash}\-
if feasible_two_glyphs(_zero)(_zero.slash):
 wd._zero.slash:=wd._zero;
 ht._zero.slash:=ht._zero;
 dp._zero.slash:=dp._zero;
 beginglyph(_zero.slash); % uni F638 -- like in myriad
  save loose_fix_stem;
  save b_,d_,p_,ra_,rb_; path p_[];
  if ypart(urcorner(glyph_stored._zero1))>
   ypart(urcorner(glyph_stored._zero2)):
    p_1=glyph_stored._zero1; p_2=glyph_stored._zero2;
  else:
    p_1=glyph_stored._zero2; p_2=glyph_stored._zero1;
  fi
  b_=math_stem;
  d_=if slang<>0: 35 else: 10 fi; % correction of the distance from the contour
  % see plain_ex.mp, comments to the macro |leg|:
  z0=(d_+xpart lrcorner p_1,ypart lrcorner p_1); z2=(-d_,0)+ulcorner p_1;
  z1=z0+whatever*((z2-z0) leg -b_); y1=y2; z1-z2=z0-z3;
  labels(0,1,2,3);
  p_3=z3--z2--z1--z0--cycle;
  find_outlines(p_1,reverse p_3)(ra_); find_outlines(reverse p_2,p_3)(rb_);
  ra_1:=correct_close_doublets(ra_1,15);
  rb_1:=correct_close_doublets(rb_1,15);
  rb_2:=correct_close_doublets(rb_2,15);
  Fill ra_1; unFill reverse rb_1, reverse rb_2;
  for i_:=1 upto hstem_stored._zero.num:
   fix_hstem(ypart hstem_stored._zero[i_])(p_1,p_2);
  endfor
  for i_:=1 upto vstem_stored._zero.num:
   fix_vstem(ypart vstem_stored._zero[i_])(p_1,p_2);
  endfor
  standard_hsbw("zero.slash");
 endglyph;
fi

%% \vb\- Orogate: \- \PICT{Orogate}\-
if feasible_two_glyphs(_O)(_Orogate):
 wd._Orogate:=wd._O;
 beginglyph(_Orogate);
  save loose_fix_stem;
  save d_,p_,q_,res_; path p_[];
  if ypart(urcorner(glyph_stored._O1))>
   ypart(urcorner(glyph_stored._O2)):
    p_1=glyph_stored._O1; p_2=glyph_stored._O2;
  else:
    p_1=glyph_stored._O2; p_2=glyph_stored._O1;
  fi
  if cm_pal = "cmu10": % a patch...
   local vair=2round 1/2ypart(urcorner p_1 - urcorner p_2);
   local crisp=vair;
  fi
  d_:=accent_haxis-x_height+1/2dot_size-o;
  if d_>desc_depth: d_:=desc_depth; fi
  if vair>crisp:
   p_3=(unitsquare xscaled (vair-crisp) yscaled (cap_height+2d_-crisp))
    shifted
    (-1/2vair+1/2crisp+round(xpart(center p_1)),-d_+1/2crisp);
  else:
   p_3=% "degenerated case"
    (round(xpart(center p_1)), cap_height+d_-1/2crisp)--
    (round(xpart(center p_1)),-d_+1/2crisp);
  fi
  if crisp>0:
   local default_nib:=fix_nib(crisp,crisp,0);
   pen_stroke()(p_3)(q_); p_3:=reverse q_ if vair>crisp: r fi;
   endlocal;
  else: p_3:=reverse p_3; fi
  find_outlines(p_1,reverse p_3)(res_);
  res_1:=correct_close_doublets(res_1,15);
  Fill res_1; unFill p_2;
  if slang=0: fix_vstem(crisp+vair)(res_1); fi
  for i_:=1 upto vstem_stored._O.num:
   fix_vstem(ypart vstem_stored._O[i_])(p_1,p_2);
  endfor
  if cm_pal = "cmu10": endlocal;  endlocal; fi
  standard_hsbw("Orogate");
 endglyph;
fi

%% \vb\- orogate: \- \PICT{orogate}\-
if feasible_two_glyphs(_o)(_orogate):
 wd._orogate:=wd._o;
 beginglyph(_orogate);
  save loose_fix_stem;
  save d_,p_,q_,res_,x_; path p_[];
  x_:=x_height; if known is_csc: x_:=lower_cap_height; fi
  if ypart(urcorner(glyph_stored._o1))>
   ypart(urcorner(glyph_stored._o2)):
    p_1=glyph_stored._o1; p_2=glyph_stored._o2;
  else:
    p_1=glyph_stored._o2; p_2=glyph_stored._o1;
  fi
  if cm_pal = "cmu10": % a patch...
   local vair=2round 1/2ypart(urcorner p_1 - urcorner p_2);
   local crisp=vair;
  fi
  d_:=accent_haxis-x_height+1/2dot_size-o;
  if d_>desc_depth: d_:=desc_depth; fi
  if vair>crisp:
   p_3=(unitsquare xscaled (vair-crisp) yscaled (x_+2d_-crisp))
    shifted
    (-1/2vair+1/2crisp+round(xpart(center p_1)),-d_+1/2crisp);
  else:
   p_3=% "degenerated case"
    (round(xpart(center p_1)), x_+d_-1/2crisp)--
    (round(xpart(center p_1)),-d_+1/2crisp);
  fi
  if crisp>0:
   local default_nib:=fix_nib(crisp,crisp,0);
   pen_stroke()(p_3)(q_); p_3:=reverse q_ if vair>crisp: r fi;
   endlocal;
  else: p_3:=reverse p_3; fi
  find_outlines(p_1,reverse p_3)(res_);
  res_1:=correct_close_doublets(res_1,15);
  Fill res_1; unFill p_2;
  if slang=0: fix_vstem(crisp+vair)(res_1); fi
  for i_:=1 upto vstem_stored._o.num:
   fix_vstem(ypart vstem_stored._o[i_])(p_1,p_2);
  endfor
  if cm_pal = "cmu10": endlocal;  endlocal; fi
  standard_hsbw("orogate");
 endglyph;
fi

% \vb
if not monospace:
begingroup save qsb_, lqsb_, rqsb_;
if is_stored(_quoteleft) and known wd._quoteleft:
 lqsb_:=xpart(llcorner(glyph_stored._quoteleft1));
 rqsb_:=round(
  wd._quoteleft-xpart(urcorner(glyph_stored._quoteleft1)));
else:
 if
  ((unknown process_selected or known process_selected._quotedblleft)
   and unknown ignore_selected._quotedblleft) or
  ((unknown process_selected or known process_selected._quotedblright)
   and unknown ignore_selected._quotedblright) or
  ((unknown process_selected or known process_selected._quotedblbase)
   and unknown ignore_selected._quotedblbase):
  errhelp
   "Glyph quoteleft is needed; go on, I'll set boths sidebearings equal to u.";
  errmessage "GLYPH quotedbl[base,left,right]: unknown sidebearing(s)";
 fi
 lqsb_:=u; rqsb_:=u;
fi
%% \vb\- quotedblleft:\- \PICT{quotedblleft}\-
% quotedblleft with no extra sidebearings (``single quote style'')
trunc_glyph(_quotedblleft.cm)(_quotedblleft)(lqsb_,rqsb_);
qsb_:=lqsb_; lqsb_:=rqsb_; rqsb_:=qsb_; % mirror sidebearings
%% \vb\- quotedblbase:\- \PICT{quotedblbase}\-
% quotedblbase with no extra sidebearings (``single quote style'')
trunc_glyph(_quotedblbase.cm)(_quotedblbase)(lqsb_,rqsb_);
%% \vb\- quotedblright:\- \PICT{quotedblright}\-
% quotedblright with no extra sidebearings (``single quote style'')
trunc_glyph(_quotedblright.cm)(_quotedblright)(lqsb_,rqsb_);
endgroup;
else:
 dup_glyph(_quotedblbase)(_quotedblbase.cm);
 dup_glyph(_quotedblleft)(_quotedblleft.cm);
 dup_glyph(_quotedblright)(_quotedblright.cm);
fi

% Zero-width fraction
%% \vb\- fraction.alt:\- \PICT{fraction.alt}\-
wd._fraction.alt:=0;
center_glyph(_fraction)(_fraction.alt)(0,0);

%% \vb
% various hyphens; |_hyphen.alt| is needed for the EC and VN encodings,
% |_hyphendbl.alt| -- for the TS1 encoding
dup_glyph(_hyphen)(_hyphen.dup); % LY1 encod. and CS subst.
dup_glyph(_hyphen)(_uni2_0_1_0) % in unicode, nearby endash and emdash
 (round(-xpart(center glyph_stored._hyphen1)+1/2wd._uni2_0_1_0), 0);
dup_glyph(_hyphen)(_uni2_0_1_1) % as above, so called non-breakable hyphen
 (round(-xpart(center glyph_stored._hyphen1)+1/2wd._uni2_0_1_1), 0);
% |sfthyphen| is meant for non-TeX applications, see
% Unicode Technical report \#14 (concerns the marking of breaks,
% hyphenation, etc.; http:\string/\string/www.unicode.org\string/unicode\string/reports\string/tr14\string/tr14-5.pdf):
% ``00AD SOFT HYPHEN (SHY) SHY is rendered invisibly and has no width,
% except at a line break. The rendering of the soft hyphen depends
% on the script. For the Latin script it is rendered as a hyphen,
% however, some languages require a change in spelling surrounding
% an optional hyphen, if it occurs at a line break.  For example in
% German `Becker' changes to `Bek-ker' when hyphenated.'' [BJ hasn't it changed?]
dup_glyph(_hyphen)(_sfthyphen);

if monospace:
 wd._hyphen.alt:=wd._hyphendbl:=wd._hyphendbl.alt:=
 wd._threequartersemdash:=wd._twelveudash:=mono_charwd;
 dup_glyph(_hyphen)(_endash);
 dup_glyph(_hyphen)(_emdash);
else:
 wd._hyphen.alt:=1/2wd._hyphen;
 wd._hyphendbl.alt:=1/2wd._hyphendbl;
fi

%% \vb\- hyphen.alt:\- \PICT{hyphen.alt}\-
if feasible_two_glyphs(_hyphen)(_hyphen.alt):
 beginglyph(_hyphen.alt);
  save p,s; path p[];
  p0=glyph_stored._hyphen1;
  s=if monospace: round (3u-xpart(llcorner p0)) % approx
  else: round 1/2(wd._hyphen-u-.2u-xpart(urcorner p0 - llcorner p0)) % EC src
  fi;
  for i_:=0 upto length(p0)-1:
   z0[i_]=point i_ of p0;
   z0[i_]a=postcontrol i_ of p0;
   z0[i_+1]b=precontrol i_+1 of p0;
   x0[i_]:=x0[i_] if x0[i_]<1/2wd._hyphen: + else: - fi s;
   x0[i_]a:=x0[i_]a if x0[i_]a<1/2wd._hyphen: + else: - fi s;
   x0[i_+1]b:=x0[i_+1]b if x0[i_+1]b<1/2wd._hyphen: + else: - fi s;
  endfor
  z0[length(p0)]=z 0 0; p1=compose_path.z0(length(p0));
  if not monospace:
   p1:=p1 shifted (xpart(llcorner p0 - llcorner p1),0);
  fi
  Fill p1;
  fix_hstem(ypart(urcorner p1 - llcorner p1))(p1);
  standard_exact_hsbw("hyphen.alt");
 endglyph;
fi

%% \vb
if monospace: % hyphendbl, twelveudash and threequartersemdash

%% \- hyphendbl:\- \PICT{hyphendbl}\-
if feasible_two_glyphs(_hyphen)(_hyphendbl):
 beginglyph(_hyphendbl);
  save p,s; path p[];
  p0=glyph_stored._hyphen1;
  s=round((
     (-1)[.45x_height,.55x_height] % EC src (txsymbol.mf)
     + 1/2crisp % optical correction (?)
    )/2); 
  p1:=p0 shifted (0,s);
  p2:=p0 shifted (0,-s);
  Fill p1,p2;
  fix_hstem(ypart(urcorner p1 - llcorner p1))(p1);
  fix_hstem(ypart(urcorner p1 - llcorner p1))(p2);
  standard_exact_hsbw("hyphendbl");
 endglyph;
fi

%% \vb\- twelveudash:\- \PICT{twelveudash}\-
if feasible_two_glyphs(_hyphen)(_twelveudash):
 beginglyph(_twelveudash);
  save p,s; path p[];
  p0=glyph_stored._hyphen1;
  s.l=-xpart(llcorner p0);
  s.r=wd._twelveudash-xpart(urcorner p0);
  for i_:=0 upto length(p0)-1:
   z0[i_]=point i_ of p0;
   z0[i_]a=postcontrol i_ of p0;
   z0[i_+1]b=precontrol i_+1 of p0;
   x0[i_]:=x0[i_] if x0[i_]<1/2wd._hyphen: +s.l else: +s.r fi ;
   x0[i_]a:=x0[i_]a if x0[i_]a<1/2wd._hyphen: +s.l else: +s.r fi;
   x0[i_+1]b:=x0[i_+1]b if x0[i_+1]b<1/2wd._hyphen: +s.l else: +s.r fi;
  endfor
  z0[length(p0)]=z 0 0; p1=compose_path.z0(length(p0));
  Fill p1;
  fix_hstem(ypart(urcorner p1 - llcorner p1))(p1);
  standard_exact_hsbw("twelveudash");
 endglyph;
fi

%% \vb\- threequartersemdash:\- \PICT{threequartersemdash}\-
if feasible_two_glyphs(_hyphen)(_threequartersemdash):
 beginglyph(_threequartersemdash);
  save p,s; path p[];
  p0=glyph_stored._hyphen1;
  s.l=-xpart(llcorner p0);
  s.r=wd._threequartersemdash-xpart(urcorner p0);
  for i_:=0 upto length(p0)-1:
   z0[i_]=point i_ of p0;
   z0[i_]a=postcontrol i_ of p0;
   z0[i_+1]b=precontrol i_+1 of p0;
   x0[i_]:=x0[i_] if x0[i_]<1/2wd._hyphen: +s.l else: +s.r fi ;
   x0[i_]a:=x0[i_]a if x0[i_]a<1/2wd._hyphen: +s.l else: +s.r fi;
   x0[i_+1]b:=x0[i_+1]b if x0[i_+1]b<1/2wd._hyphen: +s.l else: +s.r fi;
  endfor
  z0[length(p0)]=z 0 0; p1=compose_path.z0(length(p0));
  Fill p1;
  fix_hstem(ypart(urcorner p1 - llcorner p1))(p1);
  standard_exact_hsbw("threequartersemdash");
 endglyph;
fi

fi

%% \vb\- hyphendbl.alt:\- \PICT{hyphendbl.alt}\-
if feasible_two_glyphs(_hyphendbl)(_hyphendbl.alt):
 beginglyph(_hyphendbl.alt);
  save p,s; path p[];
  p0=glyph_stored._hyphendbl1;
  p1=glyph_stored._hyphendbl2;
  s=if monospace: round (3u-xpart(llcorner p0)) % approx
  else: round 1/2(wd._hyphen-u-.2u-xpart(urcorner p0 - llcorner p0)) % EC src
  fi;
  for j_:=0,1:
   for i_:=0 upto length(p[j_])-1:
    z[j_][i_]=point i_ of p[j_];
    z[j_][i_]a=postcontrol i_ of p[j_];
    z[j_][i_+1]b=precontrol i_+1 of p[j_];
    x[j_][i_]:=x[j_][i_] if x[j_][i_]<1/2wd._hyphendbl: + else: - fi s;
    x[j_][i_]a:=x[j_][i_]a if x[j_][i_]a<1/2wd._hyphendbl: + else: - fi s;
    x[j_][i_+1]b:=x[j_][i_+1]b if x[j_][i_+1]b<1/2wd._hyphendbl: + else: - fi s;
   endfor
  endfor
  z0[length(p0)]=z 0 0; p2=compose_path.z0(length(p0));
  z1[length(p1)]=z 1 0; p3=compose_path.z1(length(p1));
  if not monospace:
   p2:=p2 shifted (xpart(llcorner p0 - llcorner p2),0);
   p3:=p3 shifted (xpart(llcorner p1 - llcorner p3),0);
  fi
  Fill p2; Fill p3;
  fix_hstem(ypart(urcorner p2 - llcorner p2))(p2);
  fix_hstem(ypart(urcorner p3 - llcorner p3))(p3);
  standard_exact_hsbw("hyphendbl.alt");
 endglyph;
fi

%% \vb
% TS1 encoding
dup_glyph(_f)(_florin);
dup_glyph(_Omega)(_ohm); % uni 2126

% LY1 encoding
dup_glyph(_acute)(_acute.dup);
dup_glyph(_ae)(_ae.dup);
dup_glyph(_AE)(_AE.dup);
dup_glyph(_cedilla)(_cedilla.dup);
dup_glyph(_circumflex)(_circumflex.dup);
dup_glyph(_dieresis)(_dieresis.dup);
dup_glyph(_germandbls)(_germandbls.dup);
dup_glyph(_macron)(_macron.dup);
dup_glyph(_oe)(_oe.dup);
dup_glyph(_OE)(_OE.dup);
dup_glyph(_oslash)(_oslash.dup);
dup_glyph(_Oslash)(_Oslash.dup);
dup_glyph(_quoteleft)(_quoteleft.dup);
dup_glyph(_quoteright)(_quoteright.dup);
dup_glyph(_tilde)(_tilde.dup);

dup_glyph(_Eth)(_Dcroat);

% AGL locates dotlessj in F6BE (PUA), Unicode Standard -- in 0237...
dup_glyph(_dotlessj)(_dotlessj.dup);

% Some like cedillas, some like commaaccents; elder Mac OSs like cedillas
dup_glyph(_Gcommaaccent)(_Gcedilla);
dup_glyph(_gcommaaccent)(_gcedilla);
dup_glyph(_Kcommaaccent)(_Kcedilla);
dup_glyph(_kcommaaccent)(_kcedilla);
dup_glyph(_Lcommaaccent)(_Lcedilla);
dup_glyph(_lcommaaccent)(_lcedilla);
dup_glyph(_Ncommaaccent)(_Ncedilla);
dup_glyph(_ncommaaccent)(_ncedilla);
dup_glyph(_Rcommaaccent)(_Rcedilla);
dup_glyph(_rcommaaccent)(_rcedilla);

% These are hopefully not needed:
% |dup_glyph(_dcroat)(_dmacron);|
% |dup_glyph(_dcroat)(_dbar);|
% |if unknown is_csc: dup_glyph(_dcaron)(_dquoteright); fi|
% |if unknown is_csc: dup_glyph(_tcaron)(_tquoteright); fi|
% |dup_glyph(_Lcaron)(_Lquoteright);|
% |dup_glyph(_lcaron)(_lquoteright);|
% |dup_glyph(_euro)(_Euro)|

% Hans Hagen's proposal
dup_glyph(_A)(_Alpha);
dup_glyph(_B)(_Beta);
dup_glyph(_E)(_Epsilon);
dup_glyph(_Z)(_Zeta);
dup_glyph(_H)(_Eta);
dup_glyph(_I)(_Iota);
dup_glyph(_K)(_Kappa);
dup_glyph(_M)(_Mu);
dup_glyph(_N)(_Nu);
dup_glyph(_O)(_Omicron);
dup_glyph(_P)(_Rho);
dup_glyph(_T)(_Tau);
dup_glyph(_X)(_Chi);

% Werner Lemberg's proposal (actually, he demanded only `undertie';
% `tie' and `undertieinverted' are implied by `undertie'; note
% that the Unicode Standard does not mention tieinverted):
%% \vb\- tie (``upper frown''):\- \PICT{tie}\-
if feasible_two_glyphs(_tieaccentlowercase)(_tie):
 beginglyph(_tie);
  save loose_fix_stem; save p; path p[];
  p1:=glyph_stored._tieaccentlowercase1;
  Fill p1;
  wd._tie:=xpart(urcorner p1 + llcorner p1);
  for i_:=1 upto hstem_stored._tieaccentlowercase.num:
   if ypart(hstem_stored._tieaccentlowercase[i_])>0:
    fix_hstem(ypart(hstem_stored._tieaccentlowercase[i_]))(p1);
   else:
    if ypart(hstem_stored._tieaccentlowercase[i_])=-20: ghost_stem top; fi
    if ypart(hstem_stored._tieaccentlowercase[i_])=-21: ghost_stem bot; fi
   fi
  endfor
  for i_:=1 upto vstem_stored._tieaccentlowercase.num:
   if ypart(vstem_stored._tieaccentlowercase[i_])>0:
    fix_vstem(ypart(vstem_stored._tieaccentlowercase[i_]))(p1);
   else:
    if ypart(vstem_stored._tieaccentlowercase[i_])=-20: ghost_stem rt; fi
    if ypart(vstem_stored._tieaccentlowercase[i_])=-21: ghost_stem lft; fi
   fi
  endfor
  standard_exact_hsbw("tie");
 endglyph;
fi

%% \vb\- undertie (``lower smile''):\- \PICT{undertie}\-
if feasible_two_glyphs(_tie)(_undertie):
 beginglyph(_undertie);
  save loose_fix_stem; save p; path p[];
  p1:=glyph_stored._tie1 rotatedaround (center glyph_stored._tie1,180);
  p1:=p1 shifted (0,-desc_depth-ypart(llcorner p1));
  Fill p1;
  wd._undertie:=wd._tie;
  for i_:=1 upto hstem_stored._tie.num:
   if ypart(hstem_stored._tie[i_])>0:
    fix_hstem(ypart(hstem_stored._tie[i_]))(p1);
   else:
    % |if ypart(hstem_stored._tie[i_])=-20: ghost_stem top; fi % normally|
    % |if ypart(hstem_stored._tie[i_])=-21: ghost_stem bot; fi % normally|
    if ypart(hstem_stored._tie[i_])=-21: ghost_stem top; fi % rotated
    if ypart(hstem_stored._tie[i_])=-20: ghost_stem bot; fi % rotated
   fi
  endfor
  for i_:=1 upto vstem_stored._tie.num:
   if ypart(vstem_stored._tie[i_])>0:
    fix_vstem(ypart(vstem_stored._tie[i_]))(p1);
   else:
    % |if ypart(vstem_stored._tie[i_])=-20: ghost_stem rt; fi % normally|
    % |if ypart(vstem_stored._tie[i_])=-21: ghost_stem lft; fi % normally|
    if ypart(vstem_stored._tie[i_])=-21: ghost_stem rt; fi % rotated
    if ypart(vstem_stored._tie[i_])=-20: ghost_stem lft; fi % rotated
   fi
  endfor
  standard_exact_hsbw("undertie");
 endglyph;
fi

%% \vb\- undertieinverted (``lower frown''):\- \PICT{undertieinverted}\-
if feasible_two_glyphs(_tie)(_undertieinverted):
 beginglyph(_undertieinverted);
  save loose_fix_stem; save p; path p[];
  p1:=glyph_stored._tie1 shifted
   (0,-desc_depth-ypart(llcorner glyph_stored._tie1));
  Fill p1;
  wd._undertieinverted:=wd._tie;
  for i_:=1 upto hstem_stored._tie.num:
   if ypart(hstem_stored._tie[i_])>0:
    fix_hstem(ypart(hstem_stored._tie[i_]))(p1);
   else:
    if ypart(hstem_stored._tie[i_])=-20: ghost_stem top; fi
    if ypart(hstem_stored._tie[i_])=-21: ghost_stem bot; fi
   fi
  endfor
  for i_:=1 upto vstem_stored._tie.num:
   if ypart(vstem_stored._tie[i_])>0:
    fix_vstem(ypart(vstem_stored._tie[i_]))(p1);
   else:
    if ypart(vstem_stored._tie[i_])=-20: ghost_stem rt; fi
    if ypart(vstem_stored._tie[i_])=-21: ghost_stem lft; fi
   fi
  endfor
  standard_exact_hsbw("undertieinverted");
 endglyph;
fi

endinput
%%%%EOF
