// +FHDR----------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                       ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : reg_file.v
// Author        : Rongye
// Created On    : 2022-03-23 23:18
// Last Modified : 2022-04-01 10:02
// ---------------------------------------------------------------------------------
// Description   : The x1~x31 registers represent integer general registers, whose 
// function is to save the intermediate results of program operation and store the 
// integer type. x0 registers represent constant 0, and x0 can be used to implement 
// some instruction functions. 
//
// -FHDR----------------------------------------------------------------------------
`include "rvseed_defines.v"

module reg_file (
    input                            clk,
    input                            rst_n,

    input                            reg_wen,    // register write enable
    input      [`REG_ADDR_WIDTH-1:0] reg_waddr,  // register write address
    input      [`CPU_WIDTH-1:0]      reg_wdata,  // register write data
    
    input      [`REG_ADDR_WIDTH-1:0] reg1_raddr, // register 1 read address
    input      [`REG_ADDR_WIDTH-1:0] reg2_raddr, // register 2 read address
    output reg [`CPU_WIDTH-1:0]      reg1_rdata, // register 1 read data
    output reg [`CPU_WIDTH-1:0]      reg2_rdata  // register 2 read data
);

reg [`CPU_WIDTH-1:0] reg_f [0:`REG_DATA_DEPTH-1]; 

// register write
always @(posedge clk or negedge rst_n) begin
    if (rst_n && reg_wen && (reg_waddr != `REG_ADDR_WIDTH'b0)) // x0 read only
        reg_f[reg_waddr] <= reg_wdata; 
end

// register 1 read
always @(*) begin
    if(reg1_raddr == `REG_ADDR_WIDTH'b0)
        reg1_rdata = `CPU_WIDTH'b0;
    else
        reg1_rdata = reg_f[reg1_raddr];
end

// register 2 read
always @(*) begin
    if(reg2_raddr == `REG_ADDR_WIDTH'b0)
        reg2_rdata = `CPU_WIDTH'b0;
    else
        reg2_rdata = reg_f[reg2_raddr];
end

endmodule
