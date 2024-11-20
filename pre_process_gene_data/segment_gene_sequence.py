#!/usr/bin/env python
#coding=utf-8
import dna_segment
import sys
reload(sys)
sys.setdefaultencoding('utf-8')

if __name__=="__main__":
    if len(sys.argv)!=3:
        print "please input data filename and dict file name"
        sys.exit()

    filename = sys.argv[1]
    data_file = open(filename,'r')

    myseg = dna_segment.DNASegment()
    myseg.initial_dict(sys.argv[2])
    for line in data_file:
        line = line.strip()

        d_token_list = myseg.mp_seg(line).split(" ")
        useful_list = []
        for item in d_token_list:
            if (len(item))>0:
                useful_list.append(item)
        print " ".join(useful_list)
