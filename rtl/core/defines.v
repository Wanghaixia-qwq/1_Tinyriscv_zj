// +FHDR----------------------------------------------------
//                   Copyright (c) 2023 
//                    ALL RIGHTS RESERVED
// ---------------------------------------------------------
// Filename         : defines.v
// Author           : zj
// Creater On       : 2023-03-23 22:44
// Last Modifying   : 
// ---------------------------------------------------------
// Description      : 
//
//
// -FHDR----------------------------------------------------



// simulation clock period
`define SIM_PERIOD 20 // 20ns -> 50MHz

// processer
`define CPU_WIDTH 32 //rv32

// instruction mmory
`define INST_MEM_ADDR_DEPTH 1024
`define INST_MEM_ADDR_WIDTH 10  //2^10=1024
