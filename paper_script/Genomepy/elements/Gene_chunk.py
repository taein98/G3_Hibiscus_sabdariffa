class gene_chunk:
    def __init__(self,id_line,seq_line):
        self.name = id_line.rstrip()
        self.seq = seq_line.rstrip()
        self.blast_result = -1
        self.line = id_line + seq_line
    def generate_line(self):
        if self.blast_result == -1:
            print("This file maybe didn't be blasted!")
            self.line = self.name + '\n' + self.seq + '\n'
        else:
            self.line = self.name + '\n' + self.seq + '\n'

# class sepFasta_file:
#     def __init__(self,fasta):
#         self.fulltext = fasta.readlines()
#         tmp_seq = ""
#         for line in self.fulltext:
#             if ">" in line:
#                 tmp_name = line