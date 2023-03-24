// +FHDR----------------------------------------------------------------------------
//                 Copyright (c) 2022 
//                       ALL RIGHTS RESERVED
// ---------------------------------------------------------------------------------
// Filename      : tb_rvseed.v
// Author        : Rongye
// Created On    : 2022-03-25 04:18
// Last Modified : 2022-04-09 00:46
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
reg                  branch; 
reg                  zero;
reg                  jump;
reg [`CPU_WIDTH-1:0] imm;
reg [5*8-1:0]        inst_name;

wire                  ena;
wire [`CPU_WIDTH-1:0] next_pc; 
wire [`CPU_WIDTH-1:0] curr_pc; 
wire [`CPU_WIDTH-1:0] inst; 


initial begin
    #(`SIM_PERIOD/2);
    clk       = 1'b0;
    rst_n     = 1'b0;
    
    branch    = 1'b1;
    zero      = 1'b1;
    jump      = 1'b0;
    imm       = `CPU_WIDTH'h8;
    inst_name = "ADD";
    inst_load(inst_name);
    
    #(`SIM_PERIOD * 1);
    rst_n = 1'b1;
    #1; // To present instant changes
    
    #(`SIM_PERIOD * 50); // test branch inst (bne)
    zero = 1'b0;
    #(`SIM_PERIOD * 1);
    zero = 1'b1;
    #(`SIM_PERIOD * 50); // test jump inst (jal)
    jump = 1'b1;
    #(`SIM_PERIOD * 1);
    jump = 1'b0;
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
        $readmemh (inst_name, u_inst_mem_0. inst_mem_f);
    end
endtask


pc_reg u_pc_reg_0(
    .clk                            ( clk                           ),
    .rst_n                          ( rst_n                         ),
    .ena                            ( ena                           ),
    .next_pc                        ( next_pc                       ),
    .curr_pc                        ( curr_pc                       )
);

inst_mem u_inst_mem_0(
    .curr_pc                        ( curr_pc                       ),
    .inst                           ( inst                          )
);

mux_pc u_mux_pc_0(
    .ena                            ( ena                           ),
    .branch                         ( branch                        ),
    .zero                           ( zero                          ),
    .jump                           ( jump                          ),
    .imm                            ( imm                           ),
    .curr_pc                        ( curr_pc                       ),
    .next_pc                        ( next_pc                       )
);

// iverilog 
initial begin
    $dumpfile("sim_out.vcd");
    $dumpvars;
end

endmodule
