#!/usr/bin/env python3
# -*- coding: UTF-8 -*-

import os

with open("../eval/AES_testcases_128.txt", "r") as input_file:
    file = input_file.readlines()

input = []
for line in file:
    temp = line.split()
    if temp[0] != '0':
        pass
    else:
        plaintext = eval("0x%s"%temp[1])
        key = eval("0x%s"%temp[2])
        input.append([str(bin(plaintext)).replace("0b", ""), str(bin(key)).replace("0b", "")])

with open("input.txt", "w") as output:
    for item in input:
        output.write(item[0])
        output.write(item[1])
        output.write('\n')