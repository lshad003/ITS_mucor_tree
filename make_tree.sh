#!/usr/bin/bash -l
#SBATCH -p short -c 8 --mem 8gb --out make_tree.%A.log

# prior to this I ran the following to fix the names of the NCBI records
# they all start with >NR_XXX 
# and have form of >ACCESSION GENUS SPECIES STRAININFO
# so this renames them to >GENUS_SPECIES_ACCESSION
#perl -i -p -e 's/>(NR_\S+)\s+(\S+)\s+(\S+)/>$1_$2_$3 /' input.fasta

module load ITSx
module load fasttree
module load iqtree
module load muscle
ITSx -i input.fasta -t F -o UHM_mucor
muscle -align UHM_mucor.ITS1.fasta -output UHM_mucor.ITS1.fasaln 
muscle -align UHM_mucor.ITS2.fasta -output UHM_mucor.ITS2.fasaln 
FastTreeMP -nt -gamma -gtr < UHM_mucor.ITS1.fasaln > UHM_mucor.ITS1.ft.tre
FastTreeMP -nt -gamma -gtr < UHM_mucor.ITS2.fasaln > UHM_mucor.ITS2.ft.tre

