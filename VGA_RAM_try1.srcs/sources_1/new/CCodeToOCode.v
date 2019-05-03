`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/23 00:53:03
// Design Name: 
// Module Name: CCodeToOCode
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


module CCodeToOCode
    #(parameter DATA_WIDTH=8)
    (
    input [DATA_WIDTH:1]complement,
    output [DATA_WIDTH:1]original
    );
    localparam N=DATA_WIDTH-1;

    assign original={complement[DATA_WIDTH],complement[DATA_WIDTH]?((~complement[N:1])+1):complement[N:1]};
endmodule

module OCodeToCCode
    #(parameter DATA_WIDTH=8)
    (
    input [DATA_WIDTH:1]original,
    output [DATA_WIDTH:1]complement
    );
    localparam N=DATA_WIDTH-1;

    assign complement={original[DATA_WIDTH],original[DATA_WIDTH]?((~original[N:1])+1):original[N:1]};
endmodule
