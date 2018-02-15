@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto 309a1532361a4139a558e2cf2a996209 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot testBench_behav xil_defaultlib.testBench -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
