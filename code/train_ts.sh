#!/bin/sh
#train translation system
if [ $# -ne 2 ]
then
    echo "please input train corpus prefix and language model file"
    exit
fi
set -x

corpus=$1
lm=$2

#please set your own moses install path!
moses_path=/data4/mariswang/trans/moses

#please set your own giza-pp install path!
giza_path=/data4/mariswang/trans/giza-pp

cur_path=`pwd`

if [ -d train ]
then
    rm -r train
fi

nohup ${moses_path}/scripts/training/train-model.perl  -root-dir train \
    -corpus ${cur_path}/${corpus} \
    -f pr -e go -alignment grow-diag-final-and -reordering \
    msd-bidirectional-fe  -lm 0:2:${cur_path}/${lm}:8  \
    -external-bin-dir ${giza_path}  >  training.out & 
