#!/bin/sh
set -x

#dict file
dict_file=protein.dict

ori_pr_file=mix.pr
ori_go_file=mix.go

target_file=gene

#step 1, segment the pr file
./segment_gene_sequence.py $ori_pr_file $dict_file > ${ori_pr_file}.seg

#step 2, clean corpus
./clean_corpus.py ${ori_go_file} ${ori_pr_file}.seg

#step 3, divide file into train and test set
./divide_corpus.py.py ${ori_go_file}.filter ${ori_pr_file}.seg.filter

#step 4, copy file
cp ${ori_go_file}.filter.train ${target_file}.go
cp ${ori_pr_file}.seg.filter.train ${target_file}.pr

cp ${ori_go_file}.filter.test ${target_file}.go.test
cp ${ori_pr_file}.seg.filter.test ${target_file}.pr.test

#step 5, rm temp file
rm ${ori_go_file}.*
rm ${ori_pr_file}.*
