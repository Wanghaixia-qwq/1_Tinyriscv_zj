# compile_rtl.py
功能：编译rtl代码。
使用方法(linux)：python compile_rtl.py + 'rtl目录的相对路径'
举例：python compile_rtl.py .. // ..是一个自定义的标号，详细请看compile_rtl.py内部描述

# test_one_inst.py
功能：对指定的bin文件(重新生成inst.data文件)进行测试。
使用方法(linux)：python test_one_inst.py + 'xxxx.bin' + 'inst.data' // 这个inst.data是使用'xxx.bin'重新调用SimToBin.py文件生成的指令
举例：python test_one_inst.py ../tests/isa/generated/rv32ui-p-add.bin inst.data

# test_all_inst.py
功能：一次性测试 ../rtl/inst_test目录下的所有指令。
使用方法(linux)：python test_all_inst
举例：null

# 调用关系
test_all_inst.py 调用 test_one_inst.py 调用 BinToMem_CLI.py 和 compile_rtl.py ; compile_rtl.py 调用 vvp

# 后面增加测试指令时
将需要测试的指令对应的.bin文件放到～/Project/1_Tinyriscv_zj/rtl/inst_test/文件夹下即可

