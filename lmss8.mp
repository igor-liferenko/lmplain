%%%% This file belongs to the Latin Modern package. The work is released
%%%% under the GUST Font License. See the MANIFEST-Latin-Modern.txt and
%%%% README-Latin-Modern.txt files for the details. For the most recent version of
%%%% this license see http://www.gust.org.pl/fonts/licenses/GUST-FONT-LICENSE.txt
%%%% or http://tug.org/fonts/licenses/GUST-FONT-LICENSE.txt

% LATIN MODERN font: a driver file for lmss8
input fontbase;
vardef cm_pal = "cmss8" enddef;
input comm_mac;      % common defs, CM params
input comm_mph;      % common header
input lmss8.mpm;     % metric data
input lmss8.mph;     % PS-oriented header
beginfont
input lmss8.mpg;     % ``frozen'' glyphs
input comm_mpg;      % common glyphs (mainly diacritics)
if known generating: % optimize proofing time
 input lmss8.mpl;    % ligatures and kerns
fi
endfont
%%%% EOF
