%%%% This file belongs to the Latin Modern package. The work is released
%%%% under the GUST Font License. See the MANIFEST-Latin-Modern.txt and
%%%% README-Latin-Modern.txt files for the details. For the most recent version of
%%%% this license see http://www.gust.org.pl/fonts/licenses/GUST-FONT-LICENSE.txt
%%%% or http://tug.org/fonts/licenses/GUST-FONT-LICENSE.txt

%%% round vround hround
%%% reverse stroke

%% \vfill\break
%% \--------------------------------------------------------------------
%% Construction of the character infinity:
%% \-
%% Konstrukcja znaku infinity:
%% %
%% \PICT{infinity}
%% \--------------------------------------------------------------------
wd._infinity:=
 if monospace: if known do_condensed: do_condensed* fi mono_charwd 
 else: 18u fi;
 ht._infinity:=x_height; dp._infinity:=0;

beginglyph(_infinity);
 save w,h,d,oo;
 w:=round wd._infinity; h:=round ht._infinity; d:=dp._infinity; oo:=round 1/2o;
 % |italcorr .7x_height#*slant-.5u#; adjust_fit(0,0); pickup fine.nib;|
 %
 save theta, phi;
 % in the following, changes relevant to |monospace| fonts usually were
 % not introduced originally; the ``patchwork'' haven't helped too much...
 if monospace: % original
  phi=-theta=90; else: phi=angle(4u,h); theta=angle(6u,-h);
 fi
 save extra_shift, extra_rot, extra_med;
 extra_shift:=if monospace: round 1/2curve else: 0 fi;
 extra_rot:=if monospace: 0 else: 1/2 fi;
 extra_med:=if monospace: .475 else: .4 fi;
 if monospace or known is_vtt: local fine:=0; fi
 if fine>0: local default_nib:=fix_nib(fine, fine, 0); fi
 save pen_lft, pen_rt, pen_top, pen_bot;
 -pen_lft=pen_rt=pen_top=-pen_bot=1/2fine; currentbreadth:=fine;
 %
 pos1(vair,180);
 pos2(.5[vair,curve],90 + theta);
 pos3(curve,90+theta);
 pos4(curve,90+theta);
 pos5(.5[vair,curve],90 + theta);
 pos6(vair,180);
 pos7(.2[vair,curve],270 + phi);
 pos8(.3[vair,curve],270+phi);
 pos9(.2[vair,curve],270 + phi);
 lft x1r=w-rt x6l=hround (if monospace: 2/3 fi u);
 x2=x9=extra_med[x1,x8];
 x5=x7=(1-extra_med)[x8,x6];
 if monospace: x2l:=x2r; x5r:=x5l; x7r:=x7l; x9l:=x9r; fi % original
 y1=y6=.5h; top y2r=top y7l=h+oo-extra_shift; bot y5l=bot y9r=-oo+extra_shift;
 x8=.5[x3,x4]=.5w; y8=.5[y3,y4]=.5h;
 y3-y4=(h-2extra_shift)/3; z3-z4=whatever*dir theta;
 % | filldraw stroke z1e{up}...z2e{right}...z3e---z4e...z5e{right}|
 % | ...z6e{up}...z7e{left}...{-dir phi}z8e...{left}z9e...z1e{up}; % bowls|
 %
 save lp,q,s,v; path lp[],q;
 q := % skeleton
  z1{up}...z2{right}...z3---z4...z5{right}
  ...z6{up}...z7{left}...{-dir phi}z8...{left}z9...z1{up} & cycle;
 % |draw q italicized withcolor red;|
 lp1:=fix_razor_nib(vair,180);
 lp2:=fix_razor_nib(round .5[vair,curve],90 + extra_rot*theta);
% |lp3:=fix_razor_nib(curve,90+theta);|
 lp3:=fix_razor_nib(round(if monospace: 2/3 fi curve),90+theta);
% |lp4:=fix_razor_nib(curve,90+theta);|
 lp4:=fix_razor_nib(round(if monospace: 2/3 fi curve),90+theta);
 lp5:=fix_razor_nib(round .5[vair,curve],90 + extra_rot*theta);
 lp6:=fix_razor_nib(vair,180);
 lp7:=fix_razor_nib(round .2[vair,curve],270 + extra_rot*phi);
% |lp8:=fix_razor_nib(round .3[vair,curve],270+phi);|
 lp8:=fix_razor_nib(round (if monospace: 3/4 fi (.3[vair,curve])),270+phi);
 lp9:=fix_razor_nib(round .2[vair,curve],270 + extra_rot*phi);
 pen_stroke(nib(lp1)(0) nib(lp2)(1) nib(lp3)(2) nib(lp4)(3) nib(lp5)(4)
   nib(lp6)(5) nib(lp7)(6) nib(lp8)(7) nib(lp9)(8)) (q)(v1);
 % |v1r| and |v1l|: approximation of original (`|stroke|') outlines;
 % to be stroked again with |fine.nib|:
 v1r:=correct_close_doublets(v1r,10);
 v1l:=correct_close_doublets(v1l,10);
 if fine>0:
  pen_stroke ()(v1r)(v2); pen_stroke ()(v1l)(v3);
 else:
  v2r:=v1r; v3r:=v1l;
 fi
 % split loops:
 find_outlines(v2r)(s1); find_outlines(reverse v2r)(s2);
 % why it wasn't needed earlier? (in this release, lmbo10 needs this):
 find_outlines(v3r)(s3);
 find_outlines(reverse v3r)(s4);
 % and join outer parts:
 find_outlines(reverse s2 1,reverse s4 1)(s5);
 s5 1:=correct_close_doublets(s5 1,25);
 unFill s1 1, s3 1; Fill s5 1;
 penlabels(1,2,3,4,5,6,7,8,9); path_labels(s1 1, s3 1, s5 1)4;
 %
 save loose_fix_stem;
 fix_hsbw(w,0,0); wd._infinity:=glyph_width;
 save a,b;
 a=round ypart (.5[vair,curve]*up rotated (extra_rot*theta));
 b=round ypart (.2[vair,curve]*up rotated (extra_rot*phi));
 for h_:=a+fine, a+fine+1, a+fine-1, b+fine, b+fine+1, b+fine-1:
  % compensating par force for rounding errors
  fix_hstem(h_)(s1 1, s3 1, s5 1);
 endfor;
 fix_vstem(fine+vair)(s1 1, s3 1, s5 1);
 if not monospace: ic.glyph_name:=max(0,.7x_height*slant_val-.5u); fi
 if fine>0: endlocal; fi
 if monospace or known is_vtt: endlocal; fi
endglyph;

endinput
%%%%EOF
