from tqdm import tqdm
import argparse


parser = argparse.ArgumentParser(description="Process command-line arguments")


parser.add_argument('-y',"--upsilon", help="Length threashold", default=1000, type=int)
parser.add_argument('-o', '--out_file', help='Absolute path of masked.out file',type=str)
parser.add_argument('-g', '--genome_file', help='Absolute path of genome.fa file',type=str)
parser.add_argument('-r', '--results', help='The path and name of results',type=str)

args = parser.parse_args()
result_name = args.results

upsilon = args.upsilon
repeat_out = args.out_file
masked_seq = args.genome_file
results = args.results

def contig_length(fa:list) -> list:
    """
    Args:
        fa (list): the list generated by FASTA file f.readlines() and rstriped
        sequence of FASTA should not be spilted by \n
    Returns:
        list: list of lengths of each contig
    """
    lens = [len(l) for idx,l in tqdm(enumerate(fa)) if idx%2 == 1]
    return lens

def process_outFile(out_file: list):
    """
    Args:
        out_file (list): the list generated by masked.out file f.readlines() and rstriped
    Returns:
        list: the list of processed out_file(only containing telomeric repeat)
    """
    outs = [i.split() for i in tqdm(out_file)]
    processed_out_file = []
    for l in tqdm(outs):
        if sum([1 for i in ["TTTAGGG","TTAGGGT","TAGGGTT","AGGGTTT","GGGTTTA","GGTTTAG","GTTTAGG","CCCTAAA","CCTAAA", "CTAAACC","TAAACCC","AAACCCT","AACCCTA","ACCCTAA"] if i in l[9]]):
            processed_out_file.append("    ".join(l))
            
    return processed_out_file


def endFind(processed_out_file: list, contig_lengths: list, thres:int = upsilon):
    """
    Args:
        processed_out_file (list): the list generated by fxn: process_outFile
        thres (int, optional): threshold for allowing difference. Defaults to upsilon.
        contig_lengths (list): the list generated by fxn: contig_length (seq for repeatmasked file)
    """
    try:
        forwEnds, backEnds = [], []
        outs = [i.split() for i in processed_out_file]
        for l in tqdm(outs):
            contig_num = int(l[4].split("_")[1]) - 1   # The contigs are should be {prefix}_number in ascending order
            # contig_num = int(l[4][3:-1])
            contig_len = contig_lengths[contig_num]
            if int(l[5]) < thres:
                    forwEnds.append("   ".join(l))
            elif int(l[6]) > contig_len - upsilon:
                    backEnds.append("   ".join(l))
    except:
        import pdb; pdb.set_trace()
                 
    return forwEnds, backEnds

with open(masked_seq) as f:
    masked_genome_seq = f.readlines()
    masked_genome_seq = [i.rstrip() for i in tqdm(masked_genome_seq)]

with open(repeat_out) as f:
    repeat_out = f.readlines()
    repeat_out = [i.rstrip() for i in repeat_out[3:]]
    
contig_lengths = contig_length(masked_genome_seq)
repeat_out_processed = process_outFile(repeat_out)

print(f"Length of repeatmasked files\nout: {len(repeat_out)}\ntelomeres: {len(repeat_out_processed)}")

repeat_out_lengths = [int(i.split()[6]) - int(i.split()[5]) for i in repeat_out_processed]
forward_ends, back_ends = endFind(repeat_out_processed, contig_lengths)

print(len(forward_ends + back_ends))

with open(results,"w") as nf:
    for l in repeat_out_processed:
        nf.write(l+"\n")
end = results.replace('.txt','_end') + '.txt'
with open(end,"w") as nf:
    for l in forward_ends + back_ends:
        nf.write(l+"\n")

