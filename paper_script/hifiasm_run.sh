#! /usr/bin/bash

wd=/home/taein/Denovo/Workings/jk_script/hibiscus
rawPath=/backup/220116/hibiscus_pacbio/m64238e_220926_023509.hifi_reads.fasta
lineagePath=/home/taein/Denovo/2_Workings/roseline/PolishedGenome/WorkingDir/2ndPolishing/pilon/busco_downloads/lineages
prefix=hibiscus_opt


source /home/taein/oddments/anaconda3/etc/profile.d/conda.sh

cd $wd/working

for i in 0.54
do
    # echo "run hifiasm with option s: $i"
    # hifiasm -o ${prefix}_$i -t 120 $rawPath -s $i
    # mkdir results_${prefix}_$i
    # mv ${prefix}_${i}* results_${prefix}_$i

    cd results_${prefix}_$i
    awk '/^S/{print ">"$2;print $3}' ${prefix}_$i.bp.hap1.p_ctg.gfa  > ${prefix}_$i.h1.fa
    awk '/^S/{print ">"$2;print $3}' ${prefix}_$i.bp.hap2.p_ctg.gfa  > ${prefix}_$i.h2.fa
    awk '/^S/{print ">"$2;print $3}' ${prefix}_$i.bp.p_ctg.gfa  > ${prefix}_$i.fa

    assembly-stats ${prefix}_$i.h1.fa > ${prefix}_$i.h1.stats
    assembly-stats ${prefix}_$i.h2.fa > ${prefix}_$i.h2.stats
    assembly-stats ${prefix}_$i.fa > ${prefix}_$i.stats
    
    conda deactivate
    conda activate Denovo
    # busco -o ${prefix}_${i}_hap1.busco -i ${prefix}_$i.h1.fa --lineage_dataset $lineagePath/eudicots_odb10 -m genome -c 120
    # busco -o ${prefix}_${i}_hap2.busco -i ${prefix}_$i.h2.fa --lineage_dataset $lineagePath/eudicots_odb10 -m genome -c 120
    # busco -o ${prefix}_${i}.busco -i ${prefix}_$i.fa --lineage_dataset $lineagePath/eudicots_odb10 -m genome -c 120
    # conda deactivate
    # conda activate hifiasm
    # cp -r ${prefix}_$i.h1.fa ${prefix}_$i.h2.fa ${prefix}_$i.fa $wd/results
    cp -r ${prefix}_$i.h1.stats ${prefix}_$i.h2.stats ${prefix}_$i.stats $wd/results 
    # cp -r ${prefix}_$i.h1.fa ${prefix}_$i.h2.fa ${prefix}_$i.fa ${prefix}_${i}_hap1.busco ${prefix}_${i}_hap2.busco ${prefix}_${i}.busco $wd/results 
    cd ..
done