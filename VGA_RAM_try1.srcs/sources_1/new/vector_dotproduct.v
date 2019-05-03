`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/18 01:33:29
// Design Name: 
// Module Name: vector_dotproduct
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


//V 20190418 ≤‚ ‘Õ®π˝
//a( , , , )*b( , , , )=dp
module vector_dotproduct(
    input [127:0] a,
    input [127:0] b,
    output [31:0] dp
    );
    
    wire [31:0] out_mul1,out_mul2,out_mul3,out_mul4;
    wire [31:0] out_add1,out_add2;
    mul_32bit_SFIX muler1(a[127:96],b[127:96],out_mul1);
    mul_32bit_SFIX muler2(a[95:64],b[95:64],out_mul2);
    mul_32bit_SFIX muler3(a[63:32],b[63:32],out_mul3);
    mul_32bit_SFIX muler4(a[31:0],b[31:0],out_mul4);
    
    add_32bit_SFIX adder1(out_mul1,out_mul2,out_add1);
    add_32bit_SFIX adder2(out_mul3,out_mul4,out_add2);
    
    add_32bit_SFIX adder3(out_add1,out_add2,dp);
endmodule
