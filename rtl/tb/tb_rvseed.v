// +FHDR----------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                       ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : tb_rvseed.v
// Author        : Rongye
// Created On    : 2022-03-25 04:18
// Last Modified : 2022-04-11 05:30
// ---------------------------------------------------------------------------------
// Description   : 
//
//
// -FHDR----------------------------------------------------------------------------
`timescale 1ns / 1ps
`include "rvseed_defines.v"

module tb_rvseed ();

reg                  clk;
reg                  rst_n;
reg                  zero;
reg [`CPU_WIDTH-1:0] reg_wdata;
reg [5*8-1:0]        inst_name;

initial begin
    #(`SIM_PERIOD/2);
    clk       = 1'b0;
    rst_n     = 1'b0;
    
    zero      = 1'b1;
    reg_wdata = `CPU_WIDTH'h8;

    inst_name = "ADD";
    inst_load(inst_name);
    
    #(`SIM_PERIOD * 1);
    rst_n = 1'b1;
    #(`SIM_PERIOD * 500);
    $stop;
end

initial begin
    #(`SIM_PERIOD * 50000);
    $display("Time Out");
    $finish;
end

always #(`SIM_PERIOD/2) clk = ~clk;

task reset;                // reset 1 clock
    begin
        rst_n = 0; 
        #(`SIM_PERIOD * 1);
        rst_n = 1;
    end
endtask

task inst_load;
    input [5*8-1:0] inst_name;
    begin
        $readmemh (inst_name, u_rvseed_0. u_inst_mem_0. inst_mem_f);
    end
endtask

rvseed u_rvseed_0(
    .clk                            ( clk                           ),
    .rst_n                          ( rst_n                         ),
    .zero                           ( zero                          ),
    .reg_wdata                      ( reg_wdata                     )
);

// iverilog 
initial begin
    $dumpfile("sim_out.vcd");
    $dumpvars;
end

endmodule
