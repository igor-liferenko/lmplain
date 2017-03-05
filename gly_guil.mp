%%%% This file belongs to the Latin Modern package. The work is released
%%%% under the GUST Font License. See the MANIFEST-Latin-Modern.txt and
%%%% README-Latin-Modern.txt files for the details. For the most recent version of
%%%% this license see http://www.gust.org.pl/fonts/licenses/GUST-FONT-LICENSE.txt
%%%% or http://tug.org/fonts/licenses/GUST-FONT-LICENSE.txt

%%% round vround hround
%%% reverse stroke
% The proportion of |vair/stem| depends drastically on resolution;
% e.g., for 300 dpi cmbx10 |vair=1| and |stem=5|, for 746 dpi cmbx10
% (300 dpi, magstep 5) |vair=4| and |stem=12|, while, sharply speaking,
% |stem#/vair#=3.15381|; hence a new variable |xvair| has been introduced
% to be used in some crucial places instead of |vair|.
% |vardef xvair = stem*vair#/stem# enddef;|
vardef xvair = lc_stem*vair#/stem# enddef;

if not monospace:

% In particular, |qvair| (``quote vair'') is defined using |xvair|.
vardef qvair = max(round(xvair),fine+epsilon) enddef;

wd._guillemotleft:=wd._guillemotright:=approximate(if serifs: 10 else: 9 fi u);
ht._guillemotleft:=ht._guillemotright:=approximate(2bar_height);
dp._guillemotleft:=dp._guillemotright:=0;

% these will change:
wd._guilsinglleft:=wd._guilsinglright:=wd._guillemotleft;
ht._guilsinglleft:=ht._guilsinglright:=ht._guillemotleft;
dp._guilsinglleft:=dp._guilsinglright:=dp._guillemotleft;

%% \vfill\break
%% \--------------------------------------------------------------------
%% Construction of the character guillemotleft:
%% \-
%% Konstrukcja znaku guillemotleft:
%% %
%% \PICT{guillemotleft}
%% \--------------------------------------------------------------------
beginglyph(_guillemotleft);
 save w,h,d;
 w:=wd._guillemotleft; h:=ht._guillemotleft; d:=-dp._guillemotleft;
% |adjust_fit(0,0); pickup fine.nib;|
 save pen_lft, pen_rt, pen_top, pen_bot;
 -pen_lft=pen_rt=pen_top=-pen_bot=1/2fine; currentbreadth:=fine;
 save the_shift, shift_corr;
 the_shift=hround(max(3u,1.7lc_stem)); shift_corr=the_shift-3u;
 pos1(qvair,0); pos2(if monospace: qvair else: lc_stem fi,0); pos3(qvair,0);
 rt x1r=rt x3r=hround(5u-shift_corr)-eps;
 lft x2l=hround(if not monospace: 2 fi\\ u-shift_corr)-eps;
 bot y3=0; y2=good.y(h/2); top y1=2y2;
 for i:=1,2,3:
  forsuffixes $:=r, ,l: z[i]'$=z[i]$ + the_shift*right; endfor
 endfor
 save p,q; path p[];
 if not serifs:
  p1:=stroke z1e--z2e--z3e; p2:=stroke z1'e--z2'e--z3'e;
 else:
  % |filldraw|
  p1:=stroke z1e{(x2e-x1e),1.8(y2e-y1e)}..{curl1}z2e{curl1}..
   {(x3e-x2e),1.8(y3e-y2e)}z3e;
  p2:=stroke
   z1'e{(x2'e-x1'e),1.8(y2'e-y1'e)}..{curl1}z2'e{curl1}..
   {(x3'e-x2'e),1.8(y3'e-y2'e)}z3'e;
 fi;
 if fine>0:
  local default_nib:=fix_nib(fine, fine, 0);
   pen_stroke()(p1,q); p1:=q.r; pen_stroke()(p2,q); p2:=q.r;
  endlocal
 fi
 Fill p1, p2;
 ghost_stem bot, top;
 fix_exact_hsbw(wd._guillemotleft,letter_fit,letter_fit);
