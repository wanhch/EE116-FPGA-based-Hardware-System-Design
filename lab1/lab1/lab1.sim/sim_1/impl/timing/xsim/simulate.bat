@echo off
REM ****************************************************************************
REM Vivado (TM) v2020.1 (64-bit)
REM
REM Filename    : simulate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for simulating the design by launching the simulator
REM
REM Generated by Vivado on Mon Oct 19 23:11:20 +0800 2020
REM SW Build 2902540 on Wed May 27 19:54:49 MDT 2020
REM
REM Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
REM
REM usage: simulate.bat
REM
REM ****************************************************************************
echo "xsim teshbench_time_impl -key {Post-Implementation:sim_1:Timing:teshbench} -tclbatch teshbench.tcl -view D:/Courses/FPGA/lab1/lab1/teshbench_behav.wcfg -log simulate.log"
call xsim  teshbench_time_impl -key {Post-Implementation:sim_1:Timing:teshbench} -tclbatch teshbench.tcl -view D:/Courses/FPGA/lab1/lab1/teshbench_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
