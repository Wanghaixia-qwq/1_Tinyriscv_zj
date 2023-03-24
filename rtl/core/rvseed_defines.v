// +FHDR------------------------------------------------------------------
//                 Copyright (c) 2022 
//                       ALL RIGHTS RESERVED
// -----------------------------------------------------------------------
// Filename      : defines.v
// Author        : Rongye
// Created On    : 2022-03-21 20:17
// Last Modified : 2022-04-08 23:36
// -----------------------------------------------------------------------
// Description   : Parameter definitions. 
//
//
// -FHDR------------------------------------------------------------------

// simulation clock period
`define SIM_PERIOD 20 // 20ns -> 50MHz 

// processor 
`define CPU_WIDTH 32 // rv32

// instruction memory
`define INST_MEM_ADDR_DEPTH 1024
`define INST_MEM_ADDR_WIDTH 10 // 2^10 = 1024
