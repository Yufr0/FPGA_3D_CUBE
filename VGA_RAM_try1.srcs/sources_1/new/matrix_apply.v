`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/18 01:59:08
// Design Name: 
// Module Name: matrix_apply
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
/*
             |m1( , , , )|
a( , , , ) * |m2( , , , )| = b( , , , )
             |m3( , , , )|
             |m4( , , , )|
*/
module matrix_apply(
    input [127:0] a,
    input [127:0] m1,
    input [127:0] m2,
    input [127:0] m3,
    input [127:0] m4,
    output [127:0] b
    );
    vector_dotproduct muler_v1 (a,{m1[127:96],m2[127:96],m3[127:96],m4[127:96]},b[127:96]);
    vector_dotproduct muler_v2 (a,{m1[95:64],m2[95:64],m3[95:64],m4[95:64]},b[95:64]);
    vector_dotproduct muler_v3 (a,{m1[63:32],m2[63:32],m3[63:32],m4[63:32]},b[63:32]);
    vector_dotproduct muler_v4 (a,{m1[31:0],m2[31:0],m3[31:0],m4[31:0]},b[31:0]);
endmodule
