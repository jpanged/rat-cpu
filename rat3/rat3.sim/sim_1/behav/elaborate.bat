@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto df22c7b3be8e4af6b14035b1380e8435 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot REG_FILE_TB_behav xil_defaultlib.REG_FILE_TB -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
