%%%% This file belongs to the Latin Modern package. The work is released
%%%% under the GUST Font License. See the MANIFEST-Latin-Modern.txt and
%%%% README-Latin-Modern.txt files for the details. For the most recent version of
%%%% this license see http://www.gust.org.pl/fonts/licenses/GUST-FONT-LICENSE.txt
%%%% or http://tug.org/fonts/licenses/GUST-FONT-LICENSE.txt

% LATIN MODERN font: a driver file for lmtl10
do_light:=20;
input fontbase;
vardef cm_pal = "cmtt10" enddef;
input comm_mac;      % common defs, CM params
input comm_mph;      % common header
input lmtt10.mpm;    % metric data
input lmtl10.mph;    % PS-oriented header
beginfont
input lmtl10.mpg;    % ``frozen'' glyphs
input comm_mpg;      % common glyphs (mainly diacritics)
if known generating: % optimize proofing time
 input lmtt.mpl;     % ligatures and kerns
fi
endfont
%%%% EOF
