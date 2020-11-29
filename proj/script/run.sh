#!/bin/bash

ghdl -a --ieee=synopsys --std=08 ../src/util_package.vhd

ls ../src/ | while read src_file
do
    if [ "$src_file" != util_package.vhd ]; then
        ghdl -a --ieee=synopsys --std=08 "../src/$src_file"
    fi
done

echo -n "" > score.txt
for idx in $(seq 0 1 `expr ${#MAT_A_ROWS_VALUE_array[*]} - 1`)
do
    
    if [[ ${FUNCTION_CONFIG:$idx:1} -eq '1' ]]; then
        for INPUT_WIDTH_VALUE in ${INPUT_WIDTH_VALUE_array[*]}
        do
            for seed_idx in $(seq 0 1 `expr ${#RAND_SEED_A_VALUE_array[*]} - 1`)
            do
                for SAMPLE_NUM_VALUE in ${SAMPLE_NUM_VALUE_array[*]}
                do
                    cp ../../sim/test_systolic.vhd.template test_systolic.vhd


                    cp ./gen_testcase.vhd.template gen_testcase.vhd


                    echo -n "" > testcase.txt
                    echo -n "" > result.txt
                    echo -n "" > output.txt

                    ghdl -a --ieee=synopsys --std=08 test_systolic.vhd
                    ghdl -e --ieee=synopsys --std=08 test_systolic
                    ghdl -r --ieee=synopsys --std=08 test_systolic --ieee-asserts=disable --stop-time=90us 2>&1 | grep -v "simulation finished @*"

                    ./deal_result.py ${MAT_A_ROWS_VALUE} ${MAT_B_COLS_VALUE}
                done
            done
        done
    else
        echo "skip test and continue"
        for group_idx in $(seq 0 1 `expr $GROUP_SIZE - 1`)
        do
            echo -n "0" >> ./score.txt
        done
    fi

    TOTAL_RES=`tail -c $FINISHED_GROUP ./score.txt`
    GROUP_RES=`tail -c $GROUP_SIZE ./score.txt`
    FINISHED_GROUP=`expr $FINISHED_GROUP + $GROUP_SIZE`
done