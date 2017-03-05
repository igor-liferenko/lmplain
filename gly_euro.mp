%%%% This file belongs to the Latin Modern package. The work is released
%%%% under the GUST Font License. See the MANIFEST-Latin-Modern.txt and
%%%% README-Latin-Modern.txt files for the details. For the most recent version of
%%%% this license see http://www.gust.org.pl/fonts/licenses/GUST-FONT-LICENSE.txt
%%%% or http://tug.org/fonts/licenses/GUST-FONT-LICENSE.txt

%%% round vround hround
%%% reverse stroke
% excerpted from pl_cud.mf:
ht._Euro:=cap_height;
wd._Euro:=if monospace: mono_charwd-round(u) else: if serifs: 13 else: 11.5 fi u fi;
dp._Euro:=0;

max_euro_shrink:=.7;
euro_hshrink:=
 if monospace: 0 elseif serifs: .7 else: .5 fi [1,max_euro_shrink];
wd._Euro:=euro_hshrink*wd._Euro;
euro_vshrink:= if monospace: .8 else: euro_hshrink fi;
euro_hcoeff:=if monospace: 1/2 else: (1-euro_hshrink)/(1-max_euro_shrink) fi;
euro_vcoeff:=(1-euro_vshrink)/(1-max_euro_shrink);

min_cap_band:=25; med_cap_band:=60;
cap_band_coeff:=
 min(1,((cap_band-min_cap_band)/(med_cap_band-min_cap_band)))[2,1.02];

if cap_band>80: cap_band_coeff:=.95 fi;   % lmssbx and lmssqb8 only
if cap_band>100: cap_band_coeff:=.85 fi; % lmssqb8 only

%% \vfill\break
%% \--------------------------------------------------------------------
%% Construction of the character Euro:
%% \-
%% Konstrukcja znaku Euro:
%% %
%% \PICT{Euro}
%% \--------------------------------------------------------------------
beginglyph(_Euro);
 % we override the |slant_stroke_val| setting in order to restore ``status quo
 % ante bellum'' (correcting pen stroke algorithms was really sort of a war...):
 save slant_stroke_val; vardef slant_stroke_val = 0 enddef;
 save w, h, d, q, rr, k, p;
 path q, q', q''; pair k;
 w:=wd._Euro; h:=ht._Euro; d:=dp._Euro;
 if serifs:
% |italcorr cap_height#*slant-.5u#; adjust_fit(0,0); pickup fine.nib;|
  %
  local default_nib:=fix_nib(fine, fine, 0);
  save pen_lft, pen_rt, pen_top, pen_bot;
  -pen_lft=pen_rt=pen_top=-pen_bot=1/2fine; currentbreadth:=fine;
  %
  pos1(cap_hair,0); pos2(cap_band,90);
  pos3(cap_curve,180); pos4(cap_band,270); pos5(hair,360);
  rt x1r=rt x5r=hround(w-u); lft x3r=hround u;
  % |x2=x4=.55[x3,x1];|
  x2=x4=euro_hcoeff[.55[x3,x1], .625[x3,x1]];
  top y2r=h+o; bot y4r=-o; y3=.5[y2,y4];
  % |bot y1=min(vround max(.6h,x_height-.5vair),bot y2l-eps);|
  bot y1=min(vround max(euro_vcoeff[.6h,.85h], x_height-.5vair), bot y2l-eps);
  y5=max(good.y .95(h-y1), y4l+eps);
  (x2l',y2l)=whatever[z2r,z1l]; x2l:=min(x2l',x2l+.5u);
  (x4l',y4l)=whatever[z4r,z5l]; x4l:=min(x4l',x4l+.5u);
% |filldraw stroke z1e{x2-x1,10(y2-y1)}|
% | ...pulled_arc.e(2,3) & pulled_arc.e(3,4)...{up}z5e; % arc|
  q:=
  stroke z1e{x2-x1,10(y2-y1)}
   ...pulled_arc.e(2,3) & pulled_arc.e(3,4)... {up}
   z5e; % arc
  pen_stroke()(q,p1);
  p1l:=p1l start.default;
  save t;
  p1l:=for i:=0 upto length(p1l):
    if ypart(point(i) of p1l) >= y3:
     if (known t): .. fi hide(t:=1) (point(i) of p1l)
     if ypart(postcontrol(i) of p1l) >= y3:
       .. controls (postcontrol(i) of p1l) and (precontrol(i+1) of p1l)
     fi
    fi
    endfor -- cycle;
  %
  pos6(.3[fine.breadth,cap_hair],0); x6r=x1r; top y6=h+o;
  x1r-x1'=euro_hshrink*(2cap_curve-fine); y1'=y1;
  path upper_arc; upper_arc=z1{x2-x1,10(y2-y1)}..z2{left};
  numeric t; t=xpart(upper_arc intersectiontimes (z6l--z1'));
% |filldraw z1r--z6r--z6l--subpath(t,0) of upper_arc--cycle; % barb|
  q:=z1r--z6r--z6l--subpath(t,0) of upper_arc--cycle;
  pen_stroke()(q,p2);
  if cm_pal="cmvtt10":
   % the ``skeletons'' of |p2r| and |p1l| have a conciding node,
   % namely, |z1r|, therefore, only luckily the envelopes may have one
   % coinciding node (see the loop below); hence a patch,
   % perhaps reasonable (but not needed) for other fonts as well
   p2r:=(p2r node(0)) ..
       controls (postcontrol 0 of p2r) and  (precontrol 1 of p2r) ..
       (down+p2r node(1)) .. % lower virtually coinciding node
       controls (postcontrol 1 of p2r) and  (precontrol 2 of p2r) ..
       (p2r node(2)) & (p2r.sub(2,0)) & cycle;
  fi
  save t;
  for i:=0 upto length(p1l)-1: for j:=0 upto length(p2r)-1:
   % only one pair of coinciding nodes is expected;
   % if not an error will be reported:
   if (p1l node(i))=(p2r node(j)): (t1,t2)=(i,j); fi
  endfor endfor
  q:=((p2r sub(t2+2,t2-2) intersection_join p1l sub(t1+1,t1-1)) --
     p2r sub(t2,t2+2) & cycle) start.default;
  save t; t.x=infinity;
  for i:=0 upto length(q):
   t.c:=ypart(point(i) of q);
   if (t.c<=t.x) or (abs(t.c-t.x)<eps): t.x:=t.c; t:=i; fi
  endfor
  q:=q sub (t, t-1) &&
   reverse(q sub (t, t-1)
    reflectedabout(point (t-1) of q, point (t) of q)) && cycle;
  k=unitvector(z1-z4);
  y8-y3=y3-y10=2round(1/2cap_band_coeff*cap_band);
  rt z7=z4^k; y7=y8;
  rt z9=z4^k; y9=y10;
  lft x8=lft x10=0;
  begingroup
   if fine>5/6cap_band: % may likely happen in tt fonts; a patch:
    save fine; fine:=2round(3/8cap_band);
    default_nib:=fix_nib(fine, fine, 0);
   fi
   forsuffixes $:=7,8,9,10:
    1/2[z$l,z$r]=z$; y$r-y$l=cap_band-fine; z$r=z$l^k;
   endfor
   q':=z7r--z8r--z8l--z7l--cycle; pen_stroke()(q',p); q':=p.r;
   q'':=z9r--z10r--z10l--z9l--cycle; pen_stroke()(q'',p); q'':=p.r;
   fix_vstem(cap_curve)(q);
   find_outlines(q,q')(p1); find_outlines(p1[1],q'')(p2);
   % a nasty battle against nasty rounding (should have been done
   % before the |find_outlines| operations, would be more efficient)
   % |path_labels.lft(p2[1])3;|
   p2[1]:=delete_nodes(p2[1])((4,-1),(23,-1),(31,-1),(52,-1));
   % 1. right side of bars
   % |path_labels.lft(p2[1])3;|
   p2[1]:=(p2[1]sub(30,20))
     {right}..{(p2[1]node(22))-(p2[1]node(21))}
     (p2[1]node(21)) .. controls (p2[1]node(21)) and (p2[1]node(22)) .. (p2[1]node(22))
     {(p2[1]node(22))-(p2[1]node(21))}..{left}
     (p2[1]sub(23,27))
     {right}..{(p2[1]node(29))-(p2[1]node(28))}
     (p2[1]node(28)) .. controls (p2[1]node(28)) and (p2[1]node(29)) .. (p2[1]node(29))
     {(p2[1]node(29))-(p2[1]node(28))}..{left}
     cycle;
   % 2. left side of bars
   % |path_labels.lft(p2[1])3;|
   p2[1]:=(p2[1]sub(15,16))
     {left}..{(p2[1]node(18))-(p2[1]node(17))}
     (p2[1]node(17)) .. controls (p2[1]node(17)) and (p2[1]node(18)) .. (p2[1]node(18))
     {(p2[1]node(18))-(p2[1]node(17))}..{right}
     (p2[1]sub(19,23))
     {left}..{(p2[1]node(25))-(p2[1]node(24))}
     (p2[1]node(24)) .. controls (p2[1]node(24)) and (p2[1]node(25)) .. (p2[1]node(25))
     {(p2[1]node(25))-(p2[1]node(24))}..{right}
     (p2[1]sub(26,15)) & cycle;
   Fill p2[1];
   fix_hstem(cap_band)(p2[1]);
   fix_hsbw(w,round(u),0);
  endgroup;
  endlocal
 else: % sans serif
  if known is_bold: local ignore_nib_limit:=1/2ignore_nib_limit; fi
% |italcorr cap_height#*slant-.5u#; adjust_fit(0,0); pickup fine.nib;|
  %
  if fine>0: local default_nib:=fix_nib(fine, fine, 0); fi
  save pen_lft, pen_rt, pen_top, pen_bot;
  -pen_lft=pen_rt=pen_top=-pen_bot=1/2fine; currentbreadth:=fine;
  %
  pos1(1.2flare,80); pos2(slab,90);
  pos3(cap_curve,180); pos4(slab,270); pos5(flare,275);
  rt x1r=hround(w-1.1u); x2=x4=.5w+1.25u;
  lft x3r=hround max(u,2u-.5cap_curve); rt x5r=hround(w-.9u);
  top y1r=vround .95h+o; top y2r=h+o; y3=.5h;
  bot y4r=-o; bot y5r=vround .08h-o; y5l:=good.y y5l; x5l:=good.x x5l;
% |filldraw stroke rterm.e(2,1,right,.9,4) & super_arc.e(2,3)|
% | & super_arc.e(3,4) & term.e(4,5,right,.8,4);  % arc and terminals|
  q:=
   reverse stroke rterm.e(2,1,right,.9,4) & super_arc.e(2,3)
   & super_arc.e(3,4) & term.e(4,5,right,.8,4);  % arc and terminals
  if fine>0: pen_stroke()(q,p); q:=p.r; fi
% k=unitvector(z1-z4);
  k=right rotated 80;
  y8-y3=y3-y10=2round(1/2cap_band_coeff*cap_band);
  rt z7=z1^k; y7=y8;
  rt z9=z1^k; y9=y10;
  lft x8=lft x10=0;
  forsuffixes $:=7,8,9,10:
   1/2[z$l,z$r]=z$; y$r-y$l=cap_band-fine; z$r=z$l^k;
  endfor
  q':=z7r--z8r--z8l--z7l--cycle;
  q'':=z9r--z10r--z10l--z9l--cycle;
  if fine>0: pen_stroke()(q',p); q':=p.r; fi
  if fine>0: pen_stroke()(q'',p); q'':=p.r; fi
  fix_vstem(cap_curve)(q);
  find_outlines(q,q')(p1); find_outlines(p1[1],q'')(p2); Fill p2[1];
  fix_hstem(cap_band)(p2[1]);
  fix_hstem(slab)(p2[1]);
  fix_hsbw(w,round(u),0);
  if fine>0: endlocal fi
  if known is_bold: endlocal; fi
 fi
% |path_labels(p2[1]);|
 just_labels(1,1',2,3,4,5,6,7,8,9,10);
 if not monospace: ic.glyph_name:=max(0,cap_height*slant_val-.5u); fi
 wd._Euro:=glyph_width;
endglyph;

endinput
%%%%EOF

