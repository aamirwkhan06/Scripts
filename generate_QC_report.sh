echo -e "Sample\tBases_R1_raw\tBases_R2_raw\tReads_R1_raw\tReads_R2_raw\tReads_R1_trimmed\tReads_R2_trimmed\tBases_above_Q30_R1_trimmed\tBases_above_Q30_R2_trimmed\tTrimmed_read_pairs" > All_samples_reads_stats.txt
while read line
do
b1=`grep -P "Total bases" RawData_$line\_1.txt | awk '{print $NF}'`
b2=`grep -P "Total bases" RawData_$line\_2.txt | awk '{print $NF}'`
r1=`grep -P "Total reads" RawData_$line\_1.txt | awk '{print $NF}'`
r2=`grep -P "Total reads" RawData_$line\_2.txt | awk '{print $NF}'`
tr1=`grep -P "Total reads" TrimmedData_$line\_1.txt | awk '{print $NF}'`
tr2=`grep -P "Total reads" TrimmedData_$line\_2.txt | awk '{print $NF}'`
bq30_1=`grep -P "% bases >=Q30" TrimmedData_$line\_1.txt | awk '{print $NF}'`
bq30_2=`grep -P "% bases >=Q30" TrimmedData_$line\_2.txt | awk '{print $NF}'`
trimmed_reads=`grep -P "Input Read Pairs" ../logs/log_trimmomatic_$line | awk '{print $7}'`
echo -e "$line\t$b1\t$b2\t$r1\t$r2\t$tr1\t$tr2\t$bq30_1\t$bq30_2\t$trimmed_reads" >> All_samples_reads_stats.txt
done < ../accessions_list.txt

###Stats sample file from raspberry tool for a sample
##File name : SRR13556368_1.fastq.gz
##Total bases : 2742058440
##Total reads : 30467316
##% bases >=Q20 : 96.774
##% bases >=Q30 : 91.687
##Average read length : 90.000
##read length range : 90 .. 90
