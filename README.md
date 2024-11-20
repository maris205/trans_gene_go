# Translate gene sequence into gene ontology
Translate gene sequence into gene ontology terms based on statistical machine translation

for previous paper:
https://f1000research.com/articles/2-231

Origin link:
https://code.google.com/archive/p/dnasearchengine/downloads

some file large than 25M could download from this link
(gene_translation.zip)

## Directory list:

1. “data”: parallel corpus for Gene ontology sequence and corresponding amino acid sequence.

2. “code”: codes and directions for building translation model.

3. “get_gene_data”: direction for downloading data from geneontology.org(Gene ontology data) and uniprot.org(amino acid sequence data)

4. “pre_process_gene_data”: convert the format of original Gene ontology data and amino sequence data to the required format of Mose system.

5. “build_dict”: direction for building amino acid dictionary.

## 1 Directory “/data”, parallel corpus
human.pr: human protein sequence (amino acid form) for training, which has been segmented (set maximal word length as 7, same for other gene corpus)

human.go : human gene function description in Gene ontology terms, for training

human.pr.test : human amino acid sequence (amino acid form) for test, has been segmented

human.go.test : human gene function description in Gene ontology terms, for test

mixed.pr : mixed amino acid sequence (amino acid form) for training

mixed.go : mixed gene function description in Gene ontology terms, for training

mixed.pr.test : mixed amino acid sequence (amino acid form) for test, has been segmented

mixed.go.test : mixed gene function description in Gene ontology terms, for test

big.pr : big amino acid sequence (amino acid form) for training

big.go : big gene function description in Gene ontology terms, for training

big.pr.test : big amino acid sequence (amino acid form) for test, has been segmented

big.go.test : big gene function description in Gene ontology terms, for test

## 2 Directory “/code”
It contains the source and example to train the gene translation model, we use the mixed data set to train the translation model, include:

readme.txt: direction about how to train the model

Content in readme:

2.1 System requirement
(1) You need install Moses system. http://www.statmt.org/moses/?n=Development.GetStarted

(2) You’d better run the baseline of Moses. http://www.statmt.org/moses/?n=Moses.Baseline

(3) Python 2.7.

Here we use irstlm to train language model, as this baseline suggest.

2.2 Parallel corpus
for train:

gene.6.pr : amino acid sequence, have been segmented, maximal word length 6

gene.6.go: gene ontology sequence

for test:

gene.6.pr.test: amino acid sequence

gene.6.go.test: gene ontology sequence

2.3 Train language model of target sequence, here we train gene ontology model
file: train_lm.sh

(attention: please revise the moses_path and irstml_path to your own path!)

run:

./train_lm.sh gene.6.go

You will get gene.6.go.blm.

2.4 Train translation model
File: train_ts.sh

(attention: please revise the moses_path and giza_path to your path!)

run:

./train_ts.sh gene.6 gene.6.go.blm

Wait about 4 hours (1 CPU. 10+G memory requirement)

you will get a "train" directory.

the train/model/moses.ini is just your translation model file

2.5 Test
File: get_bleu.sh

(please revise the moses_path)

run:

./get_bleu.sh gene.6.go.test gene.6.pr.test

it will translate gene.6.pr.test and then compare it with gene.6.go.test. If there is no error, you will get the result:

BLEU = 26.38, 47.4/30.0/21.4/15.9 (BP=1.000, ratio=1.571, hyp_len=48369, ref_len=30786)

Because we don't consider the order of go terms, 47.4 is just its BLEU score (unigram). Here we didn’t run the tuning process. You could divide the test corpuses into test part and tuning part, and then run the tuning process. It could bring some improvement for BLEU score, but it may take several days.

## 3 Directory “/get_gene_data”, get gene data
If you want build your own corpus from original database source (www.geneontology.org, Gene ontology data. www.uniprot.org, amino acid sequence data), see this section:

3.1 Get gene data
Here we will show how to get corpus from original data source. You need install gunzip.

