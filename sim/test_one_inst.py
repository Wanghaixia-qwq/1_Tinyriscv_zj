import sys
import filecmp
import subprocess
import sys
import os


# 主函数
def main():
    #print(sys.argv[0] + ' ' + sys.argv[1] + ' ' + sys.argv[2])

    # 1.将bin文件转成二进制指令文件
    # argv[1]为.bin文件 argv[2]为需要生成的inst.data文件
    cmd = r'python ../tools/BinToMem_CLI.py' + ' ' + sys.argv[1] + ' ' + sys.argv[2]
    f = os.popen(cmd)
    f.close()

    # 2.编译rtl文件
    cmd = r'python compile_rtl.py' + r'  ..' # ..为自定义的一个标识符，详见compile_rtl.py内部定义
    f = os.popen(cmd)
    f.close()
    print('此条指令已编译完成！')

    # 3.运行  这一步 之前已经生成out.vvp
    vvp_cmd = [r'vvp']
    vvp_cmd.append(r'-n')
    vvp_cmd.append(r'sim.out')
    process = subprocess.Popen(vvp_cmd)
    # try:
    #       可能产生异常的代码块
    # except [Exception]:
    #       处理异常代码块
    try:
        process.wait(timeout=20)
    except subprocess.TimeoutExpired:
        print('!!!Fail, vvp exec timeout!!!')


if __name__ == '__main__':
    sys.exit(main())
