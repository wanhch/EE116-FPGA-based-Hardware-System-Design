#!/usr/bin/env python3
# -*- coding: UTF-8 -*-

import os
import struct

de128 = 0
en192 = 0
de192 = 0
en256 = 0
de256 = 0

with open("../eval/AES_testcases_128.txt", "r") as input_file:
    file = input_file.readlines()

with open("output.txt", "r") as answer_file:
    result = answer_file.readlines()

with open("../eval/AES_results_encryption_128.txt", "w") as result_file:
    idx = 0
    for line in file:
        print(line)
        temp = line.split()            
        if temp[0] == '0':
            cipher = eval("0x%s"%temp[3])
            print(result[idx].strip())
            print(str(bin(cipher)).replace("0b", "").rjust(128, '0'))
            if (result[idx].strip()  == str(bin(cipher)).replace("0b", "").rjust(128, '0')):
                result_file.write('P')
            else:
                result_file.write('F')
            idx += 1
        elif temp[0] == '1':
            result_file.write('N')
            de128 += 1
        result_file.write('\n')

with open("../eval/AES_testcases_192.txt", "r") as input_file:
    file = input_file.readlines()
    for line in file:
        temp = line.split()
        if temp[0] == '0':
            en192 += 1;
        elif temp[0] == '1':
            de192 += 1;

with open("../eval/AES_testcases_256.txt", "r") as input_file:
    file = input_file.readlines()
    for line in file:
        temp = line.split()
        if temp[0] == '0':
            en256 += 1;
        elif temp[0] == '1':
            de256 += 1;

with open("../eval/AES_results_decryption_128.txt", "w") as result_file:
    for idx in range(de128):
        if (idx != 0):
            result_file.write('\n')
        result_file.write('N')

with open("../eval/AES_results_encryption_192.txt", "w") as result_file:
    for idx in range(en192):
        if (idx != 0):
            result_file.write('\n')
        result_file.write('N')

with open("../eval/AES_results_decryption_192.txt", "w") as result_file:
    for idx in range(de192):
        if (idx != 0):
            result_file.write('\n')
        result_file.write('N')

with open("../eval/AES_results_encryption_256.txt", "w") as result_file:
    for idx in range(en256):
        if (idx != 0):
            result_file.write('\n')
        result_file.write('N')

with open("../eval/AES_results_decryption_256.txt", "w") as result_file:
    for idx in range(de256):
        if (idx != 0):
            result_file.write('\n')
        result_file.write('N')

# for idx in range(len(ref)):
#     if (result[idx].strip()  == ref[idx]):
        
#     else:
        

# with open("input.txt", "w") as output:
#     for item in input:
#         output.write(item[0])
#         output.write(item[1])
#         output.write('\n')