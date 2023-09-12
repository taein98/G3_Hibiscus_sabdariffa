#! /usr/bin/bash

wd=/home/taein/Denovo/Workings/jk_script/hibiscus
PREFIX=hibiscus.genome
vcf=$wd/working/variants.vcf

cd $wd/working
grep "DEL" $vcf | awk -F "[\t;]" 'OFS="\t"{print $1,$2,$9}' | sed 's/END=//' >> SV_deletion.bed
grep "INS" $vcf | awk 'OFS="\t"{print $1,$2,$2}' >> SV_insertion.bed


cd $wd/working/${PREFIX}_h1_annotation_results
awk -F "[\t; ]" 'OFS="\t"{ if($3=="CDS"){print $1,$4,$5,$10,$13}}' augustus.hints.gtf | grep "\.t1" >> hibiscus.hap1.CDS.bed
awk -F "[\t; ]" 'OFS="\t"{ if($3=="gene"){print $1,$4,$5,$9}}' augustus.hints.gtf >> hibiscus.hap1.gene.bed
bedtools intersect -a hibiscus.hap1.CDS.bed -b ../SV_deletion.bed | awk '{print $5}' | sort | uniq | sed 's/"//g' >> hap1_geneList.deletion.txt
bedtools intersect -a hibiscus.hap1.CDS.bed -b ../SV_insertion.bed | awk '{print $5}' | sort | uniq | sed 's/"//g' >> hap1_geneList.insertion.txt
bedtools intersect -f 1.0 -a hibiscus.hap1.gene.bed -b ../SV_deletion.bed | awk '{print $4}' | sort -V | uniq >> hap1_geneList.possiblePAV.txt
cp -r hap1_*.txt $wd/results


cd $wd/working/${PREFIX}_h2_annotation_results
awk -F "[\t; ]" 'OFS="\t"{ if($3=="CDS"){print $1,$4,$5,$10,$13}}' augustus.hints.gtf | grep "\.t1" >> hibiscus.hap2.CDS.bed
awk -F "[\t; ]" 'OFS="\t"{ if($3=="gene"){print $1,$4,$5,$9}}' augustus.hints.gtf >> hibiscus.hap2.gene.bed
bedtools intersect -a hibiscus.hap2.CDS.bed -b ../SV_deletion.bed | awk '{print $5}' | sort | uniq | sed 's/"//g' >> hap2_geneList.deletion.txt
bedtools intersect -a hibiscus.hap2.CDS.bed -b ../SV_insertion.bed | awk '{print $5}' | sort | uniq | sed 's/"//g' >> hap2_geneList.insertion.txt
bedtools intersect -f 1.0 -a hibiscus.hap2.gene.bed -b ../SV_deletion.bed | awk '{print $4}' | sort -V | uniq >> hap2_geneList.possiblePAV.txt
cp -r hap2_*.txt $wd/results