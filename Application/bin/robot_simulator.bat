REM 
REM   robot_simulator.bat     - Robot Simulator launch file for Windows
REM
REM     Luis Esteban    16 April 2015
REM       Created
REM
@ECHO OFF
IF NOT "%~f0" == "~f0" GOTO :WinNT
@"ruby.exe" "./robot_simulator" %1 %2 %3 %4 %5 %6 %7 %8 %9
GOTO :EOF
:WinNT
@"ruby.exe" "%~dpn0" %*
