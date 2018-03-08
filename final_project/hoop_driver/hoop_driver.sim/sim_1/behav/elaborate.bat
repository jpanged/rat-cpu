@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto 56e9ccc7dc2b4f82a344b5378efd66e5 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot RAT_wrapper_behav xil_defaultlib.RAT_wrapper -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
