@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xsim Scratch_RAM_TB_behav -key {Behavioral:sim_2:Functional:Scratch_RAM_TB} -tclbatch Scratch_RAM_TB.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
