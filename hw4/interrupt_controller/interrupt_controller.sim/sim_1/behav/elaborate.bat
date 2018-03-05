@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto 9e225aacefe74803a8a341af4e976702 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot interrupt_controller_behav xil_defaultlib.interrupt_controller -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
