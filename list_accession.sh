#list the accession number for the oomycetes assemblies which are chromosome level in an output file called list_accession_numbers
#download all the associated data for each accession number from NCBI 


esearch -db assembly -query '"Oomycota"[Organism] OR oomycetes[All Fields]) AND (latest[filter] AND "chromosome level"[filter] AND all[filter]
 NOT anomalous[filter]' | efetch -format docsum | xtract -pattern DocumentSummary -element AssemblyAccession > list_accession_numbers

#download all Genbank accessions 
while IFS= read -r accession; do

    echo "$accession"
# Download the genome data
    datasets download genome accession "$accession"

    mv ncbi_dataset.zip "$accession".zip

    echo "Downloaded: $accession.zip"

done < list_accession_numbers
