@echo off
:: This batch belongs to the METATYPE1 package
:: This batch sets the only environment variable needed by METATYPE1 package;
:: It is invoked in batches: afm2pfm.bat, mkfont1.bat, mkproof1.bat
:: mkt1.bat, pf2mt1.bat. Much better would be employing kpathsea.
:: A good task for future...

:: ADJUST THE FOLLOWING LINE TO YOUR INSTALLATION (both slashes and
:: backslashes can be used): the variable METATYPE1 should contain
:: the name of the directory where the working files of METATYPE1 reside
set METATYPE1=%BOP_UTI%/mt1

:: WARNING: eventually, always SLASH notation is required
:: (even under Win/DOS), hence the following trickery:
gawk "BEGIN {s=ENVIRON[\"METATYPE1\"]; gsub(/\\/,\"/\",s); print \"set METATYPE1=\" s}" > mt1set_.bat
call mt1set_.bat
del mt1set_.bat
