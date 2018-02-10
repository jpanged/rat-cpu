@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto 21e77b89a7914085b5bf01a44bb127fc -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot rat_mcu_behav xil_defaultlib.rat_mcu -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
