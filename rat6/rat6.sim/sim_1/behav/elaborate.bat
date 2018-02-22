@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto dacbda8d39e44ed7980109be0785ecdf -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot RAT_wrapper_behav xil_defaultlib.RAT_wrapper -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
