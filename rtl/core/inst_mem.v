// +FHDR----------------------------------------------------
//                   Copyright (c) 2023 
//                    ALL RIGHTS RESERVED
// ---------------------------------------------------------
// Filename         : inst_mem.v
// Author           : zj
// Creater On       : 2023-03-23 22:48
// Last Modifying   : 
// ---------------------------------------------------------
// Description      :
//      输入：需要的指令的地址
//      输出：当前地址处的指令inst
// -FHDR----------------------------------------------------


`include "defines.v"
module inst_mem(
    input       [`CPU_WIDTH-1:0] curr_pc,   // current pc addr
    output      [`CPU_WIDTH-1:0] inst       // instruction  riscv的指令是32位的
);

reg [`CPU_WIDTH-1:0] inst_mem_f [`INST_MEM_ADDR_DEPTH-1:0];// 统一高位在左，低位在右,前边是宽度，后边是深度

always @(*) begin
    inst = inst_mem_f[curr_pc[`INST_MEM_ADDR_WIDTH+2-1:2]];
end
endmodule
