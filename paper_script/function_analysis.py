import os
from tqdm import tqdm

def read_m8_files(path):
    with open(path) as f:
        lines = f.readlines()
        lines = [i.rstrip().split("\t") for i in lines]
    return lines

def filt_k(align_files, new_path, k = 3):
    with open(new_path,"w") as nf:
        name, count = "", 0
        for l in tqdm(align_files):
            if l[0] != name:
                name = l[0]
                count = 1
                nf.write("\t".join(l)+"\n")
            else:
                if count >= k:
                    continue
                else:
                    nf.write("\t".join(l)+"\n")
                    count += 1

k = 1
file_path = "/home/taein/Denovo/Workings/hibiscus/h1_cds_align.m8"
new_path = f"/home/taein/Denovo/Workings/hibiscus/h1_cds_filt{k}.tsv"

m8_files = read_m8_files(file_path)
filt_k(m8_files,new_path,k = k)

k = 1
file_path = "/home/taein/Denovo/Workings/hibiscus/h2_cds_align.m8"
new_path = f"/home/taein/Denovo/Workings/hibiscus/h2_cds_filt{k}.tsv"

m8_files = read_m8_files(file_path)
filt_k(m8_files,new_path,k = k)

