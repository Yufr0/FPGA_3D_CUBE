`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/17 15:04:24
// Design Name: 
// Module Name: math_3D
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


module math_3D(
    input clk,
    input valid_in_angle,
    input [31:0] angle,
    input valid_in_pos_camera_dx,
    input [31:0] pos_camera_dx,
    output valid_out,
    output reg[15:0] point0x,
    output reg[15:0] point1x,
    output reg[15:0] point2x,
    output reg[15:0] point3x,
    output reg[15:0] point4x,
    output reg[15:0] point5x,
    output reg[15:0] point6x,
    output reg[15:0] point7x,
    output reg[15:0] point0y,
    output reg[15:0] point1y,
    output reg[15:0] point2y,
    output reg[15:0] point3y,
    output reg[15:0] point4y,
    output reg[15:0] point5y,
    output reg[15:0] point6y,
    output reg[15:0] point7y
    );
    
    //-------------------------------------世界矩阵的生成?
    reg [127:0]wm1=128'h0;
    reg [127:0]wm2=128'h0;
    reg [127:0]wm3=128'h0;
    reg [127:0]wm4=128'h0;

    //-----------黑魔法算法 -----------
    //a=45°
    reg [31:0]sin_a=32'h0000b505;
    reg [31:0]cos_a=32'h0000b505;
    //-----------黑魔法算法 -----------
    
    wire temp_valid_cos,temp_valid_sin;//sin 和cos 的运算结果有效性  1 有效
    wire [31:0]cos_angle,sin_angle;
    wire [31:0]mul_ss,//sin(a)*sin(angle)
                mul_sc,//sin(a)*cos(angle)
                mul_cs,//cos(a)*sin(angle)
                mul_cc;//cos(a)*cos(angle)
    cos_32bit_SFIX cos (.s_axis_phase_tvalid(valid_in_angle),.x(angle),.m_axis_dout_tvalid(temp_valid_cos),.result(cos_angle));
    sin_32bit_SFIX sin (.s_axis_phase_tvalid(valid_in_angle),.x(angle),.m_axis_dout_tvalid(temp_valid_sin),.result(sin_angle));
    
    mul_32bit_SFIX muler1(.a(sin_a),.b(sin_angle),.product(mul_ss));
    mul_32bit_SFIX muler2(.a(sin_a),.b(cos_angle),.product(mul_sc));
    mul_32bit_SFIX muler3(.a(cos_a),.b(sin_angle),.product(mul_cs));
    mul_32bit_SFIX muler4(.a(cos_a),.b(cos_angle),.product(mul_cc));
    
    //wm1 |    cos(angle)         sin(angle)       0     0|
    //wm2 |-cos(a)sin(angle)   cos(a)cos(angle)  sin(a)  0|
    //wm3 | sin(a)sin(angle)  -sin(a)cos(angle)  cos(a)  0|
    //wm3 |       0                   0            0     1|
    always @(posedge clk)
    begin
        if(temp_valid_sin&&temp_valid_cos)
        begin
            wm1={cos_angle,                 sin_angle,                 32'h0, 32'h0};
            wm2={{~mul_cs[31],mul_cs[30:0]},mul_cc,                    sin_a, 32'h0};
            wm3={mul_ss,                    {~mul_sc[31],mul_sc[30:0]},cos_a, 32'h0};
            wm4={32'h0,                     32'h0,                     32'h0, 32'h00010000};
        end
        //这里生成锁存器貌似也没有关系
    end
    //-------------------------------------世界矩阵的生成?
    
    //-------------------------------------camera 矩阵↓
    reg [127:0]cm1=128'h0;
    reg [127:0]cm2=128'h0;
    reg [127:0]cm3=128'h0;
    reg [127:0]cm4=128'h0;
    
    reg [127:0]eye=128'h0;
    reg [127:0]at =128'h0;
    reg [127:0]up =128'h0;
    reg [127:0]xaxis=128'h0;
    reg [127:0]yaxis=128'h0;
    reg [127:0]zaxis=128'h0;
    always @(posedge clk)
    begin
        if(valid_in_pos_camera_dx)
        begin
            eye={pos_camera_dx, 32'h0, 32'h0,       32'h00010000};
            at ={32'h0,         32'h0, 32'h0,       32'h00010000};
            up ={32'h0,         32'h0, 32'h00010000,32'h00010000};
            xaxis={32'h0,        32'h80010000, 32'h0,        32'h0};
            yaxis={32'h0,        32'h0,        32'h00010000, 32'h0};
            zaxis={32'h80010000, 32'h0,        32'h0,        32'h0};
            
            cm1={xaxis[127:96],yaxis[127:96],zaxis[127:96], 32'h0};
            cm2={xaxis[95:64], yaxis[95:64], zaxis[95:64],  32'h0};
            cm3={xaxis[63:32], yaxis[63:32], zaxis[63:32],  32'h0};
            cm4={32'h0,        32'h0,        pos_camera_dx, 32'h00010000};
        end
        //这里生成锁存器貌似也没有关系
    end  
    //-------------------------------------camera 矩阵↑
    
    
    
    //-------------------------------------project 矩阵↓
    //||
    //||
    //||
    //||
    //-----------黑魔法算法 -----------
    /*W=256 H=192 n=5 f=200 aspect=H/W
    cot(thta)/aspect=2nW/H^2=0.0694444 0x000011c7
    cot(thta)=2n/H=0.05208333          0x00000d55
    f/(f-n)=1.025641025                0x00010690
    fn/(n-f)=-5.12820512               0x800520d2
    */ 
    reg [127:0]pm1={32'h0000c000,32'h0,       32'h0,       32'h0       };
    reg [127:0]pm2={32'h0,       32'h00010000,32'h0,       32'h0       };
    reg [127:0]pm3={32'h0,       32'h0,       32'h00010083,32'h00010000};
    reg [127:0]pm4={32'h0,       32'h0,       32'h80010083,32'h0       };

    //-----------黑魔法算法 -----------
    //-------------------------------------project 矩阵↑
    
    //坐标变换
    
    wire [127:0] wcm1,wcm2,wcm3,wcm4;
    wire [127:0] tm1,tm2,tm3,tm4;
    matrix_mul muler1_m (wm1,wm2,wm3,wm4,     cm1,cm2,cm3,cm4, wcm1,wcm2,wcm3,wcm4);    //WorldCameraMatrix=WorldMatrix      *   CameraMatrix
    matrix_mul muler2_m (wcm1,wcm2,wcm3,wcm4, pm1,pm2,pm3,pm4, tm1,tm2,tm3,tm4);        //TransformMatrix=WorldCameraMatrix  *   ProjectMatrix
    
    reg [127:0]Point1={32'h80010000,32'h00010000,32'h00010000,32'h00010000};
    reg [127:0]Point2={32'h00010000,32'h00010000,32'h00010000,32'h00010000};
    reg [127:0]Point3={32'h00010000,32'h80010000,32'h00010000,32'h00010000};
    reg [127:0]Point4={32'h80010000,32'h80010000,32'h00010000,32'h00010000};
    reg [127:0]Point5={32'h80010000,32'h00010000,32'h80010000,32'h00010000};
    reg [127:0]Point6={32'h00010000,32'h00010000,32'h80010000,32'h00010000};
    reg [127:0]Point7={32'h00010000,32'h80010000,32'h80010000,32'h00010000};
    reg [127:0]Point8={32'h80010000,32'h80010000,32'h80010000,32'h00010000};
    
    wire [127:0] point_t1;//变换后点的坐标
    wire [127:0] point_t2;
    wire [127:0] point_t3;
    wire [127:0] point_t4;
    wire [127:0] point_t5;
    wire [127:0] point_t6;
    wire [127:0] point_t7;
    wire [127:0] point_t8;
    matrix_apply applyer1 (Point1,tm1,tm2,tm3,tm4,point_t1);
    matrix_apply applyer2 (Point2,tm1,tm2,tm3,tm4,point_t2);
    matrix_apply applyer3 (Point3,tm1,tm2,tm3,tm4,point_t3);
    matrix_apply applyer4 (Point4,tm1,tm2,tm3,tm4,point_t4);
    matrix_apply applyer5 (Point5,tm1,tm2,tm3,tm4,point_t5);
    matrix_apply applyer6 (Point6,tm1,tm2,tm3,tm4,point_t6);
    matrix_apply applyer7 (Point7,tm1,tm2,tm3,tm4,point_t7);
    matrix_apply applyer8 (Point8,tm1,tm2,tm3,tm4,point_t8);
    
    /*
        // 世界坐标到相机坐标
        void transform_homogenize(transform_t *ts, vector_t *y, vector_t *x) {
            float rhw = 1.0f / x->w;
            y->x = (x->x * rhw + 1.0f) * SCREEN_WIDTH * 0.5f;
            y->y = (1.0f - x->y * rhw) * SCREEN_HEIGHT * 0.5f;
            y->z = x->z * rhw;
            y->w = 1.0f;
        }
    */

    reg [31:0] num_one=32'h00010000;
    wire [31:0] rhw_1;
    wire [31:0] rhw_2;
    wire [31:0] rhw_3;
    wire [31:0] rhw_4;
    wire [31:0] rhw_5;
    wire [31:0] rhw_6;
    wire [31:0] rhw_7;
    wire [31:0] rhw_8;
    wire div_result_flag_1;
    wire div_result_flag_2;
    wire div_result_flag_3;
    wire div_result_flag_4;
    wire div_result_flag_5;
    wire div_result_flag_6;
    wire div_result_flag_7;
    wire div_result_flag_8;
    div_32bit_SFIX div1(.clk(clk),.s_axis_a_tvalid(valid_in_angle),.a(num_one),.b(point_t1[31:0]),.m_axis_result_tvalid(div_result_flag_1),.result(rhw_1));
    div_32bit_SFIX div2(.clk(clk),.s_axis_a_tvalid(valid_in_angle),.a(num_one),.b(point_t2[31:0]),.m_axis_result_tvalid(div_result_flag_2),.result(rhw_2));
    div_32bit_SFIX div3(.clk(clk),.s_axis_a_tvalid(valid_in_angle),.a(num_one),.b(point_t3[31:0]),.m_axis_result_tvalid(div_result_flag_3),.result(rhw_3));
    div_32bit_SFIX div4(.clk(clk),.s_axis_a_tvalid(valid_in_angle),.a(num_one),.b(point_t4[31:0]),.m_axis_result_tvalid(div_result_flag_4),.result(rhw_4));
    div_32bit_SFIX div5(.clk(clk),.s_axis_a_tvalid(valid_in_angle),.a(num_one),.b(point_t5[31:0]),.m_axis_result_tvalid(div_result_flag_5),.result(rhw_5));
    div_32bit_SFIX div6(.clk(clk),.s_axis_a_tvalid(valid_in_angle),.a(num_one),.b(point_t6[31:0]),.m_axis_result_tvalid(div_result_flag_6),.result(rhw_6));
    div_32bit_SFIX div7(.clk(clk),.s_axis_a_tvalid(valid_in_angle),.a(num_one),.b(point_t7[31:0]),.m_axis_result_tvalid(div_result_flag_7),.result(rhw_7));
    div_32bit_SFIX div8(.clk(clk),.s_axis_a_tvalid(valid_in_angle),.a(num_one),.b(point_t8[31:0]),.m_axis_result_tvalid(div_result_flag_8),.result(rhw_8));
    
    reg [31:0] Rhw_1;
    reg [31:0] Rhw_2;
    reg [31:0] Rhw_3;
    reg [31:0] Rhw_4;
    reg [31:0] Rhw_5;
    reg [31:0] Rhw_6;
    reg [31:0] Rhw_7;
    reg [31:0] Rhw_8;
    
    
    always@(posedge clk)
    begin
        if(div_result_flag_1==1)
        begin
            Rhw_1<=rhw_1;
            Rhw_2<=rhw_2;
            Rhw_3<=rhw_3;
            Rhw_4<=rhw_4;
            Rhw_5<=rhw_5;
            Rhw_6<=rhw_6;
            Rhw_7<=rhw_7;
            Rhw_8<=rhw_8;
        end
       
    end

            //tx0 = point_t1* Rhw
    wire [31:0] tx0_1;
    wire [31:0] tx0_2;
    wire [31:0] tx0_3;
    wire [31:0] tx0_4;
    wire [31:0] tx0_5;
    wire [31:0] tx0_6;
    wire [31:0] tx0_7;
    wire [31:0] tx0_8;
    
    mul_32bit_SFIX muler_t1(.a(point_t1[127:96]),.b(Rhw_1),.product(tx0_1));
    mul_32bit_SFIX muler_t2(.a(point_t2[127:96]),.b(Rhw_2),.product(tx0_2));
    mul_32bit_SFIX muler_t3(.a(point_t3[127:96]),.b(Rhw_3),.product(tx0_3));
    mul_32bit_SFIX muler_t4(.a(point_t4[127:96]),.b(Rhw_4),.product(tx0_4));
    mul_32bit_SFIX muler_t5(.a(point_t5[127:96]),.b(Rhw_5),.product(tx0_5));
    mul_32bit_SFIX muler_t6(.a(point_t6[127:96]),.b(Rhw_6),.product(tx0_6));
    mul_32bit_SFIX muler_t7(.a(point_t7[127:96]),.b(Rhw_7),.product(tx0_7));
    mul_32bit_SFIX muler_t8(.a(point_t8[127:96]),.b(Rhw_8),.product(tx0_8));
    
    //tx1=tx0+1
    
    wire [31:0] tx1_1;
    wire [31:0] tx1_2;
    wire [31:0] tx1_3;
    wire [31:0] tx1_4;
    wire [31:0] tx1_5;
    wire [31:0] tx1_6;
    wire [31:0] tx1_7;
    wire [31:0] tx1_8;
    
    add_32bit_SFIX adder_tt1(.a(tx0_1),.b(num_one),.sum(tx1_1));
    add_32bit_SFIX adder_tt2(.a(tx0_2),.b(num_one),.sum(tx1_2));
    add_32bit_SFIX adder_tt3(.a(tx0_3),.b(num_one),.sum(tx1_3));
    add_32bit_SFIX adder_tt4(.a(tx0_4),.b(num_one),.sum(tx1_4));
    add_32bit_SFIX adder_tt5(.a(tx0_5),.b(num_one),.sum(tx1_5));
    add_32bit_SFIX adder_tt6(.a(tx0_6),.b(num_one),.sum(tx1_6));
    add_32bit_SFIX adder_tt7(.a(tx0_7),.b(num_one),.sum(tx1_7));
    add_32bit_SFIX adder_tt8(.a(tx0_8),.b(num_one),.sum(tx1_8));
    
    //SCREEN_WIDTH*0.5f =128
    reg [31:0] half_SCREEN_WIDTH=32'h00800000;
    //tx2=tx1*half_SCREEN_WIDTH
    wire [31:0] tx2_1;
    wire [31:0] tx2_2;
    wire [31:0] tx2_3;
    wire [31:0] tx2_4;
    wire [31:0] tx2_5;
    wire [31:0] tx2_6;
    wire [31:0] tx2_7;
    wire [31:0] tx2_8;
    mul_32bit_SFIX mul_ttt1(.a(tx1_1),.b(half_SCREEN_WIDTH),.product(tx2_1));
    mul_32bit_SFIX mul_ttt2(.a(tx1_2),.b(half_SCREEN_WIDTH),.product(tx2_2));
    mul_32bit_SFIX mul_ttt3(.a(tx1_3),.b(half_SCREEN_WIDTH),.product(tx2_3));
    mul_32bit_SFIX mul_ttt4(.a(tx1_4),.b(half_SCREEN_WIDTH),.product(tx2_4));
    mul_32bit_SFIX mul_ttt5(.a(tx1_5),.b(half_SCREEN_WIDTH),.product(tx2_5));
    mul_32bit_SFIX mul_ttt6(.a(tx1_6),.b(half_SCREEN_WIDTH),.product(tx2_6));
    mul_32bit_SFIX mul_ttt7(.a(tx1_7),.b(half_SCREEN_WIDTH),.product(tx2_7));
    mul_32bit_SFIX mul_ttt8(.a(tx1_8),.b(half_SCREEN_WIDTH),.product(tx2_8));
    
    //ty0 = pointy*Rhw
    wire [31:0] ty0_1;
    wire [31:0] ty0_2;
    wire [31:0] ty0_3;
    wire [31:0] ty0_4;
    wire [31:0] ty0_5;
    wire [31:0] ty0_6;
    wire [31:0] ty0_7;
    wire [31:0] ty0_8;
    
    mul_32bit_SFIX muler_ty1(.a(point_t1[95:64]),.b(Rhw_1),.product(ty0_1));
    mul_32bit_SFIX muler_ty2(.a(point_t2[95:64]),.b(Rhw_2),.product(ty0_2));
    mul_32bit_SFIX muler_ty3(.a(point_t3[95:64]),.b(Rhw_3),.product(ty0_3));
    mul_32bit_SFIX muler_ty4(.a(point_t4[95:64]),.b(Rhw_4),.product(ty0_4));
    mul_32bit_SFIX muler_ty5(.a(point_t5[95:64]),.b(Rhw_5),.product(ty0_5));
    mul_32bit_SFIX muler_ty6(.a(point_t6[95:64]),.b(Rhw_6),.product(ty0_6));
    mul_32bit_SFIX muler_ty7(.a(point_t7[95:64]),.b(Rhw_7),.product(ty0_7));
    mul_32bit_SFIX muler_ty8(.a(point_t8[95:64]),.b(Rhw_8),.product(ty0_8));

    //ty1=1-ty0
    wire [31:0] ty1_1;
    wire [31:0] ty1_2;
    wire [31:0] ty1_3;
    wire [31:0] ty1_4;
    wire [31:0] ty1_5;
    wire [31:0] ty1_6;
    wire [31:0] ty1_7;
    wire [31:0] ty1_8;
    
    sub_32bit_SFIX suber_tty1(.a(num_one),.b(ty0_1),.sub(ty1_1));
    sub_32bit_SFIX suber_tty2(.a(num_one),.b(ty0_2),.sub(ty1_2));
    sub_32bit_SFIX suber_tty3(.a(num_one),.b(ty0_3),.sub(ty1_3));
    sub_32bit_SFIX suber_tty4(.a(num_one),.b(ty0_4),.sub(ty1_4));
    sub_32bit_SFIX suber_tty5(.a(num_one),.b(ty0_5),.sub(ty1_5));
    sub_32bit_SFIX suber_tty6(.a(num_one),.b(ty0_6),.sub(ty1_6));
    sub_32bit_SFIX suber_tty7(.a(num_one),.b(ty0_7),.sub(ty1_7));
    sub_32bit_SFIX suber_tty8(.a(num_one),.b(ty0_8),.sub(ty1_8));
    
    
    reg [31:0] half_SCREEN_HEIGHT=32'h00600000;
    // ty2=ty1*half_SCREEN_HEIGHT
    wire [31:0] ty2_1;
    wire [31:0] ty2_2;
    wire [31:0] ty2_3;
    wire [31:0] ty2_4;
    wire [31:0] ty2_5;
    wire [31:0] ty2_6;
    wire [31:0] ty2_7;
    wire [31:0] ty2_8;
    mul_32bit_SFIX muler_tty1(.a(ty1_1),.b(half_SCREEN_HEIGHT),.product(ty2_1));
    mul_32bit_SFIX muler_tty2(.a(ty1_2),.b(half_SCREEN_HEIGHT),.product(ty2_2));
    mul_32bit_SFIX muler_tty3(.a(ty1_3),.b(half_SCREEN_HEIGHT),.product(ty2_3));
    mul_32bit_SFIX muler_tty4(.a(ty1_4),.b(half_SCREEN_HEIGHT),.product(ty2_4));
    mul_32bit_SFIX muler_tty5(.a(ty1_5),.b(half_SCREEN_HEIGHT),.product(ty2_5));
    mul_32bit_SFIX muler_tty6(.a(ty1_6),.b(half_SCREEN_HEIGHT),.product(ty2_6));
    mul_32bit_SFIX muler_tty7(.a(ty1_7),.b(half_SCREEN_HEIGHT),.product(ty2_7));
    mul_32bit_SFIX muler_tty8(.a(ty1_8),.b(half_SCREEN_HEIGHT),.product(ty2_8));
    
    assign valid_out=div_result_flag_1;//结果的有效性
    
    always@(clk)
    begin
        if(valid_out==1)
        begin
            point0x<=tx2_1[30:16];
            point1x<=tx2_2[30:16];
            point2x<=tx2_3[30:16];
            point3x<=tx2_4[30:16];
            point4x<=tx2_5[30:16];
            point5x<=tx2_6[30:16];
            point6x<=tx2_7[30:16];
            point7x<=tx2_8[30:16];
            
            point0y<=ty2_1[30:16];
            point1y<=ty2_2[30:16];
            point2y<=ty2_3[30:16];
            point3y<=ty2_4[30:16];
            point4y<=ty2_5[30:16];
            point5y<=ty2_6[30:16];
            point6y<=ty2_7[30:16];
            point7y<=ty2_8[30:16];
        end
    end
    
    


    
    
endmodule
