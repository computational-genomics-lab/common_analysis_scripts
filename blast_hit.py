#Run BLAST and save results in an xml file
#blastn -query your_query.fasta -db your_database -out results.xml -outfmt 5

#parse the blast results and find where the hits are. hit_accession:start-end 
#USAGE: python blast_hit.py > output.txt 

from Bio.Blast import NCBIXML

result_handle = open("results.xml")
blast_records = NCBIXML.parse(result_handle)

for blast_record in blast_records:
    for alignment in blast_record.alignments:
        for hsp in alignment.hsps:
            hit_accession = alignment.accession
            hit_from = hsp.sbjct_start
            hit_to = hsp.sbjct_end

            print(f"{hit_accession}:{hit_from}-{hit_to}")
