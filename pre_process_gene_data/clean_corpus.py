#!/usr/bin/env python
#coding=utf-8
import sys

if __name__=="__main__":
    if len(sys.argv) != 3:
        print "please input go and dna filename"
        sys.exit()

    go_file = open(sys.argv[1], "r")
    gene_file = open(sys.argv[2], "r")

    go_file_out = open(sys.argv[1] + ".filter","w")
    gene_file_out = open(sys.argv[2] + ".filter","w")

    go_data = go_file.readlines()
    gene_data = gene_file.readlines()
    
    for i in range(0,len(go_data)):
        go_length = len(go_data[i].split(" "))
        gene_length = len(gene_data[i].split(" "))
        if float(go_length)/gene_length >= 0.1 and float(go_length)/gene_length<=9 \
                and gene_length>=2:
            go_file_out.write(go_data[i])
            gene_file_out.write(gene_data[i])
