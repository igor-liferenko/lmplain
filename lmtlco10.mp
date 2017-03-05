%%%% This file belongs to the Latin Modern package. The work is released
%%%% under the GUST Font License. See the MANIFEST-Latin-Modern.txt and
%%%% README-Latin-Modern.txt files for the details. For the most recent version of
%%%% this license see http://www.gust.org.pl/fonts/licenses/GUST-FONT-LICENSE.txt
%%%% or http://tug.org/fonts/licenses/GUST-FONT-LICENSE.txt

% LATIN MODERN font: a driver file for lmtlc10
do_light:=19; do_light.x:=1; do_condensed:=.68017; 
input fontbase;
vardef cm_pal = "cmtt12" enddef;
pt#:=10/12; input comm_mac; pt#:=1; % common defs, CM params
input comm_mph;      % common header
input lmtlc10.mpm;   % metric data
input lmtlc10.mph;   % PS-oriented header
pf_info_pfm family_name, 0, 1;
pf_info_fontname family_name & "-Oblique";
pf_info_italicangle angle(1,1/6);
beginfont
input lmtlc10.mpg;   % ``frozen'' glyphs
input comm_mpg;      % common glyphs (mainly diacritics)
if known generating: % optimize proofing time
 input lmtt.mpl;     % ligatures and kerns
fi
endfont
%%%% EOF
