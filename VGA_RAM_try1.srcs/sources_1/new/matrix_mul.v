`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/18 01:59:08
// Design Name: 
// Module Name: matrix_mul
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

//V 20190419 ≤‚ ‘Õ®π˝
/*
|a1( , , , )|   |b1( , , , )|   |c1( , , , )|
|a2( , , , )| * |b2( , , , )| = |c2( , , , )|
|a3( , , , )|   |b3( , , , )|   |c3( , , , )|
|a4( , , , )|   |b4( , , , )|   |c4( , , , )|
*/
module matrix_mul(
    input [127:0] a1,
    input [127:0] a2,
    input [127:0] a3,
    input [127:0] a4,
    input [127:0] b1,
    input [127:0] b2,
    input [127:0] b3,
    input [127:0] b4,
    output [127:0] c1,
    output [127:0] c2,
    output [127:0] c3,
    output [127:0] c4
    );
    
    wire [31:0] out_mul1,out_mul2,out_mul3,out_mul4;
    
    vector_dotproduct dmuler_v1  (a1,{b1[127:96],b2[127:96],b3[127:96],b4[127:96]},c1[127:96]);
    vector_dotproduct dmuler_v2  (a1,{b1[95:64],b2[95:64],b3[95:64],b4[95:64]},c1[95:64]);
    vector_dotproduct dmuler_v3  (a1,{b1[63:32],b2[63:32],b3[63:32],b4[63:32]},c1[63:32]);
    vector_dotproduct dmuler_v4  (a1,{b1[31:0],b2[31:0],b3[31:0],b4[31:0]},c1[31:0]);
    
    vector_dotproduct dmuler_v5  (a2,{b1[127:96],b2[127:96],b3[127:96],b4[127:96]},c2[127:96]);
    vector_dotproduct dmuler_v6  (a2,{b1[95:64],b2[95:64],b3[95:64],b4[95:64]},c2[95:64]);
    vector_dotproduct dmuler_v7  (a2,{b1[63:32],b2[63:32],b3[63:32],b4[63:32]},c2[63:32]);
    vector_dotproduct dmuler_v8  (a2,{b1[31:0],b2[31:0],b3[31:0],b4[31:0]},c2[31:0]);
    
    vector_dotproduct dmuler_v9  (a3,{b1[127:96],b2[127:96],b3[127:96],b4[127:96]},c3[127:96]);
    vector_dotproduct dmuler_v10 (a3,{b1[95:64],b2[95:64],b3[95:64],b4[95:64]},c3[95:64]);
    vector_dotproduct dmuler_v11 (a3,{b1[63:32],b2[63:32],b3[63:32],b4[63:32]},c3[63:32]);
    vector_dotproduct dmuler_v12 (a3,{b1[31:0],b2[31:0],b3[31:0],b4[31:0]},c3[31:0]);
    
    vector_dotproduct dmuler_v13 (a4,{b1[127:96],b2[127:96],b3[127:96],b4[127:96]},c4[127:96]);
    vector_dotproduct dmuler_v14 (a4,{b1[95:64],b2[95:64],b3[95:64],b4[95:64]},c4[95:64]);
    vector_dotproduct dmuler_v15 (a4,{b1[63:32],b2[63:32],b3[63:32],b4[63:32]},c4[63:32]);
    vector_dotproduct dmuler_v16 (a4,{b1[31:0],b2[31:0],b3[31:0],b4[31:0]},c4[31:0]);
endmodule
