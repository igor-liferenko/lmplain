%%%% This file belongs to the Latin Modern package. The work is released
%%%% under the GUST Font License. See the MANIFEST-Latin-Modern.txt and
%%%% README-Latin-Modern.txt files for the details. For the most recent version of
%%%% this license see http://www.gust.org.pl/fonts/licenses/GUST-FONT-LICENSE.txt
%%%% or http://tug.org/fonts/licenses/GUST-FONT-LICENSE.txt

use_emergency_turningnumber; % circumventing a bug in MP

vardef is_czech_encoding =
 if known encoding_badge: (encoding_badge="CS/XL2") else: false fi
enddef;

vardef is_cork_encoding =
 if known encoding_badge: (encoding_badge="CORK") else: false fi
enddef;

vardef is_dense_encoding =
 if known encoding_badge: (encoding_badge="EUROLETT") else: false fi
enddef;

vardef is_lithuanian_encoding =
 if known encoding_badge: (encoding_badge="L7X") else: false fi
enddef;

vardef is_qxtex_encoding =
 if known encoding_badge: (encoding_badge="QX/T") else: false fi
enddef;

vardef is_rmath_encoding =
 if known encoding_badge: (encoding_badge="RMATH") else: false fi
enddef;

vardef is_tsone_encoding =
 if known encoding_badge: (encoding_badge="TS1") else: false fi
enddef;

vardef is_vn_encoding =
 if known encoding_badge: (encoding_badge="T5") else: false fi
enddef;

vardef is_yandy_encoding =
 if known encoding_badge: (encoding_badge="TEXNANSI") else: false fi
enddef;

vardef rational(expr x,nlimit,dlimit) =
 save p_,q_,s_,ds_;
 % a simplified version of the code kindly sent us by Berthold K. P. Horn
 if abs(x) <= 3epsilon: (0/1)
 elseif x < 0.0: - rational(-x, nlimit, dlimit)
 elseif floor(x) > nlimit: round(x)
 else:
  p_0 := 0; q_0 := 1; p_1 := 1; q_1 := 0; s_ := x;
  forever:
  % show p_0, q_0, p_1, q_1, floor(s_);
   if if (floor(s_)<>0):
     (p_1 > (nlimit-p_0)/floor(s_)) or (q_1 > (dlimit-q_0)/floor(s_))
    else: false fi: p_2 := p_1; q_2 := q_1;
     expandafter exitif expandafter true expandafter ;
   else:
    p_2:=p_0 + floor(s_) * p_1;
    q_2:=q_0 + floor(s_) * q_1;
   fi
   exitif (p_2 / q_2)=x;
   ds_:=s_ - floor(s_);
   exitif (abs(ds_) < 3epsilon);
   p_0 := p_1; q_0 := q_1; p_1 := p_2; q_1 := q_2;
   s_ := 1/ds_;
  endfor
  % q_2 != 0
  p_2/q_2
 fi
enddef;
vardef approximate(expr x) = rational(x,16*1024,64) enddef;
def xmate(expr x) = approximate(1000x)/1000 enddef;

vardef x_spreading(expr p)(text constraints) =
 save w_,h_,xl_,xr_; (w_,h_)=urcorner(p);
 xl_=infinity; xr_=-infinity;
 for t_:=0 upto length(p)-1:
  save x_,y_; (x_,y_)=point t_ of p;
  if constraints:
   if x_ < xl_: xl_:=x_; fi
   if x_ > xr_: xr_:=x_; fi
  fi
 endfor
 (xl_,xr_)
enddef;

