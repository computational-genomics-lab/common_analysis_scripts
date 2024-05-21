'''
Following program defines a function called Bioproject_id_scraper which acts as a web scraper for bioproject ids from the NCBI site. 
It accepts a list of bioproject ids like  ["PRJEB38861", "640791", "PRJEB26976"]. 
If this program is run as is (ie without importing the function as a module) the expected output is :

   BioProject ID Genome Assembly Info                     Organism WGS Master Accession
0         640791      GCA_903819445.1  Flavobacterium chungangense      CAIJDO000000000
1         640791      GCA_903819435.1      Flavobacterium salmonis      CAIJDP000000000
2     PRJEB26976      GCA_900473955.1       Synechococcus sp. GEYO         UCNL00000000
3     PRJEB26976      GCA_900474045.1        Synechococcus sp. N19         UCNR00000000
4     PRJEB26976      GCA_900473975.1        Synechococcus sp. N26         UCNM00000000
5     PRJEB26976      GCA_900473895.1        Synechococcus sp. N32         UCND00000000
6     PRJEB26976      GCA_900473925.1         Synechococcus sp. N5         UCNI00000000
7     PRJEB26976      GCA_900473935.1      Synechococcus sp. UW105         UCNN00000000
8     PRJEB26976      GCA_900474015.1      Synechococcus sp. UW106         UCNV00000000
9     PRJEB26976      GCA_900474295.1      Synechococcus sp. UW140         UCOB00000000
10    PRJEB26976      GCA_900473965.1     Synechococcus sp. UW179A         UCNJ00000000
11    PRJEB26976      GCA_900474245.1     Synechococcus sp. UW179B         UCNZ00000000
12    PRJEB26976      GCA_900474185.1       Synechococcus sp. UW69         UCNW00000000
13    PRJEB26976      GCA_900474085.1       Synechococcus sp. UW86         UCNU00000000

made by Aditya, 21.5.24
'''

import requests
from bs4 import BeautifulSoup
import pandas as pd
from concurrent.futures import ThreadPoolExecutor, as_completed

def scrape_bioproject_id(bioproject_id):
    common_url = 'https://www.ncbi.nlm.nih.gov/bioproject/'
    try:
        page = '{}{}'.format(common_url, bioproject_id)
        req = requests.get(page)

        # Check if the request was successful
        if req.status_code != 200:
            print(f"Failed to retrieve page for BioProject ID {bioproject_id}: HTTP {req.status_code}")
            return []

        soup = BeautifulSoup(req.text, "html.parser")

        # Find the table tag with id "AssemblyDetails"
        table = soup.find("table", {"id": "AssemblyDetails"})

        # If the table is not found, print a message and return an empty list
        if table is None:
            print(f"No AssemblyDetails table found for BioProject ID {bioproject_id}")
            return []

        rows = table.find_all('tr')
        genome_assembly_info = []

        for row in rows:
            organism = row.find('a', title="Taxonomy information")
            td = row.find('a', title="Genome assembly info")
            wgs = row.find('a', title="GenBank WGS master accession")
            if td and organism and wgs:
                genome_assembly_info.append({
                    'BioProject ID': bioproject_id,
                    'Genome Assembly Info': td.text.strip(),
                    'Organism': organism.text.strip(),
                    'WGS Master Accession': wgs.text.strip()
                })
        
        return genome_assembly_info

    except Exception as e:
        print(f"An error occurred while processing BioProject ID {bioproject_id}: {e}")
        return []

def Bioproject_id_scraper(list_bioproject_ids):
    all_genome_assembly_info = []

    # Use ThreadPoolExecutor to scrape multiple BioProject IDs concurrently
    with ThreadPoolExecutor(max_workers=50) as executor: #provided 50 threads
        future_to_bioproject_id = {executor.submit(scrape_bioproject_id, bioproject_id): bioproject_id for bioproject_id in list_bioproject_ids}
        
        for future in as_completed(future_to_bioproject_id):
            bioproject_id = future_to_bioproject_id[future]
            try:
                data = future.result()
                all_genome_assembly_info.extend(data)
            except Exception as exc:
                print(f"{bioproject_id} generated an exception: {exc}")

    # Convert the list of dictionaries to a pandas DataFrame
    return pd.DataFrame(all_genome_assembly_info)

#for testing
if __name__ == "__main__":
    list_bioproject_ids = ["640791", "PRJEB26976"]
    df = Bioproject_id_scraper(list_bioproject_ids)
    print(df)
    
