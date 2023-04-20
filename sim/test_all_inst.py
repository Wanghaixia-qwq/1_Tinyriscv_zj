import os
import subprocess
import sys

# 找出path目录下的所有bin文件
def list_binfiles(path):
        files = []
        list_dir = os.walk(path)
        for maindir, subdir, all_file in list_dir:
                for filename in all_file:
                        apath = os.path.join(maindir, filename)
                        if apath.endswith('.bin'):
                                files.append(apath)

        return files

# 主函数
def main():
        bin_files = list_binfiles(r'../rtl/inst_test') # 存放当前需要测试的所有指令

        anyfail = False
        number = 0

        # 对每一个bin文件进行测试
        for file in bin_files:
                # print(file)
                cmd = r'python test_one_inst.py' + ' ' + file + ' ' + 'inst' # 把本轮测试的.bin文件转换成新的inst.data
                # 到这一步之前，没有问题
                f = os.popen(cmd)
                r = f.read()
                f.close()
                if (r.find('TEST_PASS') != -1):
                        number = number + 1
                        print(file + '          PASS' + '    ' +  str(number))
                else:
                        print(file + '          !!!FAIL!!!')
                        anyfail = True
                        break

        if (anyfail == False):
                print("~~~The  number of total insts is  %d, Congratulation, All  PASS~~~" %number)

if __name__ == '__main__':
        sys.exit(main())     
