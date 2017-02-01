@echo off
echo.
echo ###############################################################################
echo #                                   FUNCORP                                   #
echo # 'Beyond the Titanic' Win32 i386 (32-bit) build script                       #
echo # Requires the Free Pascal Win32 compiler (v3.0.0 from freepascal.org)        #
echo ###############################################################################

rm -f BEYOND.EXE BEYOND.o BeyondTheTitanic-Win32.zip

echo.
echo -------------------------------------------------------------------------------
echo Compiling BEYOND.EXE ...
echo.
ppc386 -Mtp -O3 -Xt BEYOND.PAS -oBEYOND.EXE

echo.
echo -------------------------------------------------------------------------------
echo Creating distribution archive BeyondTheTitanic-Win32.zip ...
echo.
zip BeyondTheTitanic-Win32.zip BEYOND.EXE HELP.TXT HELP.BAT INSTRUCT.TXT INSTRUCT.BAT LINE ROOMS1 ROOMS2 SPECIAL1 SPECIAL2 LICENSE FILE_ID.DIZ

echo.
echo -------------------------------------------------------------------------------
echo.
echo Build complete.
