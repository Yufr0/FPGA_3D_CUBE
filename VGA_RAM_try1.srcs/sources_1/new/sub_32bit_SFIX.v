`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/18 00:10:05
// Design Name: 
// Module Name: sub_32bit_SFIX
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

//V 2019418 ≤‚ ‘Õ®π˝
//sub=a-b
module sub_32bit_SFIX(
    input [31:0]a,b,
    output [31:0]sub
    );
    
    add_32bit_SFIX adder(a,{~b[31],b[30:0]},sub);
    
endmodule
