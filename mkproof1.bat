@echo off
:: This batch belongs to the METATYPE1 package
:: CONVERTER: METATYPE1 (METAPOST) source --> TeX proof file
:: Requires: mpost, mft (web2c distribution), epsincl (gawk)
:: AUTHORS: JNS team, JNSteam@gust.org.pl
:: NOTE: Please change the setting of METATYPE1 system variable
::       adequately to your installation -- see mt1set.bat
:: %1 -- driver file name (WITHOUT extension; must be `mp')
:: %2 -- proof file name (WITH extension); if empty or asterisk -- a driver
::       file name is used; if it is asterisk -- the third parameter is
::       assumed to be non-empty (see below)
:: %3 -- `no-mpost' marker; if not empty -- no mposting is performed
::
:: Set METATYPE1 environment variable:
call mt1set
if "%1"=="" goto NIC
set _SECPARM=%2
set _THIPARM=%3
if "%2"=="" set _SECPARM=%1.mp
if "%2"=="*" set _SECPARM=%1.mp
if "%2"=="*" set _THIPARM=*
if not "%_THIPARM%"=="" goto NO_MPOST
if exist piclist.bat del piclist.bat
if exist piclist.tex del piclist.tex
mpost %1.mp end
::
:: DeK, mf.web:
:: The global variable |history| records the worst level of error that
:: has been detected. It has four possible values: |spotless|,
:: |warning_issued|, |error_message_issued|, and |fatal_error_stop|.
::
:: djgpp mpost and P. van Oostrum's MP work differently, though...
::
::if errorlevel==1 goto NIC
::
:NO_MPOST
:: piclist.bat invokes epsincl machinery to include background EPSes
:: (``stencils'') into mpost-generated ones:
if exist piclist.bat call piclist.bat
:: A few silly copying due to the odd MFT custom of naming output files
if exist %_SECPARM% copy /b %_SECPARM% _t_m_p_.mp
if exist _t_m_p_.mp mft _t_m_p_.mp -style=%METATYPE1%/mt1form.mft 
if exist _t_m_p_.mp del _t_m_p_.mp
if exist _t_m_p_.tex ren _t_m_p_.tex %1.tmp
:: Assemble the resulting %1.tex file.
:: mt1form.sty must be input at the very beginning:
echo \input %METATYPE1%/mt1form.sty > %1.tex
:: piclist.tex defines \csname pict:name\endcsname as a numeric extension
if exist piclist.tex copy /b %1.tex + piclist.tex > nul
:: now the ``core'' of the formatted source follows:
copy /b %1.tex + %1.tmp > nul
:: ... and that's all:
echo \endproof >> %1.tex
::
if exist %1.log del %1.log
if exist %1.pfi del %1.pfi
if exist %1.kpx del %1.kpx
if exist %1.tmp del %1.tmp
if exist piclist.tex del piclist.tex
if exist piclist.bat del piclist.bat
:NIC

