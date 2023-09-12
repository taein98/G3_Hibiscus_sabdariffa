import os, sys
from tqdm import tqdm

n_per_line = 40


target_fa_path = "/home/taein/Denovo/Workings/hibiscus/working/h1_Hifi/sequences.fa"
new_fa_path = "/home/taein/Denovo/Workings/hibiscus/working/h1_Hifi/sequences_split.fa"

with open(target_fa_path,"r") as f:
    lines = f.readlines()
    lines = [i.rstrip() for i in lines]
with open(new_fa_path,"w") as nf:
    tmp = ""
    for line in tqdm(lines[:]):
        if ">" in line:
            nf.write(line + "\n")
        else:
            [nf.write(line[n_per_line*i:n_per_line*(i+1)]+"\n") for i in range(len(line)//n_per_line)]
            # print(len(line)%n_per_line)
            nf.write(line[-(len(line)%n_per_line):]+"\n")

target_fa_path = "/home/taein/Denovo/Workings/hibiscus/working/h2_Hifi/sequences.fa"
new_fa_path = "/home/taein/Denovo/Workings/hibiscus/working/h2_Hifi/sequences_split.fa"

with open(target_fa_path,"r") as f:
    lines = f.readlines()
    lines = [i.rstrip() for i in lines]
with open(new_fa_path,"w") as nf:
    tmp = ""
    for line in tqdm(lines[:]):
        if ">" in line:
            nf.write(line + "\n")
        else:
            [nf.write(line[n_per_line*i:n_per_line*(i+1)]+"\n") for i in range(len(line)//n_per_line)]
            # print(len(line)%n_per_line)
            nf.write(line[-(len(line)%n_per_line):]+"\n")