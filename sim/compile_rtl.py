import sys
import filecmp
import subprocess
import sys
import os


# 主函数
def main():
    rtl_dir = sys.argv[1]
    # rtl_dir = '..'

    if rtl_dir != r'..':
        tb_file = r'../rtl/tb/tb_rvseed_many.v' # 相比加了个..
    else:
        tb_file = r'/rtl/tb/tb_rvseed_many.v' # testbench文件

    # iverilog程序
    iverilog_cmd = ['iverilog']
    # 顶层模块
    #iverilog_cmd += ['-s', r'tinyriscv_soc_tb']
    # 编译生成文件
    iverilog_cmd += ['-o', r'sim.out']
    # 头文件(defines.v)路径
    iverilog_cmd += ['-I', rtl_dir + r'/rtl/core']
    # 宏定义，仿真输出文件
    iverilog_cmd += ['-D', r'OUTPUT="signature.output"']
    # testbench文件
    iverilog_cmd.append(rtl_dir + tb_file)
    # ../rtl/core
    iverilog_cmd.append(rtl_dir + r'/rtl/core/alu.v')
    iverilog_cmd.append(rtl_dir + r'/rtl/core/ctrl.v')
    iverilog_cmd.append(rtl_dir + r'/rtl/core/imm_gen.v')
    iverilog_cmd.append(rtl_dir + r'/rtl/core/inst_mem.v')
    iverilog_cmd.append(rtl_dir + r'/rtl/core/mux_alu.v')
    iverilog_cmd.append(rtl_dir + r'/rtl/core/mux_pc.v')
    iverilog_cmd.append(rtl_dir + r'/rtl/core/pc_reg.v')
    iverilog_cmd.append(rtl_dir + r'/rtl/core/reg_file.v')
    iverilog_cmd.append(rtl_dir + r'/rtl/core/rvseed.v')
    iverilog_cmd.append(rtl_dir + r'/rtl/core/rvseed_defines.v')
    # ../rtl/perips 挂载的外设
    # iverilog_cmd.append(rtl_dir + r'/rtl/perips/ram.v')
    # iverilog_cmd.append(rtl_dir + r'/rtl/perips/rom.v')
    # iverilog_cmd.append(rtl_dir + r'/rtl/perips/timer.v')
    # iverilog_cmd.append(rtl_dir + r'/rtl/perips/uart.v')
    # iverilog_cmd.append(rtl_dir + r'/rtl/perips/gpio.v')
    # iverilog_cmd.append(rtl_dir + r'/rtl/perips/spi.v')
    # ../rtl/debug 调试
    # iverilog_cmd.append(rtl_dir + r'/rtl/debug/jtag_dm.v')
    # iverilog_cmd.append(rtl_dir + r'/rtl/debug/jtag_driver.v')
    # iverilog_cmd.append(rtl_dir + r'/rtl/debug/jtag_top.v')
    # iverilog_cmd.append(rtl_dir + r'/rtl/debug/uart_debug.v')
    # ../rtl/soc
    # iverilog_cmd.append(rtl_dir + r'/rtl/soc/tinyriscv_soc_top.v')
    # ../rtl/utils
    # iverilog_cmd.append(rtl_dir + r'/rtl/utils/full_handshake_rx.v')
    # iverilog_cmd.append(rtl_dir + r'/rtl/utils/full_handshake_tx.v')
    # iverilog_cmd.append(rtl_dir + r'/rtl/utils/gen_buf.v')
    # iverilog_cmd.append(rtl_dir + r'/rtl/utils/gen_dff.v')

    # 编译
    process = subprocess.Popen(iverilog_cmd)
    process.wait(timeout=5)

if __name__ == '__main__':
    sys.exit(main())
