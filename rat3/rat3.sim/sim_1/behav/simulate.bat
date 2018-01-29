@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xsim REG_FILE_TB_behav -key {Behavioral:sim_1:Functional:REG_FILE_TB} -tclbatch REG_FILE_TB.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
