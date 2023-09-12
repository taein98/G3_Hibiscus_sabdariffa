#! /usr/bin/bash

wd=/home/taein/Denovo/Workings/jk_script/hibiscus
Ninja_dir=/home/taein/Denovo/Tools/StrucAnnot/repeatbin/NINJA-0.95-cluster_only/NINJA/
dir=$wd/working/results_hibiscus_opt_0.54

# Repeat masking using known eudicotsn repeats with RepeatMasker
# conda activate repeatmodeler

PREFIX=hibiscus

source /home/taein/oddments/anaconda3/etc/profile.d/conda.sh
conda activate repeatmodeler

cd $dir
# mkdir repeat && 
# cd repeat
# BuildDatabase -name ${PREFIX} ${PREFIX}.fa
# RepeatModeler -database ${PREFIX} -pa 120 -LTRStruct -ninja_dir $Ninja_dir
# cd ..

RepeatMasker -species eudicots -s -parallel 120 -xsmall -alignments ${PREFIX}.fa
# RepeatMasker -species eudicots -s -parallel 120 -xsmall -alignments ${PREFIX}.h1.fa
# RepeatMasker -species eudicots -s -parallel 120 -xsmall -alignments ${PREFIX}.h2.fa
RepeatMasker -lib repeat/${PREFIX}-families.fa -s -parallel 120 -xsmall -alignments ${PREFIX}.fa.masked
# RepeatMasker -lib repeat/${PREFIX}-families.fa -s -parallel 120 -xsmall -alignments ${PREFIX}.h1.fa.masked
# RepeatMasker -lib repeat/${PREFIX}-families.fa -s -parallel 120 -xsmall -alignments ${PREFIX}.h2.fa.masked
# mkdir strain-specific.softMasked && 
mv *.fa.masked.* strain-specific.softMasked/
# mkdir eudicots.softMasked && 
mv *.fa.* eudicots.softMasked/

RepeatMasker -species eudicots -s -parallel 120 -alignments ${PREFIX}.fa
# RepeatMasker -species eudicots -s -parallel 120 -alignments ${PREFIX}.h1.fa
# RepeatMasker -species eudicots -s -parallel 120 -alignments ${PREFIX}.h2.fa
RepeatMasker -lib repeat/${PREFIX}-families.fa -s -parallel 120 -alignments ${PREFIX}.fa.masked
# RepeatMasker -lib repeat/${PREFIX}-families.fa -s -parallel 120 -alignments ${PREFIX}.h1.fa.masked
# RepeatMasker -lib repeat/${PREFIX}-families.fa -s -parallel 120 -alignments ${PREFIX}.h2.fa.masked
mkdir strain-specific.hardMasked && mv *.fa.masked.* strain-specific.hardMasked/
mkdir eudicots.hardMasked && mv *.fa.* eudicots.hardMasked/

cd strain-specific.softMasked
cp -r $PREFIX.fa.masked.masked $PREFIX.h1.fa.masked.masked $PREFIX.h2.fa.masked.masked $PREFIX.fa.masked.out $PREFIX.h1.fa.masked.out $PREFIX.h2.fa.masked.out $wd/results

cd ../eudicots.hadMasked
cp -r $PREFIX.h1.fa.tbl $PREFIX.h2.fa.tbl $PREFIX.fa.tbl $wd/results

cd ../strain-specific.hardMasked
cp -r $PREFIX.h1.fa.masked.tbl $PREFIX.h2.fa.masked.tbl $PREFIX.fa.masked.tbl $wd/results
