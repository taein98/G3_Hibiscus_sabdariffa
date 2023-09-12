#!/usr/bin/env bash

cd working

ragtag.py scaffold -u -o /home/taein/Denovo/Workings/hibiscus/scaffolded/hap1_scaffold hibiscus_mutabilis.fasta hibiscus_opt_0.54.hap1.p_ctg.fa -t 120
ragtag.py scaffold -u -o /home/taein/Denovo/Workings/hibiscus/scaffolded/hap2_scaffold hibiscus_mutabilis.fasta hibiscus_opt_0.54.hap2.p_ctg.fa -t 120
