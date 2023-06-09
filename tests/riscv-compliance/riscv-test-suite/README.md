# RISC-V Test Suites

Tests are grouped into different functional test suites targeting the different subsets of the full RISC-V specifications.  There will be ISA and privilege suites.

For information on the test framework and other documentation on the compliance tests look at : [../doc/README.adoc](../doc/README.adoc) 

Currently there are five solid test suites checked into this repository along with a few deprecated/WIP tests. 

If you are looking to check compliance of RV32I in user mode then run the suites: RV32I, RV32ICSR and RV32IFENCEI

To see the coverage of the suites see the riscv-test-suite coverage directory for the summary/detailed reports. These are generated by Imperas by using the github.com/google/riscv-dv UVM coverage testbench and the Mentor Questa SystemVerilog simulator.

Test suites status:

Pretty Solid:
* RV32I (significant improvements (Nov2019) by Imperas)
    * 48 focused tests, using the correct style/macros, excellent coverage of most instructions
    * Coverage 97.23%
* RV32IM (developed by Imperas)
    * 8 focused tests, using the correct style/macros, excellent coverage
    * Coverage 89.95%
* RV32IMC (developed by Imperas)
    * 25 focused tests, using the correct style/macros
    * Coverage 59.68%
* RV32ICSR
    * 6 focused tests
* RV32IFENCEI
    * 1 test
    
Work in progress (64-bit tests):
* RV64I (developed by Imperas)
    * 8 focused tests, using the correct style/macros
* RV64IM (developed by Imperas)
    * 3 focused tests, using the correct style/macros

To be worked on:
* RV64C
* RV32A
* RV64A
* RV64F
* RV64D
* RV32E
* RV32EC
* RV32EA
* RV32EF
* RV32ED
