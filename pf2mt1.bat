@echo off
:: This batch belongs to the METATYPE1 package
:: CONVERTER: Raw PostScript font --> METATYPE1 (METAPOST) font
:: Requires: t1disasm and gawk
:: AUTHORS: JNS team, JNSteam@gust.org.pl
:: NOTE: Please change the setting of METATYPE1 system variable
::       adequately to your installation -- see mt1set.bat
::
:: Set METATYPE1 environment variable:
call mt1set
if "%1"=="" goto DONE
:: prepare ``raw'' font:
t1disasm %1.pfb > %1.p
:: generate METATYPE1 font:
gawk -f%METATYPE1%/pf2mt1.awk -vOUTF=%1 -vQUIET=1 -vAFMF=%1.afm %2 %3 %4 %5 %6 %7 %8 %9 %1.p
:: delete garbages (%1.mpx is a file that contains accented glyphs):
if exist %1.p   del %1.p
if exist %1.mpx del %1.mpx
:DONE

