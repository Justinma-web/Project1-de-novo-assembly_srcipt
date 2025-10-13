#!/bin/bash
#Summary of all strategies' script in this project. 

# De-novo-assembly_1
Strategy 1: runDRAP separately -> merge all assemblies

# De-novo-assembly_2
Strategy 2: merge all sequences -> runDRAP

# De-novo-assembly_3
Strategy 3: merge skin sequences &amp; merge brain sequences -> runDRAP separately -> merge 2 assembles

# Path of files
##### strategy 1 #####
# transcriptome using Strategy 1 to assemble: 
/home/jade/1_sandsmelt/rundrap/out_drap_s1/meta_BR/d-cov_filter/transcripts_fpkm_0.fa
/home/jade/1_sandsmelt/rundrap/out_drap_s1/meta_BR/d-cov_filter/transcripts_fpkm_1.fa
# corset clustered transcriptome using Strategy 1 to assemble: 
xxxx
xxxx
xxxx

# Strategy 1 raw sequence
##R1 & R2 ###
/home/jade/1_sandsmelt/rundrap/out_drap_s1/*/*/*/uf*_1.norm.fq.gz
/home/jade/1_sandsmelt/rundrap/out_drap_s1/*/*/*/uf*_2.norm.fq.gz
## 4 GROUP FORMAT: lone brain, lone skin, school brain, school skin ##
## school brain
/home/jade/1_sandsmelt/rundrap/out_drap_s1/school/school_brain/*/uf*_1.norm.fq.gz
/home/jade/1_sandsmelt/rundrap/out_drap_s1/school/school_brain/*/uf*_2.norm.fq.gz
## school skin
/home/jade/1_sandsmelt/rundrap/out_drap_s1/school/school_skin/*/uf*_1.norm.fq.gz
/home/jade/1_sandsmelt/rundrap/out_drap_s1/school/school_skin/*/uf*_2.norm.fq.gz
## lone skin
/home/jade/1_sandsmelt/rundrap/out_drap_s1/lone/lone_skin/*/uf*_1.norm.fq.gz
/home/jade/1_sandsmelt/rundrap/out_drap_s1/lone/lone_skin/*/uf*_2.norm.fq.gz
## lone brain
/home/jade/1_sandsmelt/rundrap/out_drap_s1/lone/lone_brain/*/uf*_1.norm.fq.gz
/home/jade/1_sandsmelt/rundrap/out_drap_s1/lone/lone_brain/*/uf*_2.norm.fq.gz
##### strategy 1 #####

##### strategy 2 #####
# transcriptome using Strategy 2 to assemble: 
/home/jade/1_sandsmelt/rundrap/out_drap_s2/transcripts_fpkm_0.fa
/home/jade/1_sandsmelt/rundrap/out_drap_s2/transcripts_fpkm_0.5.fa
/home/jade/1_sandsmelt/rundrap/out_drap_s2/transcripts_fpkm_1.fa
# corset clustered transcriptome using Strategy 2 to assemble: 
xxxx
xxxx

# Strategy 2 raw sequence (No need for following steps)
/home/jade/1_sandsmelt/rundrap/out_drap_s2/merged_1.norm.fq.gz
/home/jade/1_sandsmelt/rundrap/out_drap_s2/merged_2.norm.fq.gz
##### strategy 2 #####

##### strategy 3 #####
# transcriptome using Strategy 3 to assemble: 
/home/jade/1_sandsmelt/rundrap/meta_s3/transcripts_fpkm_0.fa
/home/jade/1_sandsmelt/rundrap/meta_s3/transcripts_fpkm_0.5.fa
/home/jade/1_sandsmelt/rundrap/meta_s3/transcripts_fpkm_1.fa
# corset clustered transcriptome using Strategy 3 to assemble: 
xxxx
xxxx
xxxx

# Strategy 3 raw sequence (No need for following steps)
/home/jade/1_sandsmelt/rundrap/out_drap_s3*/merged_*_1.norm.fq.gz
/home/jade/1_sandsmelt/rundrap/out_drap_s3*/merged_*_2.norm.fq.gz
##### strategy 3 #####
