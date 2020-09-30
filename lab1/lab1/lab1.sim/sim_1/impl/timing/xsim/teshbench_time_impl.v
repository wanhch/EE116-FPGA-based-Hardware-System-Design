// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Wed Sep 30 15:29:23 2020
// Host        : DESKTOP-SJTAGQE running 64-bit major release  (build 9200)
// Command     : write_verilog -mode timesim -nolib -sdf_anno true -force -file
//               D:/Courses/FPGA/lab1/lab1/lab1.sim/sim_1/impl/timing/xsim/teshbench_time_impl.v
// Design      : LED_DRIVER
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

module ADDR_CNTR
   (LED_OBUF,
    UPDN_IBUF,
    CLK,
    RST,
    LOAD_IBUF,
    CE_IBUF,
    DATA_in_IBUF);
  output [7:0]LED_OBUF;
  input UPDN_IBUF;
  input CLK;
  input RST;
  input LOAD_IBUF;
  input CE_IBUF;
  input [3:0]DATA_in_IBUF;

  wire CE_IBUF;
  wire CLK;
  wire [3:0]DATA_in_IBUF;
  wire [7:0]LED_OBUF;
  wire LOAD_IBUF;
  wire RST;
  wire UPDN_IBUF;
  wire \count[3]_i_1_n_0 ;
  wire \count[3]_i_3_n_0 ;
  wire [3:0]count_reg;
  wire [3:0]p_0_in;

  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h01FE)) 
    \LED_OBUF[0]_inst_i_1 
       (.I0(count_reg[3]),
        .I1(count_reg[2]),
        .I2(count_reg[1]),
        .I3(count_reg[0]),
        .O(LED_OBUF[0]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h0EF0)) 
    \LED_OBUF[1]_inst_i_1 
       (.I0(count_reg[3]),
        .I1(count_reg[2]),
        .I2(count_reg[1]),
        .I3(count_reg[0]),
        .O(LED_OBUF[1]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \LED_OBUF[2]_inst_i_1 
       (.I0(count_reg[2]),
        .I1(count_reg[0]),
        .I2(count_reg[1]),
        .O(LED_OBUF[2]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \LED_OBUF[3]_inst_i_1 
       (.I0(count_reg[3]),
        .I1(count_reg[2]),
        .I2(count_reg[0]),
        .I3(count_reg[1]),
        .O(LED_OBUF[3]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'h8000)) 
    \LED_OBUF[4]_inst_i_1 
       (.I0(count_reg[3]),
        .I1(count_reg[1]),
        .I2(count_reg[0]),
        .I3(count_reg[2]),
        .O(LED_OBUF[4]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h0800)) 
    \LED_OBUF[5]_inst_i_1 
       (.I0(count_reg[3]),
        .I1(count_reg[1]),
        .I2(count_reg[0]),
        .I3(count_reg[2]),
        .O(LED_OBUF[5]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h0800)) 
    \LED_OBUF[6]_inst_i_1 
       (.I0(count_reg[3]),
        .I1(count_reg[0]),
        .I2(count_reg[1]),
        .I3(count_reg[2]),
        .O(LED_OBUF[6]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h0200)) 
    \LED_OBUF[7]_inst_i_1 
       (.I0(count_reg[3]),
        .I1(count_reg[1]),
        .I2(count_reg[0]),
        .I3(count_reg[2]),
        .O(LED_OBUF[7]));
  LUT3 #(
    .INIT(8'h8B)) 
    \count[0]_i_1 
       (.I0(DATA_in_IBUF[0]),
        .I1(LOAD_IBUF),
        .I2(count_reg[0]),
        .O(p_0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h8BB8B88B)) 
    \count[1]_i_1 
       (.I0(DATA_in_IBUF[1]),
        .I1(LOAD_IBUF),
        .I2(count_reg[0]),
        .I3(UPDN_IBUF),
        .I4(count_reg[1]),
        .O(p_0_in[1]));
  LUT6 #(
    .INIT(64'h8BBBB888BBB8888B)) 
    \count[2]_i_1 
       (.I0(DATA_in_IBUF[2]),
        .I1(LOAD_IBUF),
        .I2(count_reg[0]),
        .I3(UPDN_IBUF),
        .I4(count_reg[2]),
        .I5(count_reg[1]),
        .O(p_0_in[2]));
  LUT2 #(
    .INIT(4'hE)) 
    \count[3]_i_1 
       (.I0(LOAD_IBUF),
        .I1(CE_IBUF),
        .O(\count[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h8BBBB888BBB8888B)) 
    \count[3]_i_2 
       (.I0(DATA_in_IBUF[3]),
        .I1(LOAD_IBUF),
        .I2(\count[3]_i_3_n_0 ),
        .I3(count_reg[1]),
        .I4(count_reg[3]),
        .I5(count_reg[2]),
        .O(p_0_in[3]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hD4)) 
    \count[3]_i_3 
       (.I0(count_reg[1]),
        .I1(UPDN_IBUF),
        .I2(count_reg[0]),
        .O(\count[3]_i_3_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \count_reg[0] 
       (.C(CLK),
        .CE(\count[3]_i_1_n_0 ),
        .CLR(RST),
        .D(p_0_in[0]),
        .Q(count_reg[0]));
  FDCE #(
    .INIT(1'b0)) 
    \count_reg[1] 
       (.C(CLK),
        .CE(\count[3]_i_1_n_0 ),
        .CLR(RST),
        .D(p_0_in[1]),
        .Q(count_reg[1]));
  FDCE #(
    .INIT(1'b0)) 
    \count_reg[2] 
       (.C(CLK),
        .CE(\count[3]_i_1_n_0 ),
        .CLR(RST),
        .D(p_0_in[2]),
        .Q(count_reg[2]));
  FDCE #(
    .INIT(1'b0)) 
    \count_reg[3] 
       (.C(CLK),
        .CE(\count[3]_i_1_n_0 ),
        .CLR(RST),
        .D(p_0_in[3]),
        .Q(count_reg[3]));
endmodule

module CLK_DIV
   (CLK,
    CLK_50_IBUF_BUFG);
  output CLK;
  input CLK_50_IBUF_BUFG;

  wire CLK;
  wire CLK_50_IBUF_BUFG;
  wire [31:0]count;
  wire \count[0]_i_2_n_0 ;
  wire \count[0]_i_3_n_0 ;
  wire \count[0]_i_4_n_0 ;
  wire \count[0]_i_5_n_0 ;
  wire \count[0]_i_6_n_0 ;
  wire \count[0]_i_7_n_0 ;
  wire \count[0]_i_8_n_0 ;
  wire \count[0]_i_9_n_0 ;
  wire [0:0]count_0;
  wire \count_reg[12]_i_1_n_0 ;
  wire \count_reg[16]_i_1_n_0 ;
  wire \count_reg[20]_i_1_n_0 ;
  wire \count_reg[24]_i_1_n_0 ;
  wire \count_reg[28]_i_1_n_0 ;
  wire \count_reg[4]_i_1_n_0 ;
  wire \count_reg[8]_i_1_n_0 ;
  wire [31:1]data0;
  wire flag;
  wire flag_i_1_n_0;
  wire [2:0]\NLW_count_reg[12]_i_1_CO_UNCONNECTED ;
  wire [2:0]\NLW_count_reg[16]_i_1_CO_UNCONNECTED ;
  wire [2:0]\NLW_count_reg[20]_i_1_CO_UNCONNECTED ;
  wire [2:0]\NLW_count_reg[24]_i_1_CO_UNCONNECTED ;
  wire [2:0]\NLW_count_reg[28]_i_1_CO_UNCONNECTED ;
  wire [3:0]\NLW_count_reg[31]_i_2_CO_UNCONNECTED ;
  wire [3:3]\NLW_count_reg[31]_i_2_O_UNCONNECTED ;
  wire [2:0]\NLW_count_reg[4]_i_1_CO_UNCONNECTED ;
  wire [2:0]\NLW_count_reg[8]_i_1_CO_UNCONNECTED ;

  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h01FF)) 
    \count[0]_i_1__0 
       (.I0(\count[0]_i_2_n_0 ),
        .I1(\count[0]_i_3_n_0 ),
        .I2(\count[0]_i_4_n_0 ),
        .I3(count[0]),
        .O(count_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \count[0]_i_2 
       (.I0(\count[0]_i_5_n_0 ),
        .I1(\count[0]_i_6_n_0 ),
        .I2(count[31]),
        .I3(count[30]),
        .I4(count[1]),
        .I5(\count[0]_i_7_n_0 ),
        .O(\count[0]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFBFF)) 
    \count[0]_i_3 
       (.I0(count[5]),
        .I1(count[4]),
        .I2(count[2]),
        .I3(count[3]),
        .I4(\count[0]_i_8_n_0 ),
        .O(\count[0]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \count[0]_i_4 
       (.I0(count[12]),
        .I1(count[13]),
        .I2(count[10]),
        .I3(count[11]),
        .I4(\count[0]_i_9_n_0 ),
        .O(\count[0]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \count[0]_i_5 
       (.I0(count[23]),
        .I1(count[22]),
        .I2(count[25]),
        .I3(count[24]),
        .O(\count[0]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \count[0]_i_6 
       (.I0(count[19]),
        .I1(count[18]),
        .I2(count[21]),
        .I3(count[20]),
        .O(\count[0]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \count[0]_i_7 
       (.I0(count[27]),
        .I1(count[26]),
        .I2(count[29]),
        .I3(count[28]),
        .O(\count[0]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \count[0]_i_8 
       (.I0(count[7]),
        .I1(count[6]),
        .I2(count[9]),
        .I3(count[8]),
        .O(\count[0]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \count[0]_i_9 
       (.I0(count[15]),
        .I1(count[14]),
        .I2(count[17]),
        .I3(count[16]),
        .O(\count[0]_i_9_n_0 ));
  LUT4 #(
    .INIT(16'h0002)) 
    \count[31]_i_1 
       (.I0(count[0]),
        .I1(\count[0]_i_4_n_0 ),
        .I2(\count[0]_i_3_n_0 ),
        .I3(\count[0]_i_2_n_0 ),
        .O(flag));
  FDRE #(
    .INIT(1'b1)) 
    \count_reg[0] 
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(count_0),
        .Q(count[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[10] 
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(data0[10]),
        .Q(count[10]),
        .R(flag));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[11] 
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(data0[11]),
        .Q(count[11]),
        .R(flag));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[12] 
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(data0[12]),
        .Q(count[12]),
        .R(flag));
  (* ADDER_THRESHOLD = "35" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \count_reg[12]_i_1 
       (.CI(\count_reg[8]_i_1_n_0 ),
        .CO({\count_reg[12]_i_1_n_0 ,\NLW_count_reg[12]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[12:9]),
        .S(count[12:9]));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[13] 
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(data0[13]),
        .Q(count[13]),
        .R(flag));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[14] 
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(data0[14]),
        .Q(count[14]),
        .R(flag));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[15] 
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(data0[15]),
        .Q(count[15]),
        .R(flag));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[16] 
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(data0[16]),
        .Q(count[16]),
        .R(flag));
  (* ADDER_THRESHOLD = "35" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \count_reg[16]_i_1 
       (.CI(\count_reg[12]_i_1_n_0 ),
        .CO({\count_reg[16]_i_1_n_0 ,\NLW_count_reg[16]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[16:13]),
        .S(count[16:13]));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[17] 
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(data0[17]),
        .Q(count[17]),
        .R(flag));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[18] 
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(data0[18]),
        .Q(count[18]),
        .R(flag));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[19] 
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(data0[19]),
        .Q(count[19]),
        .R(flag));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[1] 
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(data0[1]),
        .Q(count[1]),
        .R(flag));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[20] 
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(data0[20]),
        .Q(count[20]),
        .R(flag));
  (* ADDER_THRESHOLD = "35" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \count_reg[20]_i_1 
       (.CI(\count_reg[16]_i_1_n_0 ),
        .CO({\count_reg[20]_i_1_n_0 ,\NLW_count_reg[20]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[20:17]),
        .S(count[20:17]));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[21] 
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(data0[21]),
        .Q(count[21]),
        .R(flag));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[22] 
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(data0[22]),
        .Q(count[22]),
        .R(flag));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[23] 
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(data0[23]),
        .Q(count[23]),
        .R(flag));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[24] 
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(data0[24]),
        .Q(count[24]),
        .R(flag));
  (* ADDER_THRESHOLD = "35" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \count_reg[24]_i_1 
       (.CI(\count_reg[20]_i_1_n_0 ),
        .CO({\count_reg[24]_i_1_n_0 ,\NLW_count_reg[24]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[24:21]),
        .S(count[24:21]));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[25] 
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(data0[25]),
        .Q(count[25]),
        .R(flag));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[26] 
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(data0[26]),
        .Q(count[26]),
        .R(flag));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[27] 
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(data0[27]),
        .Q(count[27]),
        .R(flag));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[28] 
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(data0[28]),
        .Q(count[28]),
        .R(flag));
  (* ADDER_THRESHOLD = "35" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \count_reg[28]_i_1 
       (.CI(\count_reg[24]_i_1_n_0 ),
        .CO({\count_reg[28]_i_1_n_0 ,\NLW_count_reg[28]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[28:25]),
        .S(count[28:25]));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[29] 
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(data0[29]),
        .Q(count[29]),
        .R(flag));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[2] 
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(data0[2]),
        .Q(count[2]),
        .R(flag));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[30] 
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(data0[30]),
        .Q(count[30]),
        .R(flag));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[31] 
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(data0[31]),
        .Q(count[31]),
        .R(flag));
  (* ADDER_THRESHOLD = "35" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \count_reg[31]_i_2 
       (.CI(\count_reg[28]_i_1_n_0 ),
        .CO(\NLW_count_reg[31]_i_2_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_count_reg[31]_i_2_O_UNCONNECTED [3],data0[31:29]}),
        .S({1'b0,count[31:29]}));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[3] 
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(data0[3]),
        .Q(count[3]),
        .R(flag));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[4] 
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(data0[4]),
        .Q(count[4]),
        .R(flag));
  (* ADDER_THRESHOLD = "35" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \count_reg[4]_i_1 
       (.CI(1'b0),
        .CO({\count_reg[4]_i_1_n_0 ,\NLW_count_reg[4]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(count[0]),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[4:1]),
        .S(count[4:1]));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[5] 
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(data0[5]),
        .Q(count[5]),
        .R(flag));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[6] 
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(data0[6]),
        .Q(count[6]),
        .R(flag));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[7] 
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(data0[7]),
        .Q(count[7]),
        .R(flag));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[8] 
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(data0[8]),
        .Q(count[8]),
        .R(flag));
  (* ADDER_THRESHOLD = "35" *) 
  (* OPT_MODIFIED = "SWEEP" *) 
  CARRY4 \count_reg[8]_i_1 
       (.CI(\count_reg[4]_i_1_n_0 ),
        .CO({\count_reg[8]_i_1_n_0 ,\NLW_count_reg[8]_i_1_CO_UNCONNECTED [2:0]}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[8:5]),
        .S(count[8:5]));
  FDRE #(
    .INIT(1'b0)) 
    \count_reg[9] 
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(data0[9]),
        .Q(count[9]),
        .R(flag));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'hFFFD0002)) 
    flag_i_1
       (.I0(count[0]),
        .I1(\count[0]_i_4_n_0 ),
        .I2(\count[0]_i_3_n_0 ),
        .I3(\count[0]_i_2_n_0 ),
        .I4(CLK),
        .O(flag_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    flag_reg
       (.C(CLK_50_IBUF_BUFG),
        .CE(1'b1),
        .D(flag_i_1_n_0),
        .Q(CLK),
        .R(1'b0));
endmodule

(* ECO_CHECKSUM = "41877c7" *) (* addrwidth = "4" *) 
(* NotValidForBitStream *)
module LED_DRIVER
   (CLK_50,
    DATA_in,
    CE,
    LOAD,
    UPDN,
    RST,
    LED);
  input CLK_50;
  input [3:0]DATA_in;
  input CE;
  input LOAD;
  input UPDN;
  input RST;
  output [7:0]LED;

  wire CE;
  wire CE_IBUF;
  wire CLK_50;
  wire CLK_50_IBUF;
  wire CLK_50_IBUF_BUFG;
  wire [3:0]DATA_in;
  wire [3:0]DATA_in_IBUF;
  wire [7:0]LED;
  wire [7:0]LED_OBUF;
  wire LOAD;
  wire LOAD_IBUF;
  wire RST;
  wire RST_IBUF;
  wire UPDN;
  wire UPDN_IBUF;
  wire flag;

initial begin
 $sdf_annotate("teshbench_time_impl.sdf",,,,"tool_control");
end
  IBUF CE_IBUF_inst
       (.I(CE),
        .O(CE_IBUF));
  BUFG CLK_50_IBUF_BUFG_inst
       (.I(CLK_50_IBUF),
        .O(CLK_50_IBUF_BUFG));
  IBUF CLK_50_IBUF_inst
       (.I(CLK_50),
        .O(CLK_50_IBUF));
  IBUF \DATA_in_IBUF[0]_inst 
       (.I(DATA_in[0]),
        .O(DATA_in_IBUF[0]));
  IBUF \DATA_in_IBUF[1]_inst 
       (.I(DATA_in[1]),
        .O(DATA_in_IBUF[1]));
  IBUF \DATA_in_IBUF[2]_inst 
       (.I(DATA_in[2]),
        .O(DATA_in_IBUF[2]));
  IBUF \DATA_in_IBUF[3]_inst 
       (.I(DATA_in[3]),
        .O(DATA_in_IBUF[3]));
  CLK_DIV G1
       (.CLK(flag),
        .CLK_50_IBUF_BUFG(CLK_50_IBUF_BUFG));
  ADDR_CNTR G2
       (.CE_IBUF(CE_IBUF),
        .CLK(flag),
        .DATA_in_IBUF(DATA_in_IBUF),
        .LED_OBUF(LED_OBUF),
        .LOAD_IBUF(LOAD_IBUF),
        .RST(RST_IBUF),
        .UPDN_IBUF(UPDN_IBUF));
  OBUF \LED_OBUF[0]_inst 
       (.I(LED_OBUF[0]),
        .O(LED[0]));
  OBUF \LED_OBUF[1]_inst 
       (.I(LED_OBUF[1]),
        .O(LED[1]));
  OBUF \LED_OBUF[2]_inst 
       (.I(LED_OBUF[2]),
        .O(LED[2]));
  OBUF \LED_OBUF[3]_inst 
       (.I(LED_OBUF[3]),
        .O(LED[3]));
  OBUF \LED_OBUF[4]_inst 
       (.I(LED_OBUF[4]),
        .O(LED[4]));
  OBUF \LED_OBUF[5]_inst 
       (.I(LED_OBUF[5]),
        .O(LED[5]));
  OBUF \LED_OBUF[6]_inst 
       (.I(LED_OBUF[6]),
        .O(LED[6]));
  OBUF \LED_OBUF[7]_inst 
       (.I(LED_OBUF[7]),
        .O(LED[7]));
  IBUF LOAD_IBUF_inst
       (.I(LOAD),
        .O(LOAD_IBUF));
  IBUF RST_IBUF_inst
       (.I(RST),
        .O(RST_IBUF));
  IBUF UPDN_IBUF_inst
       (.I(UPDN),
        .O(UPDN_IBUF));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
