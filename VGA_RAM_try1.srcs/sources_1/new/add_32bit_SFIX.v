`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/18 00:10:36
// Design Name: 
// Module Name: add_32bit_SFIX
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

//V 20190418 ²âÊÔÍ¨¹ý
//sum=a+b
module add_32bit_SFIX(
    input [31:0]a,b,
    output [31:0]sum
    );
    
    assign sum=(a[31]^b[31])?
            ((a[30:0]>b[30:0])?{a[31],a[30:0]-b[30:0]}:{b[31],b[30:0]-a[30:0]}):
            {a[31],a[30:0]+b[30:0]};
endmodule
