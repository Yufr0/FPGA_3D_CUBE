`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/23 15:46:58
// Design Name: 
// Module Name: Total_tb
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


module Total_tb(

    );
    reg clk=1'b1;
    wire VGA_HS_O,VGA_VS_O;
    wire [3:0] VGA_R;
    wire [3:0] VGA_G;
    wire [3:0] VGA_B;
    
    VGA_RAM vga_ram(0,0,0,0,clk,0,VGA_HS_O,VGA_VS_O,VGA_R,VGA_G,VGA_B);


    always #5 clk=~clk;
endmodule
