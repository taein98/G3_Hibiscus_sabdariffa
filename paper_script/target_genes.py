import os
from tqdm import tqdm

def read_m8_files(path):
    with open(path) as f:
        lines = f.readlines()
        lines = [i.rstrip().split("\t") for i in lines]
    return lines

def find_keywords(m8_files, keyword_set, new_path):
    with open(new_path, "w") as nf:
        for kw in tqdm(keyword_set):
            for line in m8_files:
                if kw in line[5].lower() and float(line[4]) > 0.9:
                    line[0] = line[0].split(".")[0]
                    seq = '\t'.join(line)
                    nf.write(f"{kw}\t{seq}\n")


keywords = ["2-oxoglutarate 3-dioxygenase", "flavonol synthase", "flavonoid 3',5'-hydroxylase", "flavonoid 3'-monooxygenase",
            "dihydroflavonol 4-reductase", "leucoanthocyanidin reductase", "leucoanthocyanidin deoxygenase", "anthocyanidin 3-o-glucosyltransferase",
            "uroporphyrinogen decarboxylase"]
k=1

file_path = f"/home/taein/Denovo/Workings/hibiscus/h1_cds_filt{k}.tsv"
m8_files = read_m8_files(file_path)
find_keywords(m8_files, keywords, f"/home/taein/Denovo/Workings/hibiscus/scripts/h1_targets.tsv")

file_path = f"/home/taein/Denovo/Workings/hibiscus/h2_cds_filt{k}.tsv"
m8_files = read_m8_files(file_path)
find_keywords(m8_files, keywords, f"/home/taein/Denovo/Workings/hibiscus/scripts/h2_targets.tsv")

