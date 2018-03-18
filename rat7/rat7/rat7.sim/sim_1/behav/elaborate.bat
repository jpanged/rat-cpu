@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto cd6cf4d42c3f401eae2780558b04893c -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot stack_pointer_behav xil_defaultlib.stack_pointer -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
