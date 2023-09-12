#!/home/taein/oddments/anaconda3/bin/python3
import numpy as np
from tqdm import tqdm
from Genomepy.elements.Blast_chunk import blast_chunk
from Genomepy.elements.Gene_chunk import gene_chunk
from Genomepy.elements.Contig import Contig
from Genomepy.elements.GFF_line import gf_line


class Contig:
    def __init__(self,contigName,contigSequence):
        self.seq = contigSequence.upper()
        try:
            self.name, self.length = contigName.split()
            self.length = int(self.length)
        except:
            self.name = contigName
            self.length = len(self.seq)



class Fasta_File:
    """Class for treating sequencing Fasta files as fasta files
    This is the Trash code
    awk '!/^>/ { printf "%s", $0; n = "\n" } /^>/ { print n $0; n = "" } END { printf "%s", n }' input.fasta >> result.fasta
    is the best way
    """
    def __init__(self,fasta):
        
        self.fulltext = np.array(fasta.readlines())
        print(len(self.fulltext))
        keyInd = np.flatnonzero(np.core.defchararray.find(self.fulltext,'>') != -1)
        valIter = iter(np.delete(self.fulltext, keyInd))
        val = np.array([])
        bIdx = 0
        for idx in tqdm(keyInd):
            iterNum = idx - bIdx
            tmpStr, bIdx = "", idx
            for i in range(iterNum):
                tmpStr += next(valIter).rstrip()
            val = np.append(val,tmpStr)
        print(keyInd)
        key = self.fulltext[keyInd]
        self.fullread = dict(zip(key,val))
        print(f"key[:5]:{key[:3]}")
        
    def RandSample(self,ratio,newFile):
        sampleKeys = np.random.choice(list(self.fullread.keys()),int(ratio*len(self.fullread)))
        for key in sampleKeys:
            newFile.write(key)
            newFile.write(self.fullread[key]+'\n')    
            
    def writeFile(self,newFile):
        with open(newFile,"w") as nf:
            for key in self.fullread:
                nf.write(key)
                nf.write(self.fullread[key]+'\n')    

class Genome_file:
    """ Class for treating Fasta Genome File"""
    def __init__(self,fasta):
        self.fulltext = fasta.readlines()
        print(len(self.fulltext))
        if len(self.fulltext) % 2 != 0:
            print("Something Wrong Fasta File! Check it.")
        self.contig_num = len(self.fulltext) // 2
        self.contig_list = []
        print("Starting to Construct {0} Contig From input Fasta file!".format(self.contig_num))
        for cont_num in range(self.contig_num):
            self.contig_list.append(Contig(self.fulltext[2*cont_num].rstrip(),self.fulltext[2*cont_num+1].rstrip()))
        print("Done!")
        
    def sort_by_contigLength(self):
        self.contig_list.sort(key=lambda contig: contig.length,reverse=True)
    
    def contig_name_formating(self,form):
        for i, cont in enumerate(self.contig_list):
            self.contig_list[i].name = ">{0}_{1:05d}".format(form,i+1)
    
    def print_stat(self):
        print(list(map(lambda x: x.length,self.contig_list))[:5])
    
    def filter_by_len(self,thres=500):
        remove_count = 0
        for i, cont in enumerate(self.contig_list):
            if cont.length < thres:
                remove_count += 1
                self.contig_list.pop(i)
        print(f"remove count: {remove_count}")

    def Write_New_Genome(self,path):
        with open(path,"x") as new_fasta:
            for cont in self.contig_list:
                new_fasta.write(cont.name + '\n')
                new_fasta.write(cont.seq + '\n')
        
def main():  
    target_path2 = "/home/taein/Denovo/Workings/manshuriensis/MakerAnnot/Hints/manshuriensis_medaka/AugustusWorking/manshuriensis_augustus_codingseq.fasta"
    f2 = open(target_path2,"r")
    tg = Genome_file(f2)
    tg.print_stat()
    tg.sort_by_contigLength()
    tg.print_stat()
    tg.contig_name_formating("Scaffold")
    tg.filter_by_len(thres=1000)

    tg.Write_New_Genome("/home/taein/Denovo/Workings/manshuriensis/MakerAnnot/Hints/manshuriensis_medaka/AugustusWorking//filt_manshuriensis_augustus_codingseq.fasta")
    f2.close()

if __name__ == '__main__':
    main()