import os
from tqdm import tqdm

def get_gene_list(path):
    with open(path,"r") as f:
        genes = f.readlines()
        genes = [g.rstrip() for g in genes]
    return genes

def get_cds_dict(path):
    with open(path,"r") as f:
        cds_s = f.readlines()
        cds_s = [c.rstrip() for c in cds_s]
    current_name = ""
    current_seq = ""
    cds_dict = dict()
    for l in tqdm(cds_s):
        if ">" in l:
            cds_dict[current_name] = current_seq
            name = l.split(".")[0][1:]
            current_name, current_seq = name, ""
        else:
            current_seq += l
    cds_dict[current_name] = current_seq
    
    return cds_dict

def wrt_gene_seq(geneList, cdsDict, new_path):
    with open(new_path,"w") as nf:
        for g in tqdm(geneList):
            nf.write(f">{g}\n")
            try:
                gene_seq = cdsDict[g]
            except:
                print(f"No seq for {g}\n")
                gene_seq = ""
            nf.write(gene_seq+"\n")

def union_genes(geneList_1,geneList_2):
    tmp = geneList_1 + geneList_2
    union = set(tmp)
    union = list(union)
    return union
    
deletion_path = "/home/taein/Denovo/Workings/hibiscus/working/h2_Hifi/geneList.deletion.txt"
insertion_path = "/home/taein/Denovo/Workings/hibiscus/working/h2_Hifi/geneList.insertion.txt"
pav_path = "/home/taein/Denovo/Workings/hibiscus/working/h2_Hifi/geneList.possiblePAV.txt"

cds_path = "/home/taein/Denovo/Workings/hibiscus/working/h2_Hifi/augustus.hints.codingseq"

deletionList = get_gene_list(deletion_path)
insertionList = get_gene_list(insertion_path)
pavList = get_gene_list(pav_path)

unionList = union_genes(deletionList,insertionList)
union_geneList = union_genes(unionList,pavList)
print(len(deletionList),len(insertionList),len(pavList),len(union_geneList)) 

cdsDict = get_cds_dict(cds_path)
wrt_gene_seq(union_geneList,cdsDict,"/home/taein/Denovo/Workings/hibiscus/working/h2_Hifi/union_seq.fa")

deletion_path = "/home/taein/Denovo/Workings/hibiscus/working/h1_Hifi/geneList.deletion.txt"
insertion_path = "/home/taein/Denovo/Workings/hibiscus/working/h1_Hifi/geneList.insertion.txt"
pav_path = "/home/taein/Denovo/Workings/hibiscus/working/h1_Hifi/geneList.possiblePAV.txt"

cds_path = "/home/taein/Denovo/Workings/hibiscus/working/h1_Hifi/augustus.hints.codingseq"

deletionList = get_gene_list(deletion_path)
insertionList = get_gene_list(insertion_path)
pavList = get_gene_list(pav_path)

unionList = union_genes(deletionList,insertionList)
union_geneList2 = union_genes(unionList,pavList)
print(len(deletionList),len(insertionList),len(pavList),len(union_geneList2)) 

cdsDict = get_cds_dict(cds_path)
wrt_gene_seq(union_geneList2,cdsDict,"/home/taein/Denovo/Workings/hibiscus/working/h1_Hifi/union_seq.fa")

uniunnion_geneList = union_genes(union_geneList,union_geneList2)
print(len(uniunnion_geneList))