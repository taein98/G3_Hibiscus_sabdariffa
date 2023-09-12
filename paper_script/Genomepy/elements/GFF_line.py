class gf_line:
    def __init__(self,gff_line):
        self.line = gff_line.rstrip()
        try:
            self.contig, self.source, self.feature, self.start, self.end, self.score, self.strand, self.frame, self.id = self.line.split("\t")
        except:
            print("error", self.line)
            self.contig, self.source, self.feature, self.start, self.end, self.score, self.strand, self.frame, self.id = "a b c d e f g h i".split()
    def generate_line(self):
        self.line = '\t'.join([self.contig, self.source, self.feature, self.start, self.end, self.score, self.strand, self.frame, self.id])
