%%%% This file belongs to the Latin Modern package. The work is released
%%%% under the GUST Font License. See the MANIFEST-Latin-Modern.txt and
%%%% README-Latin-Modern.txt files for the details. For the most recent version of
%%%% this license see http://www.gust.org.pl/fonts/licenses/GUST-FONT-LICENSE.txt
%%%% or http://tug.org/fonts/licenses/GUST-FONT-LICENSE.txt

%%% round vround hround
%%% reverse stroke

if not monospace:

wd._visiblespace:=approximate(9u);
ht._visiblespace:=approximate(bar_height);
dp._visiblespace:=approximate(1/2descender);

%% \vfill\break
%% \--------------------------------------------------------------------
%% Construction of the character uni2423 (visiblespace):
%% \-
%% Konstrukcja znaku uni2423 (visiblespace):
%% %
%% \PICT{uni2423}
%% \--------------------------------------------------------------------
beginglyph(_visiblespace);
save w,h,d; w:=wd._visiblespace; h:=ht._visiblespace; d:=-dp._visiblespace;
% |italcorr bar_height#*slant-.25u#; adjust_fit(0,0);|
save thin_vair; thin_vair#=.7vair#;
define_even_ps_units(thin_vair);
% define_whole_blacker_pixels(thin_vair);
forsuffixes $=1,2,3,4: penpos$(thin_vair,0); endfor
penpos0(thin_vair,90); x0=.5w; y0l=vround(-d-.5thin_vair);
x1=x2; x3=x4=w-x1;
lft x1l=hround .75u; % why lft?
y1=y4=h; y2=y3=y0;
save p; path p;
p=z1l---z2l...(x2,y0l)---(x3,y0l)...z3r---z4r
 ..z4l---(x3l,y0r)--(x2r,y0r)---z1r..cycle;  % the stroke
Fill p;
just_labels(0,1,2,3,4);
fix_vstem(thin_vair)(p);
fix_hstem(thin_vair)(p);
fix_exact_hsbw(wd._visiblespace,letter_fit,letter_fit);
wd._visiblespace:=glyph_width;
endglyph;

fi

endinput
%%%%EOF

