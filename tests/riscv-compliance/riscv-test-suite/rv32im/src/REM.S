# RISC-V Compliance Test RV32IM-REM-01
#
# Copyright (c) 2018, Imperas Software Ltd.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#      * Redistributions of source code must retain the above copyright
#        notice, this list of conditions and the following disclaimer.
#      * Redistributions in binary form must reproduce the above copyright
#        notice, this list of conditions and the following disclaimer in the
#        documentation and/or other materials provided with the distribution.
#      * Neither the name of the Imperas Software Ltd. nor the
#        names of its contributors may be used to endorse or promote products
#        derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
# IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL Imperas Software Ltd. BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
# THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# Specification: RV32IM Base Integer Instruction Set, Version 2.0
# Description: Testing instruction REM.

#include "test_macros.h"
#include "compliance_test.h"
#include "compliance_io.h"

RV_COMPLIANCE_RV32M

RV_COMPLIANCE_CODE_BEGIN

	RVTEST_IO_INIT
	RVTEST_IO_ASSERT_GPR_EQ(x31, x0, 0x00000000)
	RVTEST_IO_WRITE_STR(x31, "Test Begin Reserved regs ra(x1) a0(x10) t0(x5)\n")

	# ---------------------------------------------------------------------------------------------

	RVTEST_IO_WRITE_STR(x31, "# Test number 1 - corner cases\n")

	# address for test results
	la	x2, test_1_res

	TEST_RR_SRC2(rem, x17, x18, 0, 0x0, 0x0, x2, 0)
	TEST_RR_SRC2(rem, x19, x20, 0, 0x0, 0x1, x2, 4)
	TEST_RR_SRC2(rem, x21, x22, 0, 0x0, -0x1, x2, 8)
	TEST_RR_SRC2(rem, x23, x24, 0, 0x0, 0x7fffffff, x2, 12)
	TEST_RR_SRC2(rem, x25, x26, 0, 0x0, 0x80000000, x2, 16)

	# ---------------------------------------------------------------------------------------------

	RVTEST_IO_WRITE_STR(x31, "# Test number 2 - corner cases\n")

	# address for test results
	la	x2, test_2_res

	TEST_RR_SRC2(rem, x27, x28, 0x1, 0x1, 0x0, x2, 0)
	TEST_RR_SRC2(rem, x29, x30, 0, 0x1, 0x1, x2, 4)
	TEST_RR_SRC2(rem, x21, x3, 0, 0x1, -0x1, x2, 8)
	TEST_RR_SRC2(rem, x4, x8, 0x1, 0x1, 0x7fffffff, x2, 12)
	TEST_RR_SRC2(rem, x9, x11, 0x1, 0x1, 0x80000000, x2, 16)

	# ---------------------------------------------------------------------------------------------

	RVTEST_IO_WRITE_STR(x31, "# Test number 3 - corner cases\n")

	# address for test results
	la	x2, test_3_res

	TEST_RR_SRC2(rem, x12, x13, 0xffffffff, -0x1, 0x0, x2, 0)
	TEST_RR_SRC2(rem, x14, x15, 0, -0x1, 0x1, x2, 4)
	TEST_RR_SRC2(rem, x16, x17, 0, -0x1, -0x1, x2, 8)
	TEST_RR_SRC2(rem, x18, x19, 0xffffffff, -0x1, 0x7fffffff, x2, 12)
	TEST_RR_SRC2(rem, x20, x21, 0xffffffff, -0x1, 0x80000000, x2, 16)

	# ---------------------------------------------------------------------------------------------

	RVTEST_IO_WRITE_STR(x31, "# Test number 4 - corner cases\n")

	# address for test results
	la	x2, test_4_res

	TEST_RR_SRC2(rem, x22, x23, 0x7fffffff, 0x7fffffff, 0x0, x2, 0)
	TEST_RR_SRC2(rem, x24, x25, 0, 0x7fffffff, 0x1, x2, 4)
	TEST_RR_SRC2(rem, x26, x27, 0, 0x7fffffff, -0x1, x2, 8)
	TEST_RR_SRC2(rem, x28, x29, 0, 0x7fffffff, 0x7fffffff, x2, 12)
	TEST_RR_SRC2(rem, x30, x21, 0x7fffffff, 0x7fffffff, 0x80000000, x2, 16)

	# ---------------------------------------------------------------------------------------------

	RVTEST_IO_WRITE_STR(x31, "# Test number 5 - corner cases\n")

	# address for test results
	la	x2, test_5_res

	TEST_RR_SRC2(rem, x3, x4, 0x80000000, 0x80000000, 0x0, x2, 0)
	TEST_RR_SRC2(rem, x8, x9, 0, 0x80000000, 0x1, x2, 4)
	TEST_RR_SRC2(rem, x11, x12, 0, 0x80000000, -0x1, x2, 8)
	TEST_RR_SRC2(rem, x13, x14, 0xffffffff, 0x80000000, 0x7fffffff, x2, 12)
	TEST_RR_SRC2(rem, x15, x16, 0, 0x80000000, 0x80000000, x2, 16)

	RVTEST_IO_WRITE_STR(x31, "Test End\n")

	# ---------------------------------------------------------------------------------------------

	RV_COMPLIANCE_HALT

RV_COMPLIANCE_CODE_END

# Input data section.
	.data

# Output data section.
RV_COMPLIANCE_DATA_BEGIN
test_1_res:
	.fill 5, 4, -1
test_2_res:
	.fill 5, 4, -1
test_3_res:
	.fill 5, 4, -1
test_4_res:
	.fill 5, 4, -1
test_5_res:
	.fill 5, 4, -1
test_6_res:
	.fill 5, 4, -1
test_7_res:
	.fill 5, 4, -1
test_8_res:
	.fill 5, 4, -1
test_9_res:
	.fill 5, 4, -1
test_10_res:
	.fill 5, 4, -1

RV_COMPLIANCE_DATA_END