Using human data:

File: get_gene_data.sh, its operation

(1). get original gene ontology data. (ftp of www.geneontology.org).

(2). get amino acid sequence data. (ftp of ftp.uniprot.org).

(3). gunzip

(4). convert amino acid sequence format. (get_gene.py)

(5). convert gene ontology format. (get_go.py)

(6). Get parallel corpus according to gene database id. (get_corpus.py)

just run ./get_gene_data.sh

We will get parallel corpus

human.pr.filter gene sequence

human.go.filter corresponding gene ontology sequence

This corpus contain about 1,8000 data.

You could also download the big corpus:

Gene ontology files (UniProt [multispecies]):

http://www.geneontology.org/gene-associations/submission/gene_association.goa_uniprot.gz

contain about 40 million data.

Related sequence data could be found at:

UniProtKB/Swiss-Prot,

ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot.fasta.gz

UniProtKB/TrEMBL,

ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_trembl.fasta.gz

You could download these two files then merge (normally Linux shell ‘cat’ command) them together. Then revise the ./get_gene_data.sh. (refer to get_big_gene_data.sh). Finally, you could get about 20 million parallel corpus.

## 4 Directory: "pre_process_gene_data", segment amino acid sequence and clean the corpus
If you want to build your own corpus, you will need segment the amino acid sequence and clean the corpus.

4.1 Data files
(1) mix.go original gene ontology sequence

(2) mix.pr original amino acid sequence

(Here we give these data. You could also copy the human.pr.filter in previous to mix.go, and human.go.filter to mix.go to run your own experiment, also for the big data set)

(3) protein.dict dict file

4.2 Preprocess the file, get the parallel corpus
File : pre_process.sh

just run:

./pre_process.h

Its operation:

step 1: segment the amino acid sequence. (segment_gene_sequence.py)

step 2: clean the corpus.( clean_corpus.py)

step 3: divide the corpus into train and test parts.( divide_corpus.py)

finally, you will get 4 files

gene.pr : amino acid sequence, have been segmented, maximal word length 6

gene.go: gene ontology sequence

gene.pr.test: amino acid sequence for test

gene.go.test: gene ontology sequence for test

These files could be used to train the translation model.

## 5 Directory "build_dict", build amino acid dictionary
Moreover, if you want to build your own “protein.dict” for different maximal word length, we also give an example:

Step 1, install SRILM

A simple method to build dictionary is to use language model. Here use SRILM. You should install it first. (http://www.speech.sri.com/projects/srilm/)

Then cp the executable file “ngram-count” to this directory. Normally in your install dir. There have been an “ngram-count”, but it could only run in a special Linux version, so just overwrite it.

Step 2, you should make 2 file

(1) In ./get_gene_word: run make

(2) In ./get_gene_word_prob: you should set the srilm install path and MACHINE_TYPE in Makefile, then run make.

Step 3, uncompress the data file

Run: tar -xzvf protein.fa.tar.gz

Step 4, train n-gram language model, n=1–5

Run: ./build_all_lm_model.sh

(Attention, you must cp “ngram-count” to this directory. See step1)

Step 5, Build dictionary with different maximal word length

Run: ./build_dict_all.sh

Its operations:

(1) Get all possible gene word, filter them by frequency. (get_word)

(2) Get probability of all gene words. (get_prob)

(3) Filter the gene words in dictionary by MI method. (mi_filter.py)

Finally, you will get protein.dict.*.mi, (* is 1,2,…,5) is the dictionary with maximal word length *. Then you could use these dictionary file to segment the amino acid sequence (in section 3).

If you have map/reduce cluster, you could use EM method to build the gene word. See our open source project (https://code.google.com/p/dnasearchengine/). To train an 8 maximal word length dictionary, you need at least 4G amino acid sequence data. More amino acid sequence could be found in “Get gene data” section or ftp of gene Refseq databases. ftp://ftp.ncbi.nih.gov/refseq/.
