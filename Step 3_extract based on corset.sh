#!/usr/bin/env bash
set -euo pipefail
trap 'echo "[ERROR] Extract step failed at line $LINENO: $BASH_COMMAND"' ERR

S1_BASE="/home/jade/1_sandsmelt/rundrap/out_drap_s1"
S2_BASE="/home/jade/1_sandsmelt/rundrap/out_drap_s2"
S3_BASE="/home/jade/1_sandsmelt/rundrap/meta_s3"

TX_INFO="transcripts_fpkm0_s1 $S1_BASE/meta_BR/d-cov_filter/transcripts_fpkm_0.fa
transcripts_fpkm1_s1 $S1_BASE/meta_BR/d-cov_filter/transcripts_fpkm_1.fa
transcripts_fpkm0_s2 $S2_BASE/transcripts_fpkm_0.fa
transcripts_fpkm0.5_s2 $S2_BASE/transcripts_fpkm_0.5.fa
transcripts_fpkm0_s3 $S3_BASE/transcripts_fpkm_0.fa
transcripts_fpkm0.5_s3 $S3_BASE/transcripts_fpkm_0.5.fa
transcripts_fpkm1_s3 $S3_BASE/transcripts_fpkm_1.fa"

printf "%s\n" "$TX_INFO" | while read NAME FASTA; do
  [ -z "$NAME" ] && continue
  CLUSTERS="corset_${NAME}-clusters.txt"
  OUTFA="$(dirname "$FASTA")/cluster_${NAME}.fa"
  if [ -s "$CLUSTERS" ]; then
    python3 /home/jade/Corset-tools/fetchClusterSeqs.py -i "$FASTA" -c "$CLUSTERS" -o "$OUTFA" -l
  else
    echo "[SKIP] No clusters file for $NAME"
  fi
done
