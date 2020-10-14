"""Process DNA-seq data and construct a matrix

Usage:
    Process_DNASeq.py <outfile> <table>
"""


from docopt import docopt
import pandas as pd


if __name__ == '__main__':
    arguments = docopt(__doc__)
    table = arguments['<table>']
    outfile = arguments['<outfile>']
    print("Processing " + str(table))

    table = pd.read_table(str(table), sep='\t', skiprows=1)
    Sample = table.Tumor_Sample_UUID.unique()
    genes = table.gene_name_WU.unique()

    out = pd.DataFrame(index = genes, columns = Sample)
    for gene, sample, MTtype in zip(table.gene_name_WU.tolist(), 
                                    table.Tumor_Sample_UUID.tolist(),
                                    table.Variant_Classification.tolist()):
        out.loc[gene, sample] = MTtype

    print("Saving output at: " + str(outfile))
    out.to_csv(outfile)
