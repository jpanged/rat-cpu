@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto 0c1235377e3842e78055c06b679e867a -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot alu_sim_behav xil_defaultlib.alu_sim -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
