// +FHDR----------------------------------------------------
//                   Copyright (c) 2023 
//                    ALL RIGHTS RESERVED
// ---------------------------------------------------------
// Filename         : mux_pc.v
// Author           : zj
// Creater On       : 2023-03-24 11:12
// Last Modifying   : 
// ---------------------------------------------------------
// Description      : 
//
//
// -FHDR----------------------------------------------------
`include "defines.v"

module mux_pc(
    input                                   ena,
    input                                   branch,     // branch type
    input                                   zero,       // alu result is zero
    input                                   jump,       //jump type
    input   [`CPU_WIDTH-1:0]                imm,        // immediate
    input   [`CPU_WIDTH-1:0]                curr_pc,    // current pc addr
    output  [`CPU_WIDTH-1:0]                next_pc     // next pc addr
);

always @(*) begin
    if(~ena)
        next_pc = curr_pc;
    else if (branch && ~zero) // bne
        next_pc = curr_pc + imm;
    else if (jump)
        next_pc = curr_pc + imm;
    else
        next_pc = curr_pc + `CPU_WIDTH'h4;
end

endmodule
