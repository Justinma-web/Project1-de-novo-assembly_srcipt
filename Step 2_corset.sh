#!/usr/bin/env bash
set -euo pipefail
trap 'echo "[ERROR] Corset step failed at line $LINENO: $BASH_COMMAND"' ERR

S1_BASE="/home/jade/1_sandsmelt/rundrap/out_drap_s1"
S2_BASE="/home/jade/1_sandsmelt/rundrap/out_drap_s2"
S3_BASE="/home/jade/1_sandsmelt/rundrap/meta_s3"
SALMON_QUANT_BASE="$S1_BASE/salmon_quant"

TX_INFO="transcripts_fpkm0_s1 $S1_BASE/meta_BR/d-cov_filter/transcripts_fpkm_0.fa
transcripts_fpkm1_s1 $S1_BASE/meta_BR/d-cov_filter/transcripts_fpkm_1.fa
transcripts_fpkm0_s2 $S2_BASE/transcripts_fpkm_0.fa
transcripts_fpkm0.5_s2 $S2_BASE/transcripts_fpkm_0.5.fa
transcripts_fpkm0_s3 $S3_BASE/transcripts_fpkm_0.fa
transcripts_fpkm0.5_s3 $S3_BASE/transcripts_fpkm_0.5.fa
transcripts_fpkm1_s3 $S3_BASE/transcripts_fpkm_1.fa"

SAMPLES="2R 5R 6R 7R 8R 9R 10R 2B 5B 6B 7B 8B 9B 10B 11R 12R 13R 14R 16R 17R 18R 11B 12B 13B 14B 16B 17B 18B"
NAMES=$(printf "%s," $SAMPLES); NAMES=${NAMES%,}

GROUPS="1,1,1,1,1,1,1,2,2,2,2,2,2,2,3,3,3,3,3,3,3,4,4,4,4,4,4,4"

printf "%s\n" "$TX_INFO" | while read NAME FASTA; do
  [ -z "$NAME" ] && continue
  OUTPREFIX="corset_${NAME}"
  FILES=""
  for S in $SAMPLES; do
    FILES="$FILES $SALMON_QUANT_BASE/$NAME/$S/aux_info/eq_classes.txt"
  done
  echo "[RUN] Corset for $NAME"
  corset -i salmon_eq_classes -p "$OUTPREFIX" -n "$NAMES" -g "$GROUPS" $FILES &
done

# Wait for all backgrounded corset jobs to finish
wait
echo "[DONE] All Corset runs completed in parallel."
