@echo off
:: This batch belongs to the METATYPE1 package
:: A ``SECOND HALF'' of mkfont1.bat (rather not for main distribution)
:: Requires: mpost
:: AUTHORS: JNS team, JNSteam@gust.org.pl
:: %1 -- the font name (WITHOUT extension; must be `mp')
:: %2 -- the resulting directory name (without the ending slash), maybe empty
:: Output: %1.tfm, %1.enc, %1.log, and either %1.map (if %2 is empty)
::         or psfonts.map (otherwise).
@echo off
mpost \generating:=1; \input %1.mp
if "%2"=="" goto DONE
if exist %1.log xcopy /Y /Q %1.log %2\*.* > nul
if exist %1.tfm xcopy /Y /Q %1.tfm %2\*.* > nul
if exist %1.enc xcopy /Y /Q %1.enc %2\*.* > nul
if exist %1.map type %1.map >> %2\psfonts.map
if exist %1.dim xcopy /Y /Q %1.dim %2\*.* > nul
if exist %1.log del %1.log
if exist %1.tfm del %1.tfm
if exist %1.enc del %1.enc
if exist %1.map del %1.map
if exist %1.dim del %1.dim
:DONE
if exist %1.ps del %1.ps
if exist piclist.tex del piclist.tex

