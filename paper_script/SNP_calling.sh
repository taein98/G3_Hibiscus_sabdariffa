#! /usr/bin/bash
wd=/home/taein/Denovo/Workings/jk_script/hibiscus
dir=$wd/working/results_hibiscus_opt_0.54

REF1=hibiscus.genome.h1.fa
REF2=hibiscus.genome.h2.fa
REF3=hibiscus.genome.fa

HIFI=/home/taein/Denovo/Workings/hibiscus/working/m64238e_220926_023509.hifi_reads.fq.gz  # 꼭 fastq파일을 써야함 SNP 확인하기 위해 quality 정보를 사용하기 때문에

ulimit -u 10000     # limit the number of opened file
BIN_VERSION="1.5.0"


INPUT_DIR=$dir
OUTPUT_DIR=$wd/working

cd $dir

samtools faidx $dir/$REF3
minimap2 -a -x map-hifi -t 100 $dir/$REF3 $HIFI | samtools sort -m4G -@100 -O BAM -o HiFi.raw.bam  # map hifisequence to genome to produce bam file
samtools index HiFi.raw.bam

sudo docker run --gpus 0 \
  -v "${INPUT_DIR}":"/input" \
  -v "${OUTPUT_DIR}":"/output" \
  google/deepvariant:"${BIN_VERSION}-gpu" \
  /opt/deepvariant/bin/run_deepvariant \
  --model_type=PACBIO \
  --ref /input/$REF3 \
  --reads /input/HiFi.raw.bam \
  --output_vcf /output/HiFi.vcf.gz \
  --num_shards=100

cp -r $wd/working/HiFi.vcf.gz $wd/working/h1_HiFi.vcf.gz $wd/working/h2_HiFi.vcf.gz $wd/results


# samtools faidx $dir/$REF1
# minimap2 -a -x map-hifi -t 120 $dir/$REF1 $HIFI | samtools sort -m4G -@100 -O BAM -o HiFi_h1.raw.bam  # map hifisequence to genome to produce bam file
# samtools index HiFi_h1.raw.bam


# sudo docker run --gpus 0 \
#   -v "${INPUT_DIR}":"/input" \
#   -v "${OUTPUT_DIR}":"/output" \
#   google/deepvariant:"${BIN_VERSION}-gpu" \
#   /opt/deepvariant/bin/run_deepvariant \
#   --model_type=PACBIO \
#   --ref /input/$REF1 \
#   --reads /input/HiFi_h1.raw.bam \
#   --output_vcf /output/h1_HiFi.vcf.gz \
#   --num_shards=120


# samtools faidx $dir/$REF2
# minimap2 -a -x map-hifi -t 120 $dir/$REF1 $HIFI | samtools sort -m4G -@100 -O BAM -o HiFi_h2.raw.bam  # map hifisequence to genome to produce bam file
# samtools index HiFi_h2.raw.bam


# sudo docker run --gpus 0 \
#   -v "${INPUT_DIR}":"/input" \
#   -v "${OUTPUT_DIR}":"/output" \
#   google/deepvariant:"${BIN_VERSION}-gpu" \
#   /opt/deepvariant/bin/run_deepvariant \
#   --model_type=PACBIO \
#   --ref /input/$REF2 \
#   --reads /input/HiFi_h2.raw.bam \
#   --output_vcf /output/h2_HiFi.vcf.gz \
#   --num_shards=120

