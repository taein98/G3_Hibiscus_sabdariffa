class Contig:
    def __init__(self,contigName,contigSequence):
        self.seq = contigSequence
        self.name = contigName
        try:
            self.name, self.length = contigName.split()
            self.length = int(self.length)
        except:
            self.name = contigName
            print("except!!")