%%%% This file belongs to the Latin Modern package. The work is released
%%%% under the GUST Font License. See the MANIFEST-Latin-Modern.txt and
%%%% README-Latin-Modern.txt files for the details. For the most recent version of
%%%% this license see http://www.gust.org.pl/fonts/licenses/GUST-FONT-LICENSE.txt
%%%% or http://tug.org/fonts/licenses/GUST-FONT-LICENSE.txt

% LATIN MODERN font: a driver file for lmss9
input fontbase;
vardef cm_pal = "cmss9" enddef;
input comm_mac;      % common defs, CM params
input comm_mph;      % common header
input lmss9.mpm;     % metric data
input lmss9.mph;     % PS-oriented header
beginfont
input lmss9.mpg;     % ``frozen'' glyphs
input comm_mpg;      % common glyphs (mainly diacritics)
if known generating: % optimize proofing time
 input lmss9.mpl;    % ligatures and kerns
fi
endfont
%%%% EOF
