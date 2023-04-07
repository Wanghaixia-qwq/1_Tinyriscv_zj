// +FHDR----------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                       ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : alu.v
// Author        : Rongye
// Created On    : 2022-03-24 23:36
// Last Modified : 2022-04-14 00:13
// ---------------------------------------------------------------------------------
// Description   : Only simple operations:
//                 Integer Arithmetic Operations 
//                 Bit logic operation
//                 Shift operation 
//
// -FHDR----------------------------------------------------------------------------
`include "rvseed_defines.v"

module alu(
    input      [`ALU_OP_WIDTH-1:0] alu_op,   // alu opcode
    input      [`CPU_WIDTH-1:0]    alu_src1, // alu source 1
    input      [`CPU_WIDTH-1:0]    alu_src2, // alu source 2
    output reg                     zero,     // alu result is zero
    output reg [`CPU_WIDTH-1:0]    alu_res   // alu result
);


always @(*) begin
    zero = 1'b0;
    alu_res = `CPU_WIDTH'b0;
    case (alu_op)
        `ALU_ADD: 
            alu_res = alu_src1 + alu_src2;
        `ALU_SUB:begin 
            alu_res = alu_src1 - alu_src2;
            zero = (alu_res == `CPU_WIDTH'b0) ? 1'b1 : 1'b0;
        end
    endcase
end
endmodule
