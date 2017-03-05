@echo off
:: This batch is distributed with the METATYPE1 package
:: CONVERTER: text metric AFM --> binary metric PFM (for Windows)
:: Requires: perl
:: AUTHORS: JNS team, JNSteam@gust.org.pl
:: NOTE: Please change the setting of METATYPE1 system variable
::       adequately to your installation -- see mt1set.bat
::
:: Set METATYPE1 environment variable:
call mt1set
:: default set of characters is CharSet:255 (OEM Character Set)
perl -w %METATYPE1%/afm2pfm.pl %1.afm %1.pfm %2 %3 %4 %5 %6 %7 %8 %9
