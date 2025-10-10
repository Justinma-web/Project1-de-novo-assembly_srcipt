#!/bin/bash
#Summary of all strategies' script in this project. 

# De-novo-assembly_1
Strategy 1: runDRAP separately -> merge all assemblies

# De-novo-assembly_2
Strategy 2: merge all sequences -> runDRAP

# De-novo-assembly_3
Strategy 3: merge skin sequences &amp; merge brain sequences -> runDRAP separately -> merge 2 assembles

# Path of files
# transcriptome using Strategy 1 to assemble: 
/home/jade/1_sandsmelt/rundrap/out_drap_s1/meta_BR/d-cov_filter/transcripts_fpkm_0.fa
/home/jade/1_sandsmelt/rundrap/out_drap_s1/meta_BR/d-cov_filter/transcripts_fpkm_1.fa
# corset clustered transcriptome using Strategy 1 to assemble: 



# Strategy 1 raw sequence
/home/jade/1_sandsmelt/rundrap/out_drap_s1/*/uf*_1.norm.fq.gz
/home/jade/1_sandsmelt/rundrap/out_drap_s1/*/uf*_2.norm.fq.gz

# transcriptome using Strategy 2 to assemble: 
/home/jade/1_sandsmelt/rundrap/out_drap_s2/transcripts_fpkm_0.fa
/home/jade/1_sandsmelt/rundrap/out_drap_s2/transcripts_fpkm_0.5.fa
/home/jade/1_sandsmelt/rundrap/out_drap_s2/transcripts_fpkm_1.fa
# corset clustered transcriptome using Strategy 2 to assemble: 
/home/jade/1_sandsmelt/rundrap/out_drap_s2/cluster_0_s2.fa
/home/jade/1_sandsmelt/rundrap/out_drap_s2/cluster_0.5_s2.fa

# Strategy 2 raw sequence
/home/jade/1_sandsmelt/rundrap/out_drap_s2/merged_1.norm.fq.gz
/home/jade/1_sandsmelt/rundrap/out_drap_s2/merged_2.norm.fq.gz

# transcriptome using Strategy 3 to assemble: 
/home/jade/1_sandsmelt/rundrap/meta_s3/transcripts_fpkm_0.fa
/home/jade/1_sandsmelt/rundrap/meta_s3/transcripts_fpkm_0.5.fa
/home/jade/1_sandsmelt/rundrap/meta_s3/transcripts_fpkm_1.fa
# corset clustered transcriptome using Strategy 3 to assemble: 
/home/jade/1_sandsmelt/rundrap/meta_s3/cluster_0_s3.fa
/home/jade/1_sandsmelt/rundrap/meta_s3/cluster_0.5_s3.fa

# Strategy 3 raw sequence
/home/jade/1_sandsmelt/rundrap/out_drap_s3*/merged_*_1.norm.fq.gz
/home/jade/1_sandsmelt/rundrap/out_drap_s3*/merged_*_2.norm.fq.gz
