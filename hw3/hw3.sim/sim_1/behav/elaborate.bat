@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto e73347d1f688471e9dddc8d9c94db55e -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot testing_keypad_drvr_behav xil_defaultlib.testing_keypad_drvr -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
