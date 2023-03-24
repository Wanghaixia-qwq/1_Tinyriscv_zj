// +FHDR----------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                       ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : pc_reg.v
// Author        : Rongye
// Created On    : 2022-03-21 20:17
// Last Modified : 2022-03-30 05:17
// ---------------------------------------------------------------------------------
// Description   : Update the current pc value 
//
// -FHDR----------------------------------------------------------------------------
`include "rvseed_defines.v"

module pc_reg (
    input                       clk,     // system clock
    input                       rst_n,   // active low reset
    output reg                  ena,     // system enable
    input      [`CPU_WIDTH-1:0] next_pc, // next pc addr
    output reg [`CPU_WIDTH-1:0] curr_pc  // current pc addr
);

always @ (posedge clk or negedge rst_n) begin
    if(~rst_n)
        ena <= 1'b0;
    else
        ena <= 1'b1;      
end

always @ (posedge clk or negedge rst_n) begin
    if(~rst_n)
        curr_pc <= `CPU_WIDTH'b0;
    else
        curr_pc <= next_pc;
end    

endmodule
