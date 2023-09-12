#! /usr/bin/bash

HIFI=/home/taein/Denovo/Workings/hibiscus/working/m64238e_220926_023509.hifi_reads.fq.gz
wd=/home/taein/Denovo/Workings/jk_script/hibiscus
dir=$wd/working/results_hibiscus_opt_0.54
PREFIX=hibiscus.genome

# You should decide what haplotype would become ref or align 

ref_genome=$dir/strain-specific.softMasked/$PREFIX.h1.fa.masked.masked
align_genome=$dir/strain-specific.softMasked/$PREFIX.h2.fa.masked.masked

svim reads --cores 120 --aligner minimap2 $$wd/working $HIFI $align_genome

minimap2 -a -x asm5 --cs -r2k -t 120 $ref_genome $align_genome | samtools sort -m4G -@ 120 -O BAM -o $$wd/working/haps_map.bam     
samtools index $$wd/working/haps_map.bam
svim-asm haploid $$wd/working $$wd/working/haps_map.bam $ref_genome

cp $wd/working/variants.vcf $wd/results

# reads: SVIM module for detecting SVs using raw reads rather than SAM/BAM alignment files
# --cores 10: number of threads
# --aligner: You can use other long-read aligners by changing “minimap2” to your desired aligner
# your_read.fq.gz: should be long-read sequencing data

# Align your genome assembly to the reference genome and sort the alignment information

# genome1=reference, genome2=query
# For minimap2, the parameters are as follows:
# -a: output will be printed as the SAM format
# -x asm5: preset for aligning two assemblies with ∼0.1% sequence divergence
# --cs: the output file will contain cs tags
# -r: chaining bandwidth
# -t: number of threads

# For SAMtools, the parameters are as follows:
# sort: SAMtools module to sort read mapping information
# -m: maximum memory for each thread
# -@: number of threads
# -O BAM: output as a BAM format


# Index your assembly-assembly alignment file
# Call SVs between the reference genome and yours
# haploid: SVIM-asm module for calling SVs between two haploid genomes