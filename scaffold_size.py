#find the sizes of all scaffolds or chromosomes in a particular fasta file 
#USAGE: python scaffold_size.py > output_file

file_open=open("name_of_fasta",'r')
file_content=file_open.readlines()
seqs={}
for line in file_content:
    line=line.rstrip()
    if line.startswith('>'):
        words=line.split()
        name=words[0][1:]
        seqs[name]=''
    else:
        seqs[name]=seqs[name]+line
for scaffold in seqs.keys():
        print (scaffold, len(seqs[scaffold]))
