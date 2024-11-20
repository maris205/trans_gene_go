#!/bin/sh
for ((i=1;i<6;i++))
do
    echo "process " $i " language model"
    ./build_lm_model.sh $i
done
