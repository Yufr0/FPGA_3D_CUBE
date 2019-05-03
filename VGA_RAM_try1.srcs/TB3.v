`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/19 01:53:19
// Design Name: 
// Module Name: TB3
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


//module TB3();
//    reg clk=1'b1;
//    //reg [128:1]x=128'h80011234800112348001123480011234;
//    //reg [128:1]y=128'h000f1234000f1234000f1234000f1234;
//    reg [32:1]x=32'h80011234;
//    reg [32:1]y=32'h00000000;
//    wire [32:1]result;
//    wire root_valid_H;
//    wire clk_sub;
//    wire [6:0]count;
//    vector_normalize mytest (x,y,result);
//    //always #5 clk=~clk;
//    always #200x=x+128'h00010000000100000001000000010000;
//    always #200y=y+128'h0000f0000000f0000000f0000000f000;
//endmodule


module TB3();
    reg clk=1'b1;
    reg valid_in_angle=0;
    reg valid_in_pos_camera_dx=0;
    reg [31:0] angle=32'h0000c9ab;
    reg [31:0] pos_camera_dx=32'h00050000;
    wire valid_out;
    wire [15:0] PointX[7:0];
    wire [15:0] PointY[7:0];
    
    initial begin
        #500 angle=32'h0003BEBC;
        valid_in_angle<=1;
        valid_in_pos_camera_dx<=1;
        #10 valid_in_angle<=0;
            valid_in_pos_camera_dx<=0;
            
    end
    initial begin
        valid_in_angle<=1;
        valid_in_pos_camera_dx<=1;
        #10 valid_in_angle<=0;
            valid_in_pos_camera_dx<=0;
    end
    
    
    math_3D Math_3D(.clk(clk),.valid_in_angle(valid_in_angle),.angle(angle),.valid_in_pos_camera_dx(valid_in_pos_camera_dx),
        .pos_camera_dx(pos_camera_dx),.valid_out(valid_out),
        .point0x(PointX[0]),
        .point1x(PointX[1]),
        .point2x(PointX[2]),
        .point3x(PointX[3]),
        .point4x(PointX[4]),
        .point5x(PointX[5]),
        .point6x(PointX[6]),
        .point7x(PointX[7]),
        .point0y(PointY[0]),
        .point1y(PointY[1]),
        .point2y(PointY[2]),
        .point3y(PointY[3]),
        .point4y(PointY[4]),
        .point5y(PointY[5]),
        .point6y(PointY[6]),
        .point7y(PointY[7]));
    always #5 clk=~clk;
    //always #100 s_axis_divisor_tdata=s_axis_divisor_tdata+32'h00010000;
    //always #200 s_axis_divisor_tdata=s_axis_divisor_tdata+32'h00010000;
    //always #200 s_axis_dividend_tdata=s_axis_dividend_tdata+32'h00010000;
endmodule