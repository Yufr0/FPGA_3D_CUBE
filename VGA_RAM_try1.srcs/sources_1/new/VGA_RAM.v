`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/15 09:31:31
// Design Name: 
// Module Name: VGA_RAM
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

module VGA_RAM(
    input wire BTNU,
    input wire BTNL,
    input wire BTNR,
    input wire BTND,
    input wire CLK,
    input wire RST_BTN,
    output wire VGA_HS_O,
    output wire VGA_VS_O,
    output wire [3:0] VGA_R,
    output wire [3:0] VGA_G,
    output wire [3:0] VGA_B
    );
    
    wire rst=~RST_BTN;  //复位信号处理
   
    reg [3:0] state=0;
        
    //=======================================================================================
    //VGA信号时钟生成器
    reg [15:0] cnt;
    reg pix_stb;
    //1024 x 768 @ 70 Hz
    // need generate a 75MHz pixel strobe
    always@(posedge CLK)
        {pix_stb,cnt} <= cnt+16'hC000;       //divide by 4/3: (2^16)/4*3 = 0xC000
    //=======================================================================================
    


    
    //=======================================================================================
    //实例化一个256x192的RAM
    reg ena=1;
    reg wea;
    reg [15:0] addra=0;
    reg dina;
    wire douta;
    blk_mem_gen_0 RAM(.clka(CLK),.ena(ena),.wea(wea),.addra(addra),.dina(dina),.douta(douta));
    //=======================================================================================
   
    //==========================================
    //绘制屏幕的时候用到的变量，也不可以更改
    localparam buffer_width=256;
    localparam buffer_height=192;
    reg [15:0] tempX=0;
    reg [15:0] tempY=0;
    wire [10:0] x;           // x坐标
    wire [9:0] y;            // y坐标
    reg RGBData=0;
    //=========================================
    
    
    //=========================================
    //二维化后的点数据以及顶点序列
    integer pointX[7:0];
    integer pointY[7:0];
    integer indexA[11:0];   
    integer indexB[11:0];
    //==========================================
    
    //=======================================================================================
    //3D 矩阵变换模块
    reg valid_in_angle=0;
    reg valid_in_pos_camera_dx=0;
    reg [31:0] angle;
    reg [31:0] pos_camera_dx=32'h00050000;
    wire valid_out;
    reg  valid_out_reg;
    wire [15:0] PointX[7:0];
    wire [15:0] PointY[7:0];
    
    reg [31:0] Angle=32'h0001921f;
    
    math_3D Math_3D(.clk(CLK),.valid_in_angle(valid_in_angle),.angle(Angle),.valid_in_pos_camera_dx(valid_in_pos_camera_dx),
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
    
    //=======================================================================================
    
    //======================================
    //画直线算法的内部变量，不可以更改
    localparam line_sum=12;
    integer lineX0;
    integer lineY0;
    integer lineX1;
    integer lineY1;
    integer dx,sx;
    integer dy,sy;
    integer err;
    integer e2;
    reg drawLineInitFlag=0;
    integer x0;
    integer y0;
    integer x1;
    integer y1;
    reg [3:0]lineCount=0; //画12条线的时候的计数器
    //=====================================

        
    task initPoint;
    begin
        indexA[0]=0;
        indexB[0]=1;
        indexA[1]=1;
        indexB[1]=2;
        indexA[2]=2;
        indexB[2]=3;
        indexA[3]=3;
        indexB[3]=0;
        indexA[4]=4;
        indexB[4]=5;
        indexA[5]=5;
        indexB[5]=6;
        indexA[6]=6;
        indexB[6]=7;
        indexA[7]=7;
        indexB[7]=4;
        indexA[8]=0;
        indexB[8]=4;
        indexA[9]=1;
        indexB[9]=5;
        indexA[10]=2;
        indexB[10]=6;
        indexA[11]=3;
        indexB[11]=7;
    end
    endtask
    
    task drawLine;
    begin
        // Bresenham 算法
        if(drawLineInitFlag==0)
        begin
            x0=lineX0;
            y0=lineY0;
            x1=lineX1;
            y1=lineY1;
            if(x1>x0) begin
                dx=x1-x0;
                sx=1;
            end
            else begin
                dx=x0-x1;
                sx=-1;
            end
            if(y1>y0) begin
                dy=y1-y0;
                sy=1;
            end
            else begin
                dy=y0-y1;
                sy=-1;
            end
            if(dx>dy) err=dx/2;
            else      err=-dy/2;
            drawLineInitFlag<=1;
        end
        else if(x0!=x1||y0!=y1)
        begin
            
            dina<=1;
            wea<=1;
            addra<=y0*buffer_width+x0;
            
            e2=err;
            if(e2>-dx) begin
                err=err-dy;
                x0=x0+sx;
            end
            if(e2<dy) begin
                err=err+dx;
                y0=y0+sy;
            end
        end
        else 
        begin
            drawLineInitFlag<=0;
            state<=state+1;
        end
    end
    endtask
    
    
    //========================================================================================
  
    always@(posedge CLK)
    begin
    case(state)
    0: begin
            initPoint();
            state<=state+1;
            valid_in_angle<=0;
            valid_in_pos_camera_dx<=0;
       end
       //键控模块
    1: begin
        if(BTNR==1)
            if(Angle<32'h003283f)
                Angle<=Angle+32'h2EC;
        if(BTNL==1)
            if(Angle>32'h0)
                Angle<=Angle-32'h2EC;
        if(BTND==1)
            if(pos_camera_dx<32'h00640000)
                pos_camera_dx<=pos_camera_dx+32'h00001000;
        if(BTNU==1)
            if(pos_camera_dx>32'h0)
                pos_camera_dx<=pos_camera_dx-32'h00001000;
        state<=state+1;
        valid_in_angle<=1;
        valid_in_pos_camera_dx<=1;
      end
      
    2: begin
        valid_in_angle<=0;
        valid_in_pos_camera_dx<=0;
        valid_out_reg<=valid_out;
        if(valid_out_reg==1)
            begin
                state<=state+1;
            end
        end
    3: begin
            pointX[0]=PointX[0];
            pointX[1]=PointX[1];
            pointX[2]=PointX[2];
            pointX[3]=PointX[3];
            pointX[4]=PointX[4];
            pointX[5]=PointX[5];
            pointX[6]=PointX[6];
            pointX[7]=PointX[7];
            pointY[0]=PointY[0];
            pointY[1]=PointY[1];
            pointY[2]=PointY[2];
            pointY[3]=PointY[3];
            pointY[4]=PointY[4];
            pointY[5]=PointY[5];
            pointY[6]=PointY[6];
            pointY[7]=PointY[7];
            state<=state+1;
        end
         //把整个buffer置0
    4:  begin
            if(tempX<buffer_width-1)
                tempX<=tempX+1;
            else if(tempY<buffer_height)
            begin
                tempY<=tempY+1;
                tempX<=0;
            end
            else 
            begin
                state<=state+1;
                tempX<=0;
                tempY<=0;
            end
            wea<=1;
            addra<=tempY*buffer_width+tempX;
            dina<=0;
       end
       // 在buffer上画线
    5: begin
            if(lineCount<line_sum)
            begin
                lineX0=pointX[indexA[lineCount]];
                lineY0=pointY[indexA[lineCount]];
                lineX1=pointX[indexB[lineCount]];
                lineY1=pointY[indexB[lineCount]];
                drawLine();
            end
            else
            begin
                state<=state+2;
                lineCount<=0;
            end
      end
      //画线的计数
    6: begin
        state<=state-1;
        lineCount<=lineCount+1;
      end
        // 在屏幕上显示buffer
    7: begin
            wea<=0;
            addra<=(y/4)*buffer_width+x/4;
            RGBData<=douta;
            if(x==1024-1&&y==768-1)
                state<=1;
      end
    endcase
    end
    
    assign VGA_R[0]=RGBData;
    assign VGA_R[1]=RGBData;
    assign VGA_R[2]=RGBData;
    assign VGA_R[3]=RGBData;

    assign VGA_G[0]=RGBData;
    assign VGA_G[1]=RGBData;
    assign VGA_G[2]=RGBData;
    assign VGA_G[3]=RGBData;

    assign VGA_B[0]=RGBData;
    assign VGA_B[1]=RGBData;
    assign VGA_B[2]=RGBData;
    assign VGA_B[3]=RGBData;
    
    //========================================================================================
    
    //=======================================================================================
    //实例化vga显示
    vga1024x768 display(.i_clk(CLK),.i_pix_stb(pix_stb),.i_rst(rst),.o_hs(VGA_HS_O),.o_vs(VGA_VS_O),.o_x(x),.o_y(y));
    //=======================================================================================

endmodule