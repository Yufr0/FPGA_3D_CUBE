`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/18 00:55:20
// Design Name: 
// Module Name: mul_32bit_SFIX
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

//V 20190418  ≤‚ ‘Õ®π˝
//product= a*b
module mul_32bit_SFIX(
    input [32:1]a,b,
    output reg [32:1]product
    );
    reg [31:1] temp_a,temp_b;
    reg [64:1] temp_out;
    integer i;
    always @*
    begin
        temp_a=a[31:1];
        temp_b=b[31:1];
        for(i=1,temp_out=0;i<32;i=i+1)
        begin
            if(temp_b[i])
                temp_out=temp_out+(temp_a<<(i-1));
            else
                temp_out=temp_out+0;
        end
        product[32:1]={a[32]^b[32],temp_out[47:17]};
    end
endmodule