% italic correction is set to |0| in |beginchar|, so let's correct it
% |corrital z1'r;|
 penlabels(1,2,3,1',2',3');
endglyph;

%% \vfill\break
%% \--------------------------------------------------------------------
%% Construction of the character guillemotright:
%% \-
%% Konstrukcja znaku guillemotright:
%% %
%% \PICT{guillemotright}
%% \--------------------------------------------------------------------
beginglyph(_guillemotright);
 save w,h,d;
 w:=wd._guillemotright; h:=ht._guillemotright; d:=-dp._guillemotright;
 % |adjust_fit(0,0); pickup fine.nib;|
 save pen_lft, pen_rt, pen_top, pen_bot;
 -pen_lft=pen_rt=pen_top=-pen_bot=1/2fine; currentbreadth:=fine;
 save the_shift,shift_corr;
 the_shift=hround(max(3u,1.7lc_stem)); shift_corr=the_shift-3u;
 pos1(qvair,0); pos2(if monospace: qvair else: lc_stem fi,0); pos3(qvair,0);
 lft x1l=lft x3l=w-hround(5u-shift_corr)+eps;
 rt x2r=w-hround(if not monospace: 2 fi\\ u-shift_corr)+eps;
 bot y3=0; y2=good.y(h/2); top y1=2y2;
 for i:=1,2,3:
  forsuffixes $:=r, ,l: z[i]'$=z[i]$ + the_shift*left; endfor
 endfor
 save p; path p[];
 if not serifs:
  p1:=stroke z1e--z2e--z3e; p2:=stroke z1'e--z2'e--z3'e;
 else:
  p1:=stroke
   z1e{(x2e-x1e),1.8(y2e-y1e)}..{curl1}z2e{curl1}..
   {(x3e-x2e),1.8(y3e-y2e)}z3e;
  p2:=stroke
   z1'e{(x2'e-x1'e),1.8(y2'e-y1'e)}..{curl1}z2'e{curl1}..
   {(x3'e-x2'e),1.8(y3'e-y2'e)}z3'e;
 fi;
 if fine>0:
  local default_nib:=fix_nib(fine, fine, 0);
   pen_stroke()(p1,q); p1:=q.r; pen_stroke()(p2,q); p2:=q.r;
  endlocal
 fi
 Fill p1, p2;
 ghost_stem bot, top;
 fix_exact_hsbw(wd._guillemotright,letter_fit,letter_fit);
% italic correction is set to |0| in |beginchar|, so let's correct it
% |corrital z2r;|
 penlabels(1,2,3,1',2',3');
endglyph;
% ------------------------------------------------------------------------

%% \vfill\break
%% \--------------------------------------------------------------------
%% Construction of the character guilsinglleft:
%% \-
%% Konstrukcja znaku guilsinglleft:
%% %
%% \PICT{guilsinglleft}
%% \--------------------------------------------------------------------
beginglyph(_guilsinglleft);
 save the_shift; the_shift=hround(max(3u,1.7lc_stem));
 Fill glyph_stored._guillemotleft1;
 ghost_stem bot, top;
 fix_exact_hsbw(wd._guilsinglleft,0,-the_shift);
 wd._guilsinglleft:=glyph_width;
endglyph;

%% \vfill\break
%% \--------------------------------------------------------------------
%% Construction of the character guilsinglright:
%% \-
%% Konstrukcja znaku guilsinglright:
%% %
%% \PICT{guilsinglright}
%% \--------------------------------------------------------------------
beginglyph(_guilsinglright);
 save the_shift; the_shift=hround(max(3u,1.7lc_stem));
 Fill glyph_stored._guillemotright1;
 ghost_stem bot, top;
 fix_exact_hsbw(wd._guilsinglright,-the_shift,0);
 wd._guilsinglright:=glyph_width;
endglyph;

fi

endinput
%%%%EOF


