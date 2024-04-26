nextflow run ../sangro/main.nf \
  --input metadata.csv \
  --publish_dir test_run/ \
  --masking_threshold 0.4 \
  -profile local, eight \
  --mask-data true \
 # -resume
