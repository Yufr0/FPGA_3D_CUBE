`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/20 18:28:40
// Design Name: 
// Module Name: cos_32bit_SFIX
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


//V 20190420 测试通过
//Testbecah 通用测试文件 
/*
input x x∈(-pi,pi)
*/
module cos_32bit_SFIX(
    input [31:0] x,
    output [31:0] result,
    input s_axis_phase_tvalid,
    output m_axis_dout_tvalid
    );
    
    wire [31:0] temp_out;
    //16位
    cordic_sin siner(
    .s_axis_phase_tvalid(s_axis_phase_tvalid),
    .s_axis_phase_tdata({x[31],x[17:3]}),//因为我定义的32SFIX和cordic核的定义的相关输入不同需要调整
    .m_axis_dout_tvalid(m_axis_dout_tvalid),
    .m_axis_dout_tdata(temp_out)
    );
    /*
    temp_out[31]     sin符号位    1
    temp_out[30]     sin整数位    1
    temp_out[29:16]  sin小数部分  14
    temp_out[15]     cos符号位    1
    temp_out[14]     cos整数位    1
    temp_out[13:0]   cos小数部分  14
    temp_out 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0 
    result   15 [             这里有14个0               ] 14 13 12 11 10 09 08 07 06 05 04 03 02 01 00 [两个0] 
    */
    //assign result={temp_out[15],{14{1'b0}},temp_out[14:0],2'b00};
    wire [15:0]oc;
    CCodeToOCode #(.DATA_WIDTH(16))cctoocer(temp_out[15:0],oc);
    assign result={oc[15],{14{1'b0}},oc[14:0],2'b00};
endmodule
