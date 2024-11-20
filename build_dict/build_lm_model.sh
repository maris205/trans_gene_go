#!/bin/sh
if [ $# -ne 1 ]
then
    echo "please input lm order"
    exit
fi
order=$1

./ngram-count -text protein.fa -order ${order} -write protein.fa.count.${order}  -no-sos  -no-eos
./ngram-count -read protein.fa.count.${order}  -order ${order} -lm protein.fa.lm.${order}
