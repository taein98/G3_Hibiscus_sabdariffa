#! /usr/bin/bash

PREFIX=hibiscus.genome

wd=/home/taein/Denovo/Workings/jk_script/hibiscus
dir=$wd/working/results_hibiscus_opt_0.54

source /home/taein/oddments/anaconda3/etc/profile.d/conda.sh
conda activate Denovo

echo diploid
cd $wd/working/${PREFIX}_annotation_results
# cat augustus.hints.gtf | grep -vE "\.t2|\.t3|\.t4|\.t5" > genes.gtf
# cat augustus.hints.aa | grep -vE "\.t2|\.t3|\.t4|\.t5" > protein.fa
# cat augustus.hints.codingseq | grep -vE "\.t2|\.t3|\.t4|\.t5" > cds.fa
# mkdir userdefine
# mv genes.gtf protein.fa cds.fa userdefine
cp -r $dir/$PREFIX.fa userdefine/sequences.fa
java -jar /home/taein/Denovo/Tools/snpEff/snpEff.jar build -gtf22 -v userdefine -dataDir $wd/working/${PREFIX}_annotation_results -nodownload 2>&1 | tee hibiscus.buildDB.log
java -jar /home/taein/Denovo/Tools/snpEff/snpEff.jar userdefine ../HiFi.vcf.gz -dataDir $wd/working/${PREFIX}_annotation_results -nodownload > snp.ann.vcf
cat snp.ann.vcf | grep -v "#" | awk 'length($4)==1 && length($5)==1 && $4!="." && $5!="."' | grep "0/1" | wc -l >> snpEff.txt
cat snp.ann.vcf | grep -v "#" | awk 'length($4)==1 && length($5)==1 && $4!="." && $5!="."' | grep "0/1" | grep "HIGH" | wc -l >> snpEff.txt
cat snp.ann.vcf | grep -v "#" | awk 'length($4)==1 && length($5)==1 && $4!="." && $5!="."' | grep "0/1" | grep "MODERATE" | wc -l >> snpEff.txt
cat snp.ann.vcf | grep -v "#" | awk 'length($4)==1 && length($5)==1 && $4!="." && $5!="."' | grep "0/1" | grep "LOW" | wc -l >> snpEff.txt
cp -r snpEff.txt $wd/results


# echo hap1
# cd $wd/working/${PREFIX}_h1_annotation_results
# cat augustus.hints.gtf | grep -vE "\.t2|\.t3|\.t4|\.t5" > genes.gtf
# cat augustus.hints.aa | grep -vE "\.t2|\.t3|\.t4|\.t5" > protein.fa
# cat augustus.hints.codingseq | grep -vE "\.t2|\.t3|\.t4|\.t5" > cds.fa
# mkdir userdefine
# mv genes.gtf protein.fa cds.fa userdefine
# java -jar /home/taein/Denovo/Tools/snpEff/snpEff.jar build -gtf22 -v userdefine -nodownload 2>&1 | tee hap1_hibiscus.buildDB.log
# java -jar /home/taein/Denovo/Tools/snpEff/snpEff.jar userdefine ../h1_HiFi.vcf.gz -nodownload > h1_snp.ann.vcf
# cat h1_snp.ann.vcf | grep -v "#" | awk 'length($4)==1 && length($5)==1 && $4!="." && $5!="."' | grep "0/1" | wc -l >> hap1_snpEff.txt
# cat h1_snp.ann.vcf | grep -v "#" | awk 'length($4)==1 && length($5)==1 && $4!="." && $5!="."' | grep "0/1" | grep "HIGH" | wc -l >> hap1_snpEff.txt
# cat h1_snp.ann.vcf | grep -v "#" | awk 'length($4)==1 && length($5)==1 && $4!="." && $5!="."' | grep "0/1" | grep "MODERATE" | wc -l >> hap1_snpEff.txt
# cat h1_snp.ann.vcf | grep -v "#" | awk 'length($4)==1 && length($5)==1 && $4!="." && $5!="."' | grep "0/1" | grep "LOW" | wc -l >> hap1_snpEff.txt
# cp -r hap1_snpEff.txt $wd/results


# echo hap2
# cd $wd/working/${PREFIX}_h2_annotation_results
# cat augustus.hints.gtf | grep -vE "\.t2|\.t3|\.t4|\.t5" > genes.gtf
# cat augustus.hints.aa | grep -vE "\.t2|\.t3|\.t4|\.t5" > protein.fa
# cat augustus.hints.codingseq | grep -vE "\.t2|\.t3|\.t4|\.t5" > cds.fa
# mkdir userdefine
# mv genes.gtf protein.fa cds.fa userdefine
# java -jar /home/taein/Denovo/Tools/snpEff/snpEff.jar build -gtf22 -v userdefine -nodownload 2>&1 | tee hap2_hibiscus.buildDB.log
# java -jar /home/taein/Denovo/Tools/snpEff/snpEff.jar userdefine ../h2_HiFi.vcf.gz -nodownload > h2_snp.ann.vcf
# cat h2_snp.ann.vcf | grep -v "#" | awk 'length($4)==1 && length($5)==1 && $4!="." && $5!="."' | grep "0/1" | wc -l >> hap2_snpEff.txt
# cat h2_snp.ann.vcf | grep -v "#" | awk 'length($4)==1 && length($5)==1 && $4!="." && $5!="."' | grep "0/1" | grep "HIGH" | wc -l >> hap2_snpEff.txt
# cat h2_snp.ann.vcf | grep -v "#" | awk 'length($4)==1 && length($5)==1 && $4!="." && $5!="."' | grep "0/1" | grep "MODERATE" | wc -l >> hap2_snpEff.txt
# cat h2_snp.ann.vcf | grep -v "#" | awk 'length($4)==1 && length($5)==1 && $4!="." && $5!="."' | grep "0/1" | grep "LOW" | wc -l >> hap2_snpEff.txt
# cp -r hap2_snpEff.txt $wd/results