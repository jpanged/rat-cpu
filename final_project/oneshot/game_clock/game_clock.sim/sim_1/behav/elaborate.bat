@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto 85776238b6a7466c9c6b855885c1313a -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot game_clock_behav xil_defaultlib.game_clock -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
