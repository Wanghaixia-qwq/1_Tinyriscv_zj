// +FHDR----------------------------------------------------
//                   Copyright (c) 2023 
//                    ALL RIGHTS RESERVED
// ---------------------------------------------------------
// Filename         : pc_reg.v
// Author           : zj
// Creater On       : 2023-03-24 11:05
// Last Modifying   : 
// ---------------------------------------------------------
// Description      : 
//
//
// -FHDR----------------------------------------------------
`include "defines.v"

module pc_reg(
    input                           clk,            // system clock
    input                           rst_n,          //active low reset
    output reg                      ena,            //system enable
    input       [`CPU_WIDTH-1:0]    next_pc,        // next pc addr
    output reg  [`CPU_WIDTH-1:0]    curr_pc         // current pc addr
);

always @(posedge clk or negedge rst_n) begin
    if(~rst_n)
        ena <= 1'b0;
    else
        ena <= 1'b1;
end

// pc addr更新
always @(posedge clk or negedge rst_n) begin
    if(~rst_n)
        curr_pc <= `CPU_WIDTH'b0;// 回到第一条指令的位置
    else
        curr_pc <= next_pc;
end

endmodule
