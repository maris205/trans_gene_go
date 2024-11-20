#!/bin/sh
if [ $# -ne 1 ]
then
    echo "please input data file name"
    exit
fi


#please set your own moses install path!
moses_path=/data4/mariswang/trans/moses

#please set your own irstlm install path!
irstml_path=/data4/mariswang/trans/irstlm/

filename=$1

#step 1,add start and end
${irstml_path}/bin/add-start-end.sh < ${filename} > ${filename}.se

#step 2,build lm
export IRSTLM=${irstml_path}
${irstml_path}/bin/build-lm.sh -i ${filename}.se  -n 2 -t ./tmp  -p -s improved-kneser-ney  -o ${filename}.lm

#step 3, compile lm
${irstml_path}/bin/compile-lm --text  ${filename}.lm.gz ${filename}.arpa

#step 4, export binary lm
${moses_path}/bin/build_binary ${filename}.arpa ${filename}.blm
