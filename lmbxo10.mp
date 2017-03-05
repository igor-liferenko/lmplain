%%%% This file belongs to the Latin Modern package. The work is released
%%%% under the GUST Font License. See the MANIFEST-Latin-Modern.txt and
%%%% README-Latin-Modern.txt files for the details. For the most recent version of
%%%% this license see http://www.gust.org.pl/fonts/licenses/GUST-FONT-LICENSE.txt
%%%% or http://tug.org/fonts/licenses/GUST-FONT-LICENSE.txt

% LATIN MODERN font: a driver file for lmbxo10
is_bold:=1;
input fontbase;
vardef cm_pal = "cmbxsl10" enddef;
input comm_mac;      % common defs, CM params
input comm_mph;      % common header
input lmbx10.mpm;    % metric data
input lmbx10.mph;    % PS-oriented header
pf_info_familyname "LMRomanSlant10";
pf_info_pfm family_name, 1, 0;
pf_info_fontname family_name & "-Bold";
pf_info_italicangle angle(1,1/6);
beginfont
input lmbx10.mpg;    % ``frozen'' glyphs
input comm_mpg;      % common glyphs (mainly diacritics)
if known generating: % optimize proofing time
 input lmbx10.mpl;   % ligatures and kerns
fi
endfont
%%%% EOF
