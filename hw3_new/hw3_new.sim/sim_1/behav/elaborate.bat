@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto 0091659b798643e892da0b21cad8fb42 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot keypad_drvr_behav xil_defaultlib.keypad_drvr -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
