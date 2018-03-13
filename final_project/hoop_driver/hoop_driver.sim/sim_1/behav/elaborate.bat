@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto daf24ea321954d338a98fb0e48c1ad3e -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot RAT_wrapper_behav xil_defaultlib.RAT_wrapper -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
