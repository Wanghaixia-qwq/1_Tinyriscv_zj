// +FHDR----------------------------------------------------
//                   Copyright (c) 2023 
//                    ALL RIGHTS RESERVED
// ---------------------------------------------------------
// Filename         : ctrl.v
// Author           : zj
// Creater On       : 2023-03-24 17:11
// Last Modifying   : 
// ---------------------------------------------------------
// Description      : 
//
//
// -FHDR----------------------------------------------------
`include "rvseed_defines.v"

module ctrl(
    input               [`CPU_WIDTH-1:0]    inst,           // instruction input 指令

    output reg                              branch,         // branch flag 分支标志
    output reg                              jump,           // jump flag 跳转标志
    
    // 寄存器控制指令
    output reg                              reg_wen,        // register write enable    写使能
    output reg [`REG_ADDR_WIDTH-1:0]        reg_waddr,      // register write address   写地址
    output reg [`REG_ADDR_WIDTH-1:0]        reg1_raddr,     // register 1 read address  读地址1
    output reg [`REG_ADDR_WIDTH-1:0]        reg2_raddr,     // register 2 read address  读地址2
    
    //立即数扩展操作码
    output reg [`IMM_GEN_OP_WIDTH-1:0]      imm_gen_op,     // immediate extend opcode  立即数扩展的操作码

    output reg [`ALU_OP_WIDTH-1:0]          alu_op,         // alu opcode               alu的操作码
    output reg [`ALU_SRC_WIDTH-1:0]         alu_src_sel     // alu source select flag   alu的数据源选择
);

// 32位的inst分一分
wire [`OPCODE_WIDTH-1:0]    opcode = inst[`OPCODE_WIDTH-1:0];
wire [`FUNCT3_WIDTH-1:0]    funct3 = inst[`FUNCT3_WIDTH + `FUNCT3_BASE-1:`FUNCT3_BASE];
wire [`FUNCT3_WIDTH-1:0]    funct7 = inst[`FUNCT7_WIDTH + `FUNCT7_BASE-1:`FUNCT7_BASE];
wire [`REG_ADDR_WIDTH-1:0]  rd     = inst[`REG_ADDR_WIDTH+`RD_BASE-1:`RD_BASE];
wire [`REG_ADDR_WIDTH-1:0]  rs1    = inst[`REG_ADDR_WIDTH+`RS1_BASE-1:`RS1_BASE];
wire [`REG_ADDR_WIDTH-1:0]  rs2    = inst[`REG_ADDR_WIDTH+`RS2_BASE-1:`RS2_BASE];

always @(*) begin
    branch                      = 1'b0;//这里在always初始就对各寄存器进行了初始化，后边的case即便没有default，仍然不会产生latch
    jump                        = 1'b0;
    reg_wen                     = 1'b0;
    // 此处的各初始值分别为：
    reg1_raddr                  = `REG_ADDR_WIDTH'b0;   // 寄存器1的读地址
    reg2_raddr                  = `REG_ADDR_WIDTH'b0;   // 寄存器2的读地址
    reg_waddr                   = `REG_ADDR_WIDTH'b0;   // 寄存器的写地址
    imm_gen_op                  = `IMM_GEN_I;           // 立即数扩展操作码
    alu_op                      = `ALU_AND;             // alu的操作码  算术单元 逻辑单元
    alu_src_sel                 = `ALU_SRC_REG;         // alu的数据源选择
    
    case(opcode)
        `INST_TYPE_R:begin
            reg_wen         = 1'b1;
            reg1_raddr       = rs1;
            reg2_raddr       = rs2;
            reg_waddr       = rd;
            alu_src_sel     = `ALU_SRC_REG;
            case(funct3)
                `INST_ADD_SUB:
                    alu_op = (funct7 == `FUNCT7_INST_A) ? `ALU_ADD : `ALU_SUB;//add and sub
            endcase
        end
        `INST_TYPE_I:begin
            reg_wen         = 1'b1;
            reg1_raddr       = rs1;
            reg_waddr       = rd;
            alu_src_sel     = `ALU_SRC_IMM;
            case(funct3)
                `INST_ADDI:begin
                    alu_op      = `ALU_ADD;
                end
            endcase
        end
        `INST_TYPE_B:begin
            reg1_raddr      = rs1;
            reg2_raddr      = rs2;
            imm_gen_op      = `IMM_GEN_B;
            alu_src_sel     = `ALU_SRC_REG;
            case(funct3)
                `INST_BNE:begin   // 分支跳转指令
                    branch      = 1'b1; //分支跳转指令->分支跳转信号要拉高
                    alu_op      = `ALU_SUB;
                end
            endcase
        end
        `INST_JAL:begin
            jump            = 1'b1;
            reg_wen         = 1'b1;
            reg_waddr       = rd;
            imm_gen_op      = `IMM_GEN_J;
            alu_op          = `ALU_ADD;
            alu_src_sel     = `ALU_SRC_FOUR_PC;//PC+4
        end
        `INST_LUI:begin
            reg_wen         = 1'b1;
            reg1_raddr      = `REG_ADDR_WIDTH'b0;
            reg_waddr       = rd;
            imm_gen_op      = `IMM_GEN_U;
            alu_op          = `ALU_ADD;
            alu_src_sel     = `ALU_SRC_IMM;//x0 + imm
        end
    endcase
end

endmodule

            













