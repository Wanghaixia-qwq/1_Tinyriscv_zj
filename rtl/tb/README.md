# rvseed_6.gtkw
此文件为GTKWave波形观察数据元保存

# sim.out
此文件为经iverilog对tb_rvseed.v进行编译后，生成的sim.out

# sim.sh
此文件为bash脚本，其内包含了iverilog相关操作以及vvp相关操作

# sim_out.vcd
此文件为经vvp对sim.out编译后，生成的GTKWave波形文件

# tb_rvseed.v
此文件为Testbench文件，用于单个指令测试时，配合sim.sh脚本使用

# tb_rvseed_many.v
此文件为Testbench文件，用于多个指令测试时，配合../1_Tinyriscv_zj/sim/test_all_inst.py脚本使用
