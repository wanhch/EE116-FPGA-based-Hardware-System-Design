@echo off
REM ****************************************************************************
REM Vivado (TM) v2020.1 (64-bit)
REM
REM Filename    : elaborate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for elaborating the compiled design
REM
REM Generated by Vivado on Sat Oct 10 13:47:43 +0800 2020
REM SW Build 2902540 on Wed May 27 19:54:49 MDT 2020
REM
REM Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
REM
REM usage: elaborate.bat
REM
REM ****************************************************************************
echo "xelab -wto 5d5952a2d4454062a84db46fa4a8a31d --incr --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot teshbench_behav xil_defaultlib.teshbench -log elaborate.log"
call xelab  -wto 5d5952a2d4454062a84db46fa4a8a31d --incr --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot teshbench_behav xil_defaultlib.teshbench -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
