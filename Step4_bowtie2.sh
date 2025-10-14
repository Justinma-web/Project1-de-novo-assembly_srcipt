#!/usr/bin/env bash
set -euo pipefail
trap 'echo "[ERROR] Bowtie2 step failed at line $LINENO: $BASH_COMMAND"' ERR

# --- Configuration ---
S1_BASE="/home/jade/1_sandsmelt/rundrap/out_drap_s1"
S2_BASE="/home/jade/1_sandsmelt/rundrap/out_drap_s2"
S3_BASE="/home/jade/1_sandsmelt/rundrap/meta_s3"
READS_DIR="$S1_BASE"

BWT2_INDEX_BASE="/home/jade/1_sandsmelt/rundrap/bowtie2_indexes"
BWT2_MAP_BASE="/home/jade/1_sandsmelt/rundrap/mapping_results"
BOWTIE2_THREADS=20

mkdir -p "$BWT2_INDEX_BASE" "$BWT2_MAP_BASE"

# Transcriptomes list (same as earlier steps)
TX_INFO="transcripts_fpkm0_s1 $S1_BASE/meta_BR/d-cov_filter/transcripts_fpkm_0.fa
transcripts_fpkm1_s1 $S1_BASE/meta_BR/d-cov_filter/transcripts_fpkm_1.fa
transcripts_fpkm0_s2 $S2_BASE/transcripts_fpkm_0.fa
transcripts_fpkm0.5_s2 $S2_BASE/transcripts_fpkm_0.5.fa
transcripts_fpkm0_s3 $S3_BASE/transcripts_fpkm_0.fa
transcripts_fpkm0.5_s3 $S3_BASE/transcripts_fpkm_0.5.fa
transcripts_fpkm1_s3 $S3_BASE/transcripts_fpkm_1.fa"

echo "[STEP 4A] Building Bowtie2 indexes for clustered FASTAs"
printf "%s\n" "$TX_INFO" | while read NAME FASTA; do
  [ -z "$NAME" ] && continue
  CLUSTFA="$(dirname "$FASTA")/cluster_${NAME}.fa"
  if [ ! -s "$CLUSTFA" ]; then
    echo "  [SKIP] Missing clustered FASTA: $CLUSTFA"
    continue
  fi
  IDX_DIR="$BWT2_INDEX_BASE/$NAME"
  mkdir -p "$IDX_DIR"
  echo "  [BUILD] Index for $NAME"
  bowtie2-build "$CLUSTFA" "$IDX_DIR/$NAME"
done
echo "[STEP 4A DONE] Index building complete."

echo "[STEP 4B] Mapping reads to clustered transcriptomes"
printf "%s\n" "$TX_INFO" | while read NAME FASTA; do
  [ -z "$NAME" ] && continue
  CLUSTFA="$(dirname "$FASTA")/cluster_${NAME}.fa"
  if [ ! -s "$CLUSTFA" ]; then
    echo "  [SKIP] No clustered FASTA for $NAME"
    continue
  fi
  IDX_DIR="$BWT2_INDEX_BASE/$NAME"
  OUTDIR="$BWT2_MAP_BASE/$NAME"
  mkdir -p "$OUTDIR"

  echo "  [MAP] Target=$NAME"
  find "$READS_DIR" -type f -name "*_1.norm.fq.gz" | while read R1; do
    [ -s "$R1" ] || continue
    R2="${R1/_1.norm.fq.gz/_2.norm.fq.gz}"
    SAMPLE=$(basename "$R1" _1.norm.fq.gz)
    echo "    [RUN] $SAMPLE -> $NAME"
    bowtie2 -x "$IDX_DIR/$NAME" \
      -1 "$R1" -2 "$R2" \
      -q -p "$BOWTIE2_THREADS" \
      --sensitive --no-discordant --no-mixed \
      1>/dev/null \
      2>"$OUTDIR/${SAMPLE}_bowtie2.txt"
  done
done
echo "[STEP 4B DONE] Bowtie2 mapping complete."