vardef ellipse@#(expr start, width, height) =
 save nw, n, ne, w, c, e, sw, s, se; clearxy;
 if not path result: path result; fi
 if (str @# =""): z0 else: z@# fi =start;
 1/2[z.sw,z.se]-z0=1/2[z.se,z.ne]-z1=
 1/2[z.ne,z.nw]-z2=1/2[z.nw,z.sw]-z3=
 1/2[z.sw,z.ne]-z.c=
 z0-z.s=z1-z.e=z2-z.n=z3-z.w=origin;
 z.se-z.sw=z.ne-z.nw=(width,0);
 z.nw-z.sw=z.ne-z.se=(0,height);
 z0{right}..z1{up}..z2{left}..z3{down}..cycle
enddef;

% Definitions primarily for comm_mpg.mp

vardef feasible_two_glyphs(text gly_a, gly_b) =
 save res_; boolean res_; res_:=false;
 if ((unknown process_selected) or (known process_selected.uni_name(gly_b)))
  and (unknown ignore_selected.uni_name(gly_b)):
  if is_stored(uni_name(gly_a)):
   res_:=true;
  else:
   save gly_a_, gly_b_, name_list;
   fix_name_list uni_name(gly_a), uni_name(gly_b);
   vardef gly_a_ = substring (1,infinity) of name_list[1] enddef;
   vardef gly_b_ = substring (1,infinity) of name_list[2] enddef;
   errhelp "Go on, I'll just ignore the glyph.";
   errmessage "GLYPH " & gly_b_ & ": attempt to use not stored glyph " &
    gly_a_;
  fi
 fi
 res_
enddef;

vardef feasible_three_glyphs(text gly_a, gly_b, gly_c) =
 save res_; boolean res_; res_:=false;
 if ((unknown process_selected) or (known process_selected.uni_name(gly_c)))
  and (unknown ignore_selected.uni_name(gly_c)):
  if is_stored(uni_name(gly_a)) and is_stored(uni_name(gly_b)):
   res_:=true;
  else:
   save gly_a_, gly_b_, gly_c_, name_list;
   fix_name_list uni_name(gly_a), uni_name(gly_b), uni_name(gly_c);
   vardef gly_a_ = substring (1,infinity) of name_list[1] enddef;
   vardef gly_b_ = substring (1,infinity) of name_list[2] enddef;
   vardef gly_c_ = substring (1,infinity) of name_list[3] enddef;
   errhelp "Go on, I'll just ignore the glyph.";
   if not is_stored(uni_name(gly_a)) and not is_stored(uni_name(gly_b)):
    errmessage "GLYPH " & gly_c_ & ": attempt to use not stored glyphs " &
     gly_a_ & " and " & gly_b_;
   elseif not is_stored(uni_name(gly_a)):
    errmessage "GLYPH " & gly_c_ & ": attempt to use not stored glyph " &
     gly_a_;
   else:
    errmessage "GLYPH " & gly_c_ & ": attempt to use not stored glyph " &
     gly_b_;
   fi
  fi
 fi
 res_
enddef;

def clear_x_acc_glyph =
 def xb_acc_glyph = enddef; 
 def xe_acc_glyph = enddef; 
enddef;
clear_x_acc_glyph;

def dup_glyph(text source, result) text optshift =
 if feasible_two_glyphs(source)(result):
  beginglyph(uni_name(result));
   xb_acc_glyph;
   if unknown wd.uni_name(result):
    wd.uni_name(result):=wd.uni_name(source);
   fi
   use_glyph(uni_name(source)) optshift;
   use_stems(uni_name(source)) optshift;
   fix_exact_hsbw(wd.uni_name(result),0,0);
   xe_acc_glyph;
  endglyph;
  clear_x_acc_glyph; % _always_ clear extra actions
 fi
enddef;

def acc_glyph(text accentee, accent, result) text optshift =
 if feasible_three_glyphs(accentee)(accent)(result):
  beginglyph(uni_name(result));
   xb_acc_glyph;
   save glyph_axis_;
   if known glyph_axis.glyph_name: glyph_axis_:=glyph_axis.glyph_name; fi
   use_accent(uni_name(accentee),uni_name(accent)) optshift;
   glyph_axis.glyph_name:=glyph_axis_; % no inherited axes
   wd.uni_name(result):=wd.uni_name(accentee);
   xe_acc_glyph;
  endglyph;
 fi
 clear_x_acc_glyph; % _always_ clear extra actions
enddef;

def center_glyph_(text source,result) (expr l_adj,r_adj) =
 beginglyph(uni_name(result));
  if unknown wd.uni_name(result):
   wd.uni_name(result):=wd.uni_name(source);
  fi
  save xl_, xu_, xs_; xs_:=0; 
  xl_:=infinity; xu_:=-infinity;
  for g_:=1 upto glyph_stored.uni_name(source).num:
   xl_:=min(xl_, xpart(llcorner(glyph_stored.uni_name(source)[g_])));
   xu_:=max(xu_, xpart(urcorner(glyph_stored.uni_name(source)[g_])));
  endfor;
  xl_:=xl_-l_adj; xu_:=xu_+r_adj;
  xs_:=round(1/2wd.uni_name(result)-1/2[xl_,xu_]);
  use_glyph(uni_name(source)) (xs_,0);
  use_stems(uni_name(source)) (xs_,0);
  fix_exact_hsbw(wd.uni_name(result),0,0);
 endglyph;
enddef;

def center_glyph(text source,result) (expr l_adj,r_adj) =
 if feasible_two_glyphs(source)(result):
  center_glyph_(source)(result)(l_adj,r_adj)
 fi
enddef;

def trunc_glyph_(text source,result) (expr l_adj,r_adj) =
 beginglyph(uni_name(result));
  save xl_, xu_, xs_; xs_:=0; 
  xl_:=infinity; xu_:=-infinity;
  for g_:=1 upto glyph_stored.uni_name(source).num:
   xl_:=min(xl_, xpart(llcorner(glyph_stored.uni_name(source)[g_])));
   xu_:=max(xu_, xpart(urcorner(glyph_stored.uni_name(source)[g_])));
  endfor;
  if unknown wd.uni_name(result):
   wd.uni_name(result):=wd.uni_name(source)-round(wd.uni_name(source))
    +(xu_-xl_);
  fi
  use_glyph(uni_name(source)) (-xl_,0);
  use_stems(uni_name(source)) (-xl_,0);
  fix_exact_hsbw(wd.uni_name(result), l_adj, r_adj);
 endglyph;
enddef;

def trunc_glyph(text source,result) (expr l_adj,r_adj) =
 if feasible_two_glyphs(source)(result):
  if unknown wd.uni_name(result):
   trunc_glyph_(source)(result)(l_adj,r_adj);
  else:
   center_glyph_(source)(result)(l_adj,r_adj);
  fi
 fi
enddef;

def lap_glyph_(text source,result) (expr h_shift,v_shift) =
 beginglyph(uni_name(result));
  wd.uni_name(result):=0;
  if unknown ht.uni_name(result):
   ht.uni_name(result):=ht.uni_name(source)+v_shift;
   if ht.uni_name(result)<0: ht.uni_name(source):=0 fi;
  fi
  if unknown dp.uni_name(result):
   dp.uni_name(result):=dp.uni_name(source);
  fi
  use_glyph(uni_name(source))
   (round(h_shift-1/2wd.uni_name(source)),v_shift);
  fix_exact_hsbw(0,0,0);
 endglyph;
enddef;

def lap_glyph(text source,result) (expr h_shift,v_shift) =
 if feasible_two_glyphs(source)(result):
  lap_glyph_(source)(result)(h_shift,v_shift)
 fi
enddef;

vardef restore_glyph(text name)(suffix result) text optpaths =
 save idx_; idx_.num:=0;
 if not path result0: scantokens("path " & generisize(str result0)); fi
 for i_:=optpaths: idx_[incr idx_.num]:=i_; endfor
 if idx_.num=0:
  for i_:=1 upto glyph_stored.uni_name(name).num:
   idx_[incr idx_.num]:=i_;
  endfor 
 fi
 for i_:=1 upto idx_.num:
  result[idx_[i_]]:=restore_xoper(glyph_stored.uni_name(name)[idx_[i_]]
   shifted (glyph_shift.uni_name(name),0));
 endfor;
enddef;

vardef restore_xoper(expr p) = p enddef;

vardef left_vstem_pos(expr p, y) =
% finds the position of the leftmost stem of path |p| at height |y|;
% not particularly robust, meant for building `Ldot' and `ldot'
 save x_,p_; path p_; p_=(-infinity,y)--(infinity,y);
 for i_:=0 upto length(p) if cycle p: -1 fi:
  save t_; (t_1,t_2) = (subpath (i_,i_+1) of p) intersectiontimes p_;
  if t_1>=0:
   x_:=round(xpart point (i_+t_1) of p);
   if unknown x_.l: x_.l:=x_; fi
   if x_<x_.l: x_.r:=x_.l; x_.l:=x_;
   elseif x_>x_.l:
    if unknown x_.r: x_.r:=x_; fi
    if x_<x_.r: x_.r:=x_; fi
   fi
  fi
 endfor
 (x_.l, x_.r)
enddef;

% CM-related definitions

cmbase:=1; % don't read cmbase

string extra_begichar, extra_endchar, font_identifier, font_coding_scheme;
extra_begichar:=extra_endchar:="";
boolean square_dots, hefty, serifs, monospace, variant_g, low_asterisk,
 math_fitting;

begingroup % not too much litters
save lower, slant, stem_corr, generate, ligtable, mode_setup, font_setup, bye;

let ori_input = input; save input, generate;
def input text r = enddef;
def generate suffix t = % must be suffix, there is no semicolon after
  % nothing interesting happens here, except perhaps setting dimens,
  % but we don't need them
enddef;

def lower suffix dimen_name = % a little sweet trick
 if str dimen_name = "cap_height#": lower_cap_height# := fi
 dummy_name
enddef;

save font_size;
def font_size text t = % see lmttlc10.mp to understand why rounding is used
 pf_info_designsize if abs(round(t)-t)<eps: round(t) else: t fi;
enddef;

if known cm_pal: scantokens("ori_input " & cm_pal & ".mf;"); fi

% not always a skew font refers to a skew "pal", namely:
%
%    lmb10     refers to   cmb10
%  * lmbo10      - " -     cmb10
%    lmbx10      - " -     cmbx10
%    lmbx12      - " -     cmbx12
%    lmbx5       - " -     cmbx5
%    lmbx6       - " -     cmbx6
%    lmbx7       - " -     cmbx7
%    lmbx8       - " -     cmbx8
%    lmbx9       - " -     cmbx9
%    lmbxi10     - " -     cmbxti10
%    lmbxo10     - " -     cmbxsl10
%    lmcsc10     - " -     cmcsc10
%  * lmcsco10    - " -     cmcsc10
%    lmdunh10    - " -     cmdunh10
%  * lmduno10    - " -     cmdunh10
%    lmr10       - " -     cmr10
%    lmr12       - " -     cmr12
%    lmr17       - " -     cmr17
%    lmr5        - " -     cmr5
%    lmr6        - " -     cmr6
%    lmr7        - " -     cmr7
%    lmr8        - " -     cmr8
%    lmr9        - " -     cmr9
%    lmri10      - " -     cmti10
%    lmri12      - " -     cmti12
%    lmri7       - " -     cmti7
%    lmri8       - " -     cmti8
%    lmri9       - " -     cmti9
%    lmro10      - " -     cmsl10
%    lmro12      - " -     cmsl12
%  * lmro17      - " -     cmr17
%    lmro8       - " -     cmsl8
%    lmro9       - " -     cmsl9
%    lmss10      - " -     cmss10
%    lmss12      - " -     cmss12
%    lmss17      - " -     cmss17
%    lmss8       - " -     cmss8
%    lmss9       - " -     cmss9
%  * lmssbo10    - " -     cmssbx10
%    lmssbx10    - " -     cmssbx10
%    lmssdc10    - " -     cmssdc10
%  * lmssdo10    - " -     cmssdc10
%    lmsso10     - " -     cmssi10
%    lmsso12     - " -     cmssi12
%    lmsso17     - " -     cmssi17
%    lmsso8      - " -     cmssi8
%    lmsso9      - " -     cmssi9
%    lmssq8      - " -     cmssq8
%  * lmssqbo8    - " -     lcmssb8
%    lmssqbx8    - " -     lcmssb8
%    lmssqo8     - " -     cmssqi8
%    lmtcsc10    - " -     cmtcsc10
%  * lmtcso10    - " -     cmtcsc10
%    lmtk10      - " -     cmtt10
%  * lmtko10     - " -     cmtt10
%    lmtl10      - " -     cmtt10
%    lmtlc10     - " -     cmtt12
%  * lmtlco10    - " -     cmtt12
%  * lmtlo10     - " -     cmtt10
%    lmtt10      - " -     cmtt10
%    lmtt12      - " -     cmtt12
%    lmtt8       - " -     cmtt8
%    lmtt9       - " -     cmtt9
%    lmtti10     - " -     cmitt10
%    lmtto10     - " -     cmsltt10
%    lmu10       - " -     cmu10
%    lmvtk10     - " -     cmvtt10
%  * lmvtko10    - " -     cmvtt10
%    lmvtl10     - " -     cmvtt10
%  * lmvtlo10    - " -     cmvtt10
%    lmvtt10     - " -     cmvtt10
%  * lmvtto10    - " -     cmvtt10
%
% For the fonts marked with asterisk we locally (and redundantly)
% set the slant value.

vardef local_slant =
 save local_slant_; local_slant_:=slant;
 if jobname="lmbo10":   local_slant_:=1/6; fi
 if jobname="LMBO10":   local_slant_:=1/6; fi
 if jobname="lmcsco10": local_slant_:=1/6; fi
 if jobname="LMCSCO10": local_slant_:=1/6; fi
 if jobname="lmduno10": local_slant_:=1/6; fi
 if jobname="LMDUNO10": local_slant_:=1/6; fi
 if jobname="lmro17":   local_slant_:=1/6; fi
 if jobname="LMRO17":   local_slant_:=1/6; fi
 if jobname="lmssbo10": local_slant_:=sind12 / cosd12; fi
 if jobname="LMSSBO10": local_slant_:=sind12 / cosd12; fi
 if jobname="lmssdo10": local_slant_:=sind12 / cosd12; fi
 if jobname="LMSSDO10": local_slant_:=sind12 / cosd12; fi
 if jobname="lmssqbo8": local_slant_:=sind12 / cosd12; fi
 if jobname="LMSSQBO8": local_slant_:=sind12 / cosd12; fi
 if jobname="lmtcso10": local_slant_:=1/6; fi
 if jobname="LMTCSO10": local_slant_:=1/6; fi
 if jobname="lmtko10":  local_slant_:=1/6; fi
 if jobname="LMTKO10":  local_slant_:=1/6; fi
 if jobname="lmtlo10":  local_slant_:=1/6; fi
 if jobname="LMTLO10":  local_slant_:=1/6; fi
 if jobname="lmtlco10": local_slant_:=1/6; fi
 if jobname="LMTLCO10": local_slant_:=1/6; fi
 if jobname="lmvtko10": local_slant_:=1/6; fi
 if jobname="LMVTKO10": local_slant_:=1/6; fi
 if jobname="lmvtlo10": local_slant_:=1/6; fi
 if jobname="LMVTLO10": local_slant_:=1/6; fi
 if jobname="lmvtto10": local_slant_:=1/6; fi
 if jobname="LMVTTO10": local_slant_:=1/6; fi
 local_slant_
enddef;

slant:=local_slant;

% |body_height| is adjusted for light and dark variants, but the value
% of the |mono_charic#| is assumed to be the same in all variants:
if monospace:
 mono_charic#:=body_height#*slant; % |slant| is known locally
 if known do_condensed: mono_charic#:=mono_charic#*do_condensed; fi
 if mono_charic#<0: mono_charic#:=0; fi % shouldn't happen
 define_ps_units(mono_charic);
 mono_charwd#:=xmate(9u#);
 define_ps_units(mono_charwd);
fi

% The Scandinavian circle accent, i.e., ring, is very special in CM's,
% indeed; the battle (BJ's idiosyncrasy) for the compatibility with
% plain's \AA{} macro follows; for the settings thre original parameters
% should be used---the adjustment of parameters takes place for the light
% and dark variants---as the base (actually, the width of the letter A)
% is the same for the dark and light variants.
ring_wd_:=13u#+2cap_serif_fit#+2letter_fit#;
ring_shift_:=2/3(asc_height#-x_height#);
def ring_fintiflushki(expr slant) =
 wd._ring:=wd._Ring:=wd._ringacute:=wd._Ringacute:=
  if not monospace:
   approximate(ps_units(ring_wd_+2ring_shift_*slant)) % as in CMs
  else: mono_charwd fi;
% Unlike other characters, the width of ring depends on the slant
% and the glyph should be placed at the half of the resulting width;
% therefore, the glyph should be shifted appropriately for oblique fonts:
 ring_shift:=if not monospace: round(ps_units(ring_shift_*slant)) else: 0 fi; 
enddef;

% In slanted fonts that do not have the slanted CM counterpart (see
% the `cm_pal' macro in driver files) the macro should be be invoked
% after the setting of the italic angle (in *.mp driver files):
extra_beginfont:=extra_beginfont & ";ring_fintiflushki(slant_val);";

% support for light, dark, condensed, and extended variants

asc_height:=approximate(ps_units(asc_height#)); % used below

vardef effective_scrap =
 if known do_light: -do_light fi
 if known do_dark: +do_dark fi
enddef;

vardef effective_scale =
 asc_height/(asc_height + effective_scrap)
enddef;

vardef vpos_btransform (expr vp) =
 save res_; res_:=ps_units(vp)*effective_scale;
 tfm_units(res_)
enddef;

vardef vpos_ttransform (expr vp) =
 save res_; res_:=(ps_units(vp) + effective_scrap)*effective_scale;
 tfm_units(res_)
enddef;

vardef hstem_transform (expr hs) =
 save res_; res_:=(ps_units(hs) + effective_scrap)*effective_scale;
 tfm_units(res_)
enddef;

vardef vstem_transform (expr vs) =
 save res_; res_:=(ps_units(vs)
  if known do_condensed: * do_condensed fi
  if known do_extended: * do_extended fi
  if known do_light: -do_light if known do_condensed: x fi fi
  if known do_dark: +do_dark if known do_extended: x fi fi
 )*effective_scale;
 tfm_units(res_)
enddef;

if known do_light or known do_dark:
 forsuffixes $:= hair, cap_hair, 
  dot_size, flare, slab, rule_thickness: $.#:=hstem_transform($.#);
 endfor;
 forsuffixes $:=fine, letter_fit, serif_fit, cap_serif_fit,
  stem, cap_stem, curve, cap_curve, vair: $.#:=vstem_transform($.#);
 endfor;
 forsuffixes $:=cap_height, body_height, fig_height:
  $.#:=vpos_ttransform($.#);
 endfor;
 forsuffixes $:=crisp: % used in `orogate'; does other nibs need transforming?
  $.#:=vpos_ttransform($.#);
 endfor;
 desc_depth#:=-vpos_btransform(-desc_depth#);
 u#:=u#
   if known do_condensed: * do_condensed fi
   if known do_extended: * do_extended fi;
fi

% final touch

% variables that depend on |stem_corr#| must be set within the group
% because the name |stem_corr| is defined in fontbase (using |vardef|):
stem'#:=stem#-stem_corr#; 
vair'#:=vair#-vair_corr#;

% define PS units (an arbitrary selection, sufficient so far...)

define_ps_units(u, letter_fit, serif_fit, cap_serif_fit);
define_whole_ps_units(o, dish, math_axis);
define_even_ps_units(
 hair, cap_hair, stem, stem', cap_stem, curve, cap_curve,
 vair, vair', crisp, tiny, fine, cap_band, thin_join, 
 dot_size, flare, slab, rule_thickness
);

bar_height:=approximate(ps_units(bar_height#));
body_height:=approximate(ps_units(body_height#));
cap_height:=approximate(ps_units(cap_height#));
if known is_csc: lower_cap_height:=approximate(ps_units(lower_cap_height#)); fi
dot_size:=approximate(ps_units(dot_size#));
fig_height:=digit_height:=approximate(ps_units(fig_height#));
x_height:=approximate(ps_units(x_height#));
desc_depth:=approximate(ps_units(desc_depth#));   % ditto
numeric asc_depth#; .5[asc_height#,-asc_depth#]=math_axis#;      % |font_setup|
numeric paren_depth#; .5[body_height#,-paren_depth#]=math_axis#; % ditto
asc_depth:=approximate(ps_units(asc_depth#));
paren_depth:=approximate(ps_units(paren_depth#));

forsuffixes $=hair: % ,stem,cap_stem:
 fudged$.#:=fudge*$.#; define_whole_ps_units(fudged$);
 forever: exitif fudged$>.9fudge*$; fudged$:=fudged$+1; endfor
endfor

forsuffixes $=fine:
%%% fine $ %%%% temporary formatting convention for MFT
%   if $>fudged.hair: $:=fudged.hair; fi
   $.breadth:=$;
endfor

% Some dimens can (and thus should) be fixed in advance:
forsuffixes $:=_zero, _one, _two, _three, _four, _five, _six,
 _seven, _eight, _nine:
 ht$:=ht$prop:=fig_height;
 ic$:=ic$prop:=max(0,fig_height*slant-.5u);
endfor
%
forsuffixes $:=_six, _eight,:
 ht$oldstyle:=ht$taboldstyle:=fig_height;
 ic$oldstyle:=ic$taboldstyle:=max(0,fig_height*slant-.5u);
endfor
%
forsuffixes $:=_bracketleft, _bracketright, _braceleft, _braceright,
 _dblbracketleft, _dblbracketright, _quillbracketleft, _quillbracketright,
 _parenleft, _parenright: ht$:=body_height; dp$:=-paren_depth;
endfor
%%% @ $ %%%% restore ordinary formatting for $

% Alternative names for a couple of dimens:

thin_stem#:=hair#; thin_stem:=hair;
thin_stem'#:=cap_hair#; thin_stem':=cap_hair;
lc_stem#:=stem#; lc_stem:=stem;
lc_stem'#:=curve#; lc_stem':=curve;
uc_stem#:=cap_stem#; uc_stem:=cap_stem;
uc_stem'#:=cap_curve#; uc_stem':=cap_curve;
uc_height#:=cap_height#; uc_height:=cap_height;
overshoot#:=o#; overshoot:=o;
math_stem#:=rule_thickness#; math_stem:=rule_thickness;

endgroup;

% plain compliance:
vardef lft primary x = x + if pair x: (pen_lft,0) else: pen_lft fi enddef;
vardef rt primary x = x + if pair x: (pen_rt,0) else: pen_rt fi enddef;
vardef top primary y = y + if pair y: (0,pen_top) else: pen_top fi enddef;
vardef bot primary y = y + if pair y: (0,pen_bot) else: pen_bot fi enddef;
vardef good.x primary x = x enddef;
vardef good.y primary y = y enddef;
vardef good.lft primary z = z enddef;
vardef good.rt primary z = z enddef;
vardef good.top primary z = z enddef;
vardef good.bot primary z = z enddef;

vardef hround primary x = round x enddef;
vardef vround primary y = round y enddef;
% mfplain.mp says (why? -- BJ):
% |vardef round primary u = u enddef;|
% |vardef hround primary x = x enddef;|
% |vardef vround primary y = y enddef;|

% borrow a few cmbase macros (just in case):

vardef term.l(suffix $,$$)(expr d,t,s)= % ``robust'' sans-serif terminal
 path p_; p_=z$l{d}..tension t..z$$l;
 pair d_; d_=(x$$l-x$l,s*(y$$l-y$l));
 if (abs angle direction 1 of p_ < abs angle d_)<>(x$l<x$$l):
  p_:=z$l{d}..tension atleast t..{d_}z$$l; fi
 p_ enddef;
vardef term.r(suffix $,$$)(expr d,t,s)=
 path p_; p_=z$r{d}..tension t..z$$r;
 pair d_; d_=(x$$r-x$r,s*(y$$r-y$r));
 if (abs angle direction 1 of p_ < abs angle d_)<>(x$r<x$$r):
  p_:=z$r{d}..tension atleast t..{d_}z$$r; fi
 p_ enddef;
def rterm=reverse term enddef;

vardef stroke text t =
 forsuffixes e = l,r: path_.e:=t; endfor
 if cycle path_.l:
  errmessage "Beware: `stroke' isn't intended for cycles"; fi
 path_.l -- reverse path_.r -- cycle enddef;

vardef pos@#(expr b,d) =
 if known b: if b<=currentbreadth: errmessage "bad pos"; fi fi
 (x@#r-x@#l,y@#r-y@#l)=(b-currentbreadth,0) rotated d;
 x@#=.5(x@#l+x@#r); y@#=.5(y@#l+y@#r) enddef;

def numeric_pickup_ primary q =
 currentpen:=pen_[q];
 pen_lft:=pen_lft_[q];  pen_rt:=pen_rt_[q];
 pen_top:=pen_top_[q];  pen_bot:=pen_bot_[q];
 currentpen_path:=pen_path_[q];
 if known breadth_[q]: currentbreadth:=breadth_[q]; fi enddef;

vardef super_arc.r(suffix $,$$) = % outside of super-ellipse
 save center,corner;
 pair center,corner;
 if y$=y$r: center=(x$$r,y$r); corner=(x$r,y$$r);
 else: center=(x$r,y$$r); corner=(x$$r,y$r); fi
 z$.r{corner-z$.r}...superness[center,corner]{z$$.r-z$.r}
  ...{z$$.r-corner}z$$.r enddef;

vardef super_arc.l(suffix $,$$) = % inside of super-ellipse
 save center,corner;
 pair center,corner;
 if y$=y$r: center=(x$$l,y$l); corner=(x$l,y$$l);
 else: center=(x$l,y$$l); corner=(x$$l,y$l); fi
 z$l{corner-z$l}...superness[center,corner]{z$$l-z$l}
  ...{z$$l-corner}z$$l enddef;

vardef pulled_super_arc.r(suffix $,$$)(expr superpull) =
 save center,corner;
 pair center,corner;
 if y$=y$r: center=(x$$r,y$r); corner=(x$r,y$$r);
 else: center=(x$r,y$$r); corner=(x$$r,y$r); fi
 z$r{corner-z$r}...superness[center,corner]{z$$r-z$r}
  ...{z$$r-corner}z$$r enddef;

vardef pulled_super_arc.l(suffix $,$$)(expr superpull) =
 save center,corner,outer_point;
 pair center,corner,outer_point;
 if y$=y$r: center=(x$$l,y$l); corner=(x$l,y$$l);
  outer_point=superness[(x$$r,y$r),(x$r,y$$r)];
 else: center=(x$l,y$$l); corner=(x$$l,y$l);
  outer_point=superness[(x$r,y$$r),(x$$r,y$r)];
 fi
 z$l{corner-z$l}
  ...superpull[superness[center,corner],outer_point]{z$$l-z$l}
  ...{z$$l-corner}z$$l enddef;

vardef pulled_arc@#(suffix $,$$) =
 pulled_super_arc@#($,$$)(superpull) enddef;

% fix extra fontdimens:

let ori_use_accent = use_accent;
def use_accent(text name_char_acc) text offsets =
 accent_was_used:=1; ori_use_accent(name_char_acc) offsets;
enddef;

vardef level_height(expr h) =
 save m_,h_,h__,s_,t_,w_; string s_,t_,w_; m_:=infinity;
 % |asc_height-cap_height<o| in CMs, hence some hacking
 w_:=substring (1,infinity) of str glyph_name;
 s_:=substring (0,1) of w_; t_:=substring (1,infinity) of w_;
 if (w_="ogonek") or (w_="cedilla"):
  0
 elseif
  if (t_="") or (t_="ogonek") or (t_="cedilla"): (s_>="A") and (s_<="Z")
  else: (w_="AE") or (w_="OE") or (w_="Eth") or (w_="Eng") or (w_="Thorn")
  fi: cap_height % tentatively accented letters must have consistent heights
 elseif known is_csc and
  (if (t_="") or (t_="ogonek") or (t_="cedilla"): (s_>="a") and (s_<="z")
  else: (w_="ae") or (w_="oe") or (w_="eth") or (w_="eng") or (w_="thorn")
  fi): lower_cap_height 
 else:
  s_:=substring (0,1) of s_;
  for h_:= 0,
   if s_>"Z": asc_height else: cap_height fi,
   bar_height, body_height, dot_size, fig_height, x_height:
    if abs(h-h_)<m_: h__:=h_; m_:=abs(h-h_); fi
  endfor
  if m_<(o+1): h__ else: h fi
 fi
enddef;

vardef level_depth(expr d) =
 save m_,d_,d__; m_:=infinity;
 for d_:= 0, -desc_depth, -asc_depth:
   if abs(d-d_)<m_: d__:=d_; m_:=abs(d-d_); fi
 endfor
 if m_<(o+3): d__ else: d fi
enddef;

def fix_char_dimens =
 glyph_width:=approximate(glyph_width);
% better not ignore the original |ht| and |dp| and |ic| settings
 if unknown ht.glyph_name:
  ht.glyph_name:=if known glyph_ury: round(glyph_ury) else: 0 fi;
  if ht.glyph_name<0: ht.glyph_name:=0; fi
  ht.glyph_name:=
   if str glyph_name="_cwm": x_height % cwm's are special
   elseif str glyph_name="_cwmascender": asc_height
   elseif str glyph_name="_cwmcapital": cap_height
   else: level_height(ht.glyph_name) fi;
 fi
 if unknown dp.glyph_name:
  dp.glyph_name:=if known glyph_lly: round(glyph_lly) else: 0 fi;
  if dp.glyph_name>0: dp.glyph_name:=0; fi
  dp.glyph_name:=level_depth(dp.glyph_name);
 fi
 %
 if known accent_was_used:
  if known max_accented_height:
   if ht.glyph_name>max_accented_height:
    max_accented_height:=ht.glyph_name;
   fi
  else: max_accented_height:=ht.glyph_name; fi
 fi
 if known max_character_height:
  if ht.glyph_name>max_character_height:
   max_character_height:=ht.glyph_name;
  fi
 else: max_character_height:=ht.glyph_name; fi
 if known max_character_depth:
  if dp.glyph_name<max_character_depth:
   max_character_depth:=dp.glyph_name;
  fi
 else: max_character_depth:=dp.glyph_name; fi
 if str glyph_name="_zero": digit_width:=glyph_width; fi
 accent_was_used:=whatever;
enddef;

def fix_tfm_data(expr tipx, tipy) =
 fix_char_dimens;
 if unknown wd.glyph_name: wd.glyph_name:=glyph_width; fi
 charwd:=xmate(tfm_units(glyph_width));
 charht:=xmate(tfm_units(ht.glyph_name));
 % we use negative dp (reverse Polish convention):
 chardp:=xmate(tfm_units(-dp.glyph_name));
 % |tipx| and |tipy| are also valid for slanted font.
 if unknown ic.glyph_name:
  if monospace: ic.glyph_name:=mono_charic;
  elseif known tipx and known tipy:
   ic.glyph_name:=tipx-glyph_width+1000/36;
   if ic.glyph_name<=0: ic.glyph_name:=0; fi
  else: ic.glyph_name:=0; fi
 fi
 ic.glyph_name:=approximate(ic.glyph_name);
 charic:=xmate(tfm_units(ic.glyph_name));
 if tracingdimens>0:
  write "wd." & str glyph_name & ":=" & decimal glyph_width & "; " &
   "ht." & str glyph_name & ":=" & decimal ht.glyph_name & "; " &
   "dp." & str glyph_name & ":=" & decimal dp.glyph_name & "; " &
   "ic." & str glyph_name & ":=" & decimal ic.glyph_name & ";" to dim_file;
 fi
 if tracingdimens>1:
  if known glyph_axis.glyph_name:
   write "glyph_axis." & str glyph_name & ":=" &
    decimal glyph_axis.glyph_name & "; " to dim_file;
  fi
 fi
enddef;

def cmx_endfont =
 pf_info_fontdimen  8, xmate(cap_height#), "(non-standard: uc height)";
 pf_info_fontdimen  9, xmate(asc_height#), "(non-standard: ascender)";
 if known max_accented_height:
  if unknown process_selected:
   pf_info_fontdimen 10, xmate(tfm_units(max_accented_height)),
    "(non-standard: accented cap height)";
  fi
 fi
 pf_info_fontdimen 11, xmate(desc_depth#), "(non-standard: descender depth)";
 if known max_character_height:
  pf_info_fontdimen 12, xmate(tfm_units(max_character_height)),
   "(non-standard: max height)";
 fi
 if known max_character_depth:
 % we use negative dp (reverse Polish convention):  
  pf_info_fontdimen 13, xmate(tfm_units(-max_character_depth)),
   "(non-standard: max depth)";
 fi
 if known digit_width:
  pf_info_fontdimen 14, xmate(tfm_units(digit_width)),
   "(non-standard: digit width)";
 fi
 pf_info_fontdimen 15, xmate(cap_stem#),   "(non-standard: uc stem)";
 pf_info_fontdimen 16, xmate(tfm_units(1200)), "(non-standard: baselineskip)";
 pf_info_fontdimen 17, xmate(stem#),       "(non-standard: lc stem)";
 pf_info_fontdimen 18, xmate(u#),          "(non-standard: u, i.e., font unit)";
 pf_info_fontdimen 19, xmate(overshoot#),  "(non-standard: overshoot)";
 pf_info_fontdimen 20, xmate(thin_stem#),  "(non-standard: thin stem, hair)";
 pf_info_fontdimen 21, xmate(thin_stem'#), "(non-standard: cap thin stem, i.e., cap_hair)";
enddef;
extra_endfont:=extra_endfont & ";cmx_endfont;";

% no ``math settings'' in LMs:
def font_math_rule expr x = enddef;
def font_math_axis expr x = enddef;

% LMs are exact:
let fix_hsbw = fix_exact_hsbw;
let standard_hsbw = standard_exact_hsbw;

ignore_nib_limit:=1/4thin_stem; % without this, Euro in lmvtt10 won't work
italic_shift:=0; % in LMs italic shift is always 0

endinput
%%%%EOF
