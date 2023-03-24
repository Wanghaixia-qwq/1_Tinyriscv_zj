// +FHDR----------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                       ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : inst_mem.v
// Author        : Rongye
// Created On    : 2022-03-22 01:33
// Last Modified : 2022-04-08 23:35
// ---------------------------------------------------------------------------------
// Description   : Instruction memory, the initial value is given by testbench. 
//
//
// -FHDR----------------------------------------------------------------------------
`include "rvseed_defines.v"
module inst_mem (
    input      [`CPU_WIDTH-1:0] curr_pc, // current pc addr
    output reg [`CPU_WIDTH-1:0] inst     // instruction
);

reg [`CPU_WIDTH-1:0] inst_mem_f [0:`INST_MEM_ADDR_DEPTH-1];

always @(*) begin
    inst = inst_mem_f[curr_pc[`INST_MEM_ADDR_WIDTH+2-1:2]]; 
end
endmodule
