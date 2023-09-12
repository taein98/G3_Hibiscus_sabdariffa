#! /usr/bin/bash

source /home/taein/oddments/anaconda3/etc/profile.d/conda.sh


seq1=/home/taein/Denovo/Workings/hibiscus/Hibiscus_RNA/Hibiscusleaf_4_1.fastq.gz
seq2=/home/taein/Denovo/Workings/hibiscus/Hibiscus_RNA/Hibiscusleaf_4_2.fastq.gz
PREFIX=hibiscus.genome

wd=/home/taein/Denovo/Workings/jk_script/hibiscus
dir=$wd/working/results_hibiscus_opt_0.54
genemark_path=/home/taein/Denovo/Tools/StrucAnnot/gmes_linux_64


conda deactivate & conda activate Denovo
cd $dir/strain-specific.softMasked
hisat2-build $PREFIX.fa.masked.masked ${PREFIX}_build
hisat2 -x ${PREFIX}_build -p 120 -1 $seq1 -2 $seq2 | samtools sort -@ 120 -O BAM -o RNA_align.bam

conda deactivate & conda activate braker
cd $wd/working
mkdir annotation
braker.pl --genome=$dir/strain-specific.softMasked/$PREFIX.fa.masked.masked --bam=$dir/strain-specific.softMasked/RNA_align.bam --softmasking --cores 120 --workingdir=./annotation --GENEMARK_PATH=$genemark_path
mkdir ${PREFIX}_annotation_results
cp -r annotation/augustus* ${PREFIX}_annotation_results



# conda deactivate & conda activate Denovo
# cd $dir/strain-specific.softMasked
# hisat2-build $PREFIX.h1.fa.masked.masked ${PREFIX}_h1_build
# hisat2 -x ${PREFIX}_h1_build -p 120 -1 $seq1 -2 $seq2 | samtools sort -@ 120 -O BAM -o RNA_align.h1.bam

# conda deactivate & conda activate braker
# cd $wd/working
# mkdir annotation_h1
# braker.pl --genome=$dir/strain-specific.softMasked/$PREFIX.h1.fa.masked.masked --bam=$dir/strain-specific.softMasked/RNA_align.h1.bam --softmasking --cores 120 --workingdir=./annotation_h1 --GENEMARK_PATH=$genemark_path
# mkdir ${PREFIX}_h1_annotation_results
# cp -r annotation_h1/augustus* ${PREFIX}_h1_annotation_results



# conda deactivate & conda activate Denovo
# cd $dir/strain-specific.softMasked
# hisat2-build $PREFIX.h2.fa.masked.masked ${PREFIX}_h2_build
# hisat2 -x ${PREFIX}_h2_build -p 120 -1 $seq1 -2 $seq2 | samtools sort -@ 120 -O BAM -o RNA_align.h2.bam

# conda deactivate & conda activate braker
# cd $wd/working
# mkdir annotation_h2
# braker.pl --genome=$dir/strain-specific.softMasked/$PREFIX.h2.fa.masked.masked --bam=$dir/strain-specific.softMasked/RNA_align.h2.bam --softmasking --cores 120 --workingdir=./annotation_h2 --GENEMARK_PATH=$genemark_path
# mkdir ${PREFIX}_h2_annotation_results
# cp -r annotation_h2/augustus* ${PREFIX}_h2_annotation_results


cp -r *annotation_results $wd/results

# -x: index PREFIX
# -p: the number of threads HISAT2 will use
# -1 and -2: paired-end files. You can change the name of your sequencing data

# sort: SAMtools module to sort the mapped read information
# -@: the number of threads SAMtools will use
# -o: output file name
# -O BAM: output as a BAM format


# Outputs of BRAKER

# augustus.hints.aa     # Amino acid FASTA sequences for your coding genes
# augustus.hints.codingseq  # Nucleotide FASTA sequences for your coding genes
# augustus.hints.gtf    # GTF file for your coding genes, which include their positions, orientation, and ID, etc.




# --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Due to license and distribution restrictions, GeneMark and ProtHint should be separately installed for BRAKER2 to become fully functional
# Create the conda environment for braker2

# > conda create -n braker -c bioconda braker2
# # Activate the environment for braker2
# > conda activate braker



# #1. GeneMark-EX program

# # Download GeneMark-EX program(gmes_linux_64.tar) and GeneMark key(gm_key_64) from http://exon.gatech.edu/GeneMark/license_download.cgi (the GeneMark-ES/ET/EP) option
# tar -xvf gmes_linux_64.tar
# cd gmes_linux_64
# perl change_path_in_perl_scripts.pl "/usr/bin/env perl"
# # This is required for BRAKER to accurately find the ".gm_key". See the "2. GeneMark key" section
# pwd


# 2. GeneMark key

# # GeneMark-EX will only run if a valid key file resides in your home directory
# # The key file will expire after 200 days, which means that you have to download a new GeneMark-EX release and a new key file after 200 days.
# > cd # change to your home directory
# > mv gm_key_64 .gm_key

# --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------







