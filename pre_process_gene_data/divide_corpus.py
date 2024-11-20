#!/usr/bin/env python
#coding=utf-8
import sys
import random
#get train and test set

if __name__=="__main__":
    if len(sys.argv) != 3:
        print "please input go and dna filename"
        sys.exit()

    go_file = open(sys.argv[1], "r")
    gene_file = open(sys.argv[2], "r")

    go_train_file = open(sys.argv[1] + ".train","w")
    go_test_file = open(sys.argv[1] + ".test","w")
    
    gene_train_file = open(sys.argv[2] + ".train","w")
    gene_test_file = open(sys.argv[2] + ".test","w")
    
    go_data = go_file.readlines()
    gene_data = gene_file.readlines()
    
    #construct random set
    line_num = len(go_data)
    test_set_num = int(0.05*line_num)
    rand_index = set()
    for i in range(0,5*test_set_num):
        rand_int = random.randint(0, line_num-1)
        rand_index.add(rand_int)
        if len(rand_index)==test_set_num:
            break

    for i in range(0,line_num):
        if i not in rand_index:
            go_train_file.write(go_data[i])
            gene_train_file.write(gene_data[i])
        else:
            go_test_file.write(go_data[i])
            gene_test_file.write(gene_data[i])
