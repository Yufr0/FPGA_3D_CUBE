`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/18 01:13:03
// Design Name: 
// Module Name: div_32bit_SFIX
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

//
/* testbecah
module Math_tb();
    localparam CASE_WIDTH=32;//测试用例的宽度
    localparam RESULT_WIDTH=32;
    localparam CASE_NUM=4;//测试用例的数量
    reg clk=1'b1;
    reg [CASE_WIDTH:1] array_a[CASE_NUM:1];
    reg [CASE_WIDTH:1] array_b[CASE_NUM:1];
    reg [CASE_WIDTH:1] case_a,case_b;
    wire s_axis_a_tvalid;
    integer i=0;
    wire m_axis_result_tvalid;
    wire [RESULT_WIDTH:1] result;
    
    PWM pwmer(clk,8'h29,8'h01,s_axis_a_tvalid);
    
    div mytest(
    .clk(clk),
    .s_axis_a_tvalid(s_axis_a_tvalid),
    .a(case_a),
    //s_axis_b_tvalid,
    .b(case_b),
    .m_axis_result_tvalid(m_axis_result_tvalid),
    .result(result));
    initial begin
        $readmemh("case_a.txt",array_a);
        $readmemh("case_b.txt",array_b);
        for(i=1;i<CASE_NUM;i=i+1)
        begin
            case_a=array_a[i];
            case_b=array_b[i];
            #420;
        end
        //case_a=32'hbf958000;
    end
    always #5 clk=~clk;
    //always #200 i=i+1;
endmodule
*/

//V 20190421
//result =a/b

/*
共计 41T  40T运算 1T输出 */
module div_32bit_SFIX(
    input clk,
    input s_axis_a_tvalid,
    input [31:0]a,
    //input s_axis_b_tvalid,
    input [31:0]b,
    output m_axis_result_tvalid,
    output [31:0]result);
    
    wire [31:0]a_float,b_float,result_float;
    wire valid_ff1a,valid_ff1b,valid_div,valid_ff3;
    reg s_axis_tvalid,temp;
    wire clk_sub;
    //PWM pwmer(.clk(clk),.T(8'd50),.rate(8'd2),.clk_sub(clk_sub));
    fix_to_float_32bit ffer1(
    .clk(clk),
    .fix(a),
    .s_axis_a_tvalid(s_axis_a_tvalid),
    .float(a_float),
    .m_axis_result_tvalid(valid_ff1a));
    
    fix_to_float_32bit ffer2(
    .clk(clk),
    .fix(b),
    .s_axis_a_tvalid(s_axis_a_tvalid),
    .float(b_float),
    .m_axis_result_tvalid(valid_ff1b));
    
    always @(posedge clk)
    begin
        if(valid_ff1a)
        begin
            s_axis_tvalid=1'b1;
        end
        else
        begin
            s_axis_tvalid=1'b0;
        end
    end
    floating_point_div diver(clk,
    s_axis_tvalid,a_float,
    s_axis_tvalid,b_float,
    valid_div,result_float);
    
    float_to_fix_32bit ff3(clk,
    result_float,
    valid_div,
    result,
    m_axis_result_tvalid);
endmodule