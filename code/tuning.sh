#!/bin/sh
if [ $# -ne 2 ]
then
    echo "please input gene corpus file name and related reference go file name"
fi

export LC_ALL=POSIX

#please set your own moses install path!
moses_path=/data4/mariswang/trans/moses

ori_corpus=$1
tar_corpus=$2

nohup nice ${moses_path}/scripts/training/mert-moses.pl \
    ${ori_corpus} ${tar_corpus} /data7/mariswang/trans/mose/mosesdecoder-master/bin/moses \
    ./train/model/moses.ini --mertdir \
    ${moses_path}/bin/ \
    --decoder-flags="-threads 2" &> mert.out &
