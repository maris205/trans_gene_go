#!/bin/sh
for ((i=1;i<6;i++))
do
    echo $i
    #step 1, filter dict
    ./get_word protein.fa.count.${i}

    #step 2, get prob
    ./get_prob protein.fa.lm.${i}  protein.fa.count.${i}.dict ${i} > protein.dict.${i}

    #step 3, filter 
    ./mi_filter.py protein.dict.${i} > protein.dict.${i}.mi
done
