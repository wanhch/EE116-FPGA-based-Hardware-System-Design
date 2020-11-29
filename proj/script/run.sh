#!/bin/bash
cd script
ghdl -a --ieee=synopsys --std=08 ../src/util_package.vhd

ls ../src/ | while read src_file
do
    if [ "$src_file" != util_package.vhd ]; then
        ghdl -a --ieee=synopsys --std=08 "../src/$src_file"
    fi
done

cp ../sim/testbench.vhd testbench.vhd
ghdl -a --ieee=synopsys --std=08 testbench.vhd
ghdl -e --ieee=synopsys --std=08 testbench
ghdl -r --ieee=synopsys --std=08 testbench --ieee-asserts=disable --stop-time=10000us 2>&1 | grep -v "simulation finished @*"
python3 result.py