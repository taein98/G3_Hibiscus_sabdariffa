#! /usr/bin/bash

wd=/home/taein/Denovo/Workings/jk_script/hibiscus
dir=$wd/working/results_hibiscus_opt_0.54
PREFIX=hibiscus.genome

# python telomere_check.py \
#     -o $dir/strain-specific.softMasked/$PREFIX.h1.fa.masked.out \
#     -g $dir/$PREFIX.h1.fa \
#     -r $wd/working/$PREFIX.h1.telomeres.txt

# python telomere_check.py \
#     -o $dir/strain-specific.softMasked/$PREFIX.h2.fa.masked.out \
#     -g $dir/$PREFIX.h2.fa \
#     -r $wd/working/$PREFIX.h2.telomeres.txt

    python telomere_check.py \
    -o $dir/strain-specific.softMasked/$PREFIX.fa.masked.out \
    -g $dir/$PREFIX.fa \
    -r $wd/working/$PREFIX.telomeres.txt

cp -r $wd/working/$PREFIX.h1.telomeres.txt $wd/working/$PREFIX.h2.telomeres.txt $wd/working/$PREFIX.telomeres.txt $wd/results