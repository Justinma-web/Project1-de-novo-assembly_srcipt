#!/usr/bin/env bash
set -euo pipefail
trap 'echo "[ERROR] Salmon step failed at line $LINENO: $BASH_COMMAND"' ERR

# --- Configuration ---
S1_BASE="/home/jade/1_sandsmelt/rundrap/out_drap_s1"
S2_BASE="/home/jade/1_sandsmelt/rundrap/out_drap_s2"
S3_BASE="/home/jade/1_sandsmelt/rundrap/meta_s3"
SALMON_THREADS=20
SALMON_INDEX_BASE="$S1_BASE"
SALMON_QUANT_BASE="$S1_BASE/salmon_quant"
READS_DIR="$S1_BASE"

mkdir -p "$SALMON_QUANT_BASE"

TX_INFO="transcripts_fpkm0_s1 $S1_BASE/meta_BR/d-cov_filter/transcripts_fpkm_0.fa
transcripts_fpkm1_s1 $S1_BASE/meta_BR/d-cov_filter/transcripts_fpkm_1.fa
transcripts_fpkm0_s2 $S2_BASE/transcripts_fpkm_0.fa
transcripts_fpkm0.5_s2 $S2_BASE/transcripts_fpkm_0.5.fa
transcripts_fpkm0_s3 $S3_BASE/transcripts_fpkm_0.fa
transcripts_fpkm0.5_s3 $S3_BASE/transcripts_fpkm_0.5.fa
transcripts_fpkm1_s3 $S3_BASE/transcripts_fpkm_1.fa"

echo "[STEP 1A] Salmon indexing"
printf "%s\n" "$TX_INFO" | while read NAME FASTA; do
  [ -z "$NAME" ] && continue
  IDX="$SALMON_INDEX_BASE/salmon_index_${NAME}"
  if [ -s "$IDX/hash.bin" ]; then
    echo "  [SKIP] Index exists for $NAME"
  else
    mkdir -p "$IDX"
    salmon index --threads "$SALMON_THREADS" --index "$IDX" --transcripts "$FASTA"
  fi
done

echo "[STEP 1B] Salmon quantification"
find "$READS_DIR" -type f -name "*_1.norm.fq.gz" | while read R1; do
  [ -s "$R1" ] || continue
  R2="${R1/_1.norm.fq.gz/_2.norm.fq.gz}"
  SAMPLE=$(basename "$R1" _1.norm.fq.gz)
  printf "%s\n" "$TX_INFO" | while read NAME FASTA; do
    [ -z "$NAME" ] && continue
    IDX="$SALMON_INDEX_BASE/salmon_index_${NAME}"
    OUT="$SALMON_QUANT_BASE/$NAME/$SAMPLE"
    if [ -f "$OUT/aux_info/eq_classes.txt.gz" ]; then
      echo "  [SKIP] $NAME already quantified for $SAMPLE"
      continue
    fi
    mkdir -p "$OUT"
    salmon quant --threads "$SALMON_THREADS" --index "$IDX" --libType A \
      --dumpEq --hardFilter --skipQuant \
      -1 "$R1" -2 "$R2" \
      --output "$OUT"
    [ -f "$OUT/aux_info/eq_classes.txt.gz" ] && gunzip -c "$OUT/aux_info/eq_classes.txt.gz" > "$OUT/aux_info/eq_classes.txt"
  done
done
