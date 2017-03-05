@echo off
:: This batch belongs to the METATYPE1 package
:: CONVERTER: METATYPE1 (METAPOST) sources --> Type 1 font + TeX/dvips files
:: Requires: mpost, gawk, afm2pfm (perl), t1asm (1.24 or later)
:: AUTHORS: JNS team, JNSteam@gust.org.pl
:: NOTE: Please change the setting of METATYPE1 system variable
::       adequately to your installation -- see mt1set.bat
:: %1 -- the font name (WITHOUT extension; must be `mp')
:: %2 -- the resulting directory name (without ending slash), maybe empty
:: Output:
::   %1.afm, %1.pfb, %1.tfm, %1.log (from the first MP pass), %1.pfm,
::   %1.enc, and either %1.map (if %2 is empty) or psfonts.map (otherwise).
::
:: Set METATYPE1 environment variable:
call mt1set
if "%1"=="" goto DONE
::PFB+AFM
mpost \generating:=0; \input %1.mp
if exist %1.log copy /b %1.log %1.lo1 > nul 
if exist %1.dim copy /b %1.dim %1.di > nul 
if exist pfcommon.dat goto LOCDAT
gawk -f %METATYPE1%/mp2pf.awk -vCD=%METATYPE1%/pfcommon.dat -vNAME=%1
goto PFCONT
:LOCDAT
gawk -f %METATYPE1%/mp2pf.awk -vNAME=%1
:PFCONT
if errorlevel==1 goto DONE
gawk -f%METATYPE1%/packsubr.awk -vVERBOSE=1 -vLEV=5 -vOUP=%1.pn %1.p
call afm2pfm %1
t1asm -b %1.pn %1.pfb
if "%2"=="" goto TFM
if exist %1.lo1 xcopy /Y /Q %1.lo1 %2\*.* > nul
if exist %1.pfb xcopy /Y /Q %1.pfb %2\*.* > nul
if exist %1.afm xcopy /Y /Q %1.afm %2\*.* > nul
if exist %1.pfm xcopy /Y /Q %1.pfm %2\*.* > nul
if exist %1.di  xcopy /Y /Q %1.di  %2\*.dim > nul
if exist %1.lo1 del %1.lo1
if exist %1.pfb del %1.pfb
if exist %1.afm del %1.afm
if exist %1.pfm del %1.pfm
if exist %1.di  del %1.di
:TFM
mpost \generating:=1; \input %1.mp
if exist %1.log copy /b %1.log %1.lo2 > nul 
if "%2"=="" goto DONE
if exist %1.lo2 xcopy /Y /Q %1.lo2 %2\*.* > nul
if exist %1.tfm xcopy /Y /Q %1.tfm %2\*.* > nul
if exist %1.enc xcopy /Y /Q %1.enc %2\*.* > nul
if exist %1.map type %1.map >> %2\psfonts.map
if exist %1.lo2 del %1.lo2
if exist %1.tfm del %1.tfm
if exist %1.enc del %1.enc
if exist %1.map del %1.map
:DONE
if exist %1.ps del %1.ps
if exist %1.1* del %1.1*
if exist %1.2* del %1.2*
if exist %1.3* del %1.3*
if exist %1.5* del %1.5*
if exist %1.6* del %1.6*
if exist %1.7* del %1.7*
if exist %1.8* del %1.8*
if exist %1.9* del %1.9*
if exist %1.log del %1.log
::
if exist %1.dim del %1.dim
if exist %1.di  copy /b %1.di %1.dim > nul
if exist %1.di  del %1.di
::
if exist %1.pfi del %1.pfi
if exist %1.kpx del %1.kpx
if exist %1.p del %1.p
if exist %1.pn del %1.pn
if exist piclist.tex del piclist.tex

