# core
core文件夹存放了riscv的源代码文件

# dump
dump文件夹存放了各inst对应的.dump文件，即inst的汇编功能翻译。

# inst_all 
inst_all文件夹存放了所有的inst

# inst_test
inst_test文件夹存放了当前需要测试的inst对应的.bin文件

# tb
tb文件夹存放了单个指令测试时的相关文件
～～～单个指令测试时，仍然用Rong晔的代码，其sim.sh+tb_rvseed.v～～～
～～～多个指令测试时，使用自己编写的python+tb_rvseed_many.v～～～
