// +FHDR----------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                       ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : alu.v
// Author        : Rongye
// Created On    : 2022-03-24 23:36
// Last Modified : 2022-04-13 04:05
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
    input      [`CPU_WIDTH-1:0]    inst,     // instruction input
    output reg                     zero,     // alu result is zero
    output reg [`CPU_WIDTH-1:0]    alu_res   // alu result
);

// Define some mask!
assign op1_ge_op2_signed = $signed(alu_src1) >= $signed(alu_src2);
assign op1_ge_op2_unsigned = alu_src1 >= alu_src2;

// Run!
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
        `ALU_XOR:begin
            alu_res = alu_src1 ^ alu_src2;
            zero = (alu_res == `CPU_WIDTH'b0) ? 1'b1 : 1'b0;
        end
        `ALU_OR:begin
            alu_res = alu_src1 | alu_src2;
            zero = (alu_res == `CPU_WIDTH'b0) ? 1'b1 : 1'b0;
        end
        `ALU_AND:begin
            alu_res = alu_src1 & alu_src2;
            zero = (alu_res == `CPU_WIDTH'b0) ? 1'b1 : 1'b0;
        end
        `ALU_SLL:begin  // 逻辑左移
            alu_res = alu_src1 << alu_src2[4:0];
            zero = (alu_res == `CPU_WIDTH'b0) ? 1'b1 : 1'b0;
        end
        `ALU_SRL:begin  // 逻辑右移
            alu_res = alu_src1 >> alu_src2[4:0];
            zero = (alu_res == `CPU_WIDTH'b0) ? 1'b1 : 1'b0;
        end
        `ALU_SRA:begin  // 算术右移
            alu_res = ($signed(alu_src1)) >>> alu_src2[4:0]; 
            zero = (alu_res == `CPU_WIDTH'b0) ? 1'b1 : 1'b0;
        end
        `ALU_SLT:begin
            alu_res = {32{(~op1_ge_op2_signed)}} & `CPU_WIDTH'h1;
            zero = (alu_res == `CPU_WIDTH'b0) ? 1'b1 : 1'b0;
        end
        `ALU_SLTU:begin
            alu_res = {32{(~op1_ge_op2_unsigned)}} & `CPU_WIDTH'h1;
            zero = (alu_res == `CPU_WIDTH'b0) ? 1'b1 : 1'b0;
        end
    endcase
end
endmodule
