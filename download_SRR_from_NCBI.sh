#Prefetch the SRR_ID and convert to fastqs using fasterq-dump from sra-toolkit
~/pkgs/sratoolkit.3.0.0-ubuntu64/bin/prefetch SRR_ID >log_SRR-ID_prefetch
~/pkgs/sratoolkit.3.0.0-ubuntu64/bin/fasterq-dump --threads 20 -S SRR_ID

#Above steps results in generation of paired end fastq files for corresponding SRR_ID 
gzip -c SRR_ID_1.fastq > SRR_ID_1.fastq.gz
gzip -c SRR_ID_2.fastq > SRR_ID_2.fastq.gz

#Optional step to remove the fastq files upon their compression
rm ./SRR_ID_1.fastq ./SRR_ID_2.fastq
