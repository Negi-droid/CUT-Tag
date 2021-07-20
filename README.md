# CUT-Tag
Pipeline to analyze CUT&Tag sequencing data 

# Use snakemakeversion 5.30.1 for the whole pipeline (either install it or use module load) 
# create a config file with the data you want to run through the pipeline 
# 1. concatenate the files 
# 2. run trimmomatic ( module load bioinfo-tools and module load trimmomatic) 
# 3. map the files ( module load bioinfo-tools; module load bowtie2 ; module load samtools )
# 4. sort the mapped files ( module load bioinfo-tools ; module load samtools )
# 5. mark the optical and pcr duplicates and remove them ( module load bioinfo-tools ;  module load picard )
# 6. Index the files (module load bioinfo-tools ; module load samtools)
# 7. download the blacklist for your species and remove the blacklisted region from your files 
# 8. Use the bam files without the blacklisted regions for peak calling ( module load bioinfo-tools ;  module load MACS ) -> data can be visualized in Integrative genomics viewer) 
# 9. Create a bigwig gile with the files that no longer contain the blacklisted regions ( module load bioinfo-tools ; module load deepTools )
# 10. Use the bigwig file to compute the matrix ( module load bioinfo-tools ; module load deepTools )
# 11. Use the matrix to create a heatmap ( module load bioinfo-tools ; module load deepTools) 
#

