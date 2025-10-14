#!/usr/bin/env bash
set -euo pipefail
trap 'echo "[ERROR] Corset step failed at line $LINENO: $BASH_COMMAND"' ERR

S1_BASE="/home/jade/1_sandsmelt/rundrap/out_drap_s1"
S2_BASE="/home/jade/1_sandsmelt/rundrap/out_drap_s2"
S3_BASE="/home/jade/1_sandsmelt/rundrap/meta_s3"
SALMON_QUANT_BASE="$S1_BASE/salmon_quant"

# Explicit sample names (comma‑separated, 28 total)
NAMES="2R,5R,6R,7R,8R,9R,10R,2B,5B,6B,7B,8B,9B,10B,11R,12R,13R,14R,16R,17R,18R,11B,12B,13B,14B,16B,17B,18B"

# Explicit group IDs (28 values: 7×1, 7×2, 7×3, 7×4)
GROUPS="1,1,1,1,1,1,1,2,2,2,2,2,2,2,3,3,3,3,3,3,3,4,4,4,4,4,4,4"

echo "[RUN] Corset for transcripts_fpkm0_s1"
corset -f true -i salmon_eq_classes -p corset_transcripts_fpkm0_s1 \
  -n 2R,5R,6R,7R,8R,9R,10R,2B,5B,6B,7B,8B,9B,10B,11R,12R,13R,14R,16R,17R,18R,11B,12B,13B,14B,16B,17B,18B \
  -g 1,1,1,1,1,1,1,2,2,2,2,2,2,2,3,3,3,3,3,3,3,4,4,4,4,4,4,4 \
  $SALMON_QUANT_BASE/transcripts_fpkm0_s1/*/aux_info/eq_classes.txt &

echo "[RUN] Corset for transcripts_fpkm1_s1"
corset -f true -i salmon_eq_classes -p corset_transcripts_fpkm1_s1 \
  -n "$NAMES" -g "$GROUPS" \
  $SALMON_QUANT_BASE/transcripts_fpkm1_s1/*/aux_info/eq_classes.txt &

echo "[RUN] Corset for transcripts_fpkm0_s2"
corset -f true -i salmon_eq_classes -p corset_transcripts_fpkm0_s2 \
  -n 2R,5R,6R,7R,8R,9R,10R,2B,5B,6B,7B,8B,9B,10B,11R,12R,13R,14R,16R,17R,18R,11B,12B,13B,14B,16B,17B,18B \
  -g 1,1,1,1,1,1,1,2,2,2,2,2,2,2,3,3,3,3,3,3,3,4,4,4,4,4,4,4 \
  $SALMON_QUANT_BASE/transcripts_fpkm0_s2/*/aux_info/eq_classes.txt &

echo "[RUN] Corset for transcripts_fpkm0.5_s2"
corset -f true -i salmon_eq_classes -p corset_transcripts_fpkm0.5_s2 \
  -n 2R,5R,6R,7R,8R,9R,10R,2B,5B,6B,7B,8B,9B,10B,11R,12R,13R,14R,16R,17R,18R,11B,12B,13B,14B,16B,17B,18B \
  -g 1,1,1,1,1,1,1,2,2,2,2,2,2,2,3,3,3,3,3,3,3,4,4,4,4,4,4,4 \
  $SALMON_QUANT_BASE/transcripts_fpkm0.5_s2/*/aux_info/eq_classes.txt &

echo "[RUN] Corset for transcripts_fpkm0_s3"
corset -f true -i salmon_eq_classes -p corset_transcripts_fpkm0_s3 \
  -n 2R,5R,6R,7R,8R,9R,10R,2B,5B,6B,7B,8B,9B,10B,11R,12R,13R,14R,16R,17R,18R,11B,12B,13B,14B,16B,17B,18B \
  -g 1,1,1,1,1,1,1,2,2,2,2,2,2,2,3,3,3,3,3,3,3,4,4,4,4,4,4,4 \
  $SALMON_QUANT_BASE/transcripts_fpkm0_s3/*/aux_info/eq_classes.txt &

echo "[RUN] Corset for transcripts_fpkm0.5_s3"
corset -f true -i salmon_eq_classes -p corset_transcripts_fpkm0.5_s3 \
  -n 2R,5R,6R,7R,8R,9R,10R,2B,5B,6B,7B,8B,9B,10B,11R,12R,13R,14R,16R,17R,18R,11B,12B,13B,14B,16B,17B,18B \
  -g 1,1,1,1,1,1,1,2,2,2,2,2,2,2,3,3,3,3,3,3,3,4,4,4,4,4,4,4 \
  $SALMON_QUANT_BASE/transcripts_fpkm0.5_s3/*/aux_info/eq_classes.txt &

echo "[RUN] Corset for transcripts_fpkm1_s3"
corset -f true -i salmon_eq_classes -p corset_transcripts_fpkm1_s3 \
  -n 2R,5R,6R,7R,8R,9R,10R,2B,5B,6B,7B,8B,9B,10B,11R,12R,13R,14R,16R,17R,18R,11B,12B,13B,14B,16B,17B,18B \
  -g 1,1,1,1,1,1,1,2,2,2,2,2,2,2,3,3,3,3,3,3,3,4,4,4,4,4,4,4 \
  $SALMON_QUANT_BASE/transcripts_fpkm1_s3/*/aux_info/eq_classes.txt &

# Wait for all backgrounded jobs
wait
echo "[DONE] All 7 Corset runs completed in parallel."
