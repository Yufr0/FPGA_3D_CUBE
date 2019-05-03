`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/21 14:59:21
// Design Name: 
// Module Name: fix_to_float_32bit
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

/*Testbecah*/
//    reg clk=1'b1;
//    reg s_axis_divisor_tvalid=1'b1;
//    reg [32:1]s_axis_divisor_tdata=32'h80031234;
//    wire m_axis_dout_tvalid;
//    wire [32:1]result;
//    fix_to_float_32bit mytest(
//    clk,
//    s_axis_divisor_tdata,
//    s_axis_divisor_tvalid,
//    result,
//    m_axis_dout_tvalid
//    );
//    always #5 clk=~clk;
//    always #200 s_axis_divisor_tdata=s_axis_divisor_tdata+32'h00010000;


/*对传入的系统时钟周期进行调整 输出PWM波形 
input   clk   //
        T     //周期
        rate  //占空比
ouput   clk_sub
*/
module PWM(
    input clk,
    input [7:0]T,
    input [7:0]rate,
    output reg clk_sub);
    
    reg [7:0]count;
    always @(posedge clk)
    begin
        if(count<rate)//占空比
        begin
            clk_sub<=1'b1;
        end
        else
        begin
            if(count<T)//Ts
            begin
                clk_sub<=1'b0;
            end
            else
            begin
                count=6'h0;
                clk_sub<=1'b1;
            end
        end
        //count_s=count;
        count=count+1;
    end
endmodule

//fixed point number to float  需要7个时钟周期 前6T等待输入 1T 输出结果
module fix_to_float_32bit(
    input clk,
    input s_axis_a_tvalid,
    input [31:0] fix,
    output m_axis_result_tvalid,
    output [31:0] float
    );
    
    wire [31:0]processdata;
    wire [31:0]temp_result;
    wire clk_sub;
    //PWM pwmer(clk,8'h07,8'h01,clk_sub);
    
    floating_point_0 FixtoFloater (
    clk,
    s_axis_a_tvalid,
    processdata,
    m_axis_result_tvalid,
    temp_result
    );
    assign  processdata={1'b0,fix[30:0]};
    assign float={fix[31],temp_result[30:0]};
endmodule
//float to fixed point number  需要7个时钟周期 前6T等待输入 1T 输出结果
module float_to_fix_32bit(
    input clk,
    input [31:0] float,
    input s_axis_a_tvalid,
    output [31:0] fix,
    output m_axis_result_tvalid
    );
    
    wire [31:0]processdata;
    wire [31:0]temp_result;
    wire clk_sub;
    PWM pwmer(clk,8'h07,8'h01,clk_sub);
    
    floating_point_1 FloattoFixer (
    clk,
    s_axis_a_tvalid,
    processdata,
    m_axis_result_tvalid,
    temp_result
    );
    assign  processdata={1'b0,float[30:0]};
    assign fix={float[31],temp_result[30:0]};
endmodule