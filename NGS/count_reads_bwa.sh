##22/08/2018
##Zhipeng
##This script is used to get basic read statistics for NGS. The numbers of raw reads and clean
##reads were calculated based on the total lines of fq file. The number of mapping reads was
##calculated using bwaMapStat for bwa and bamMapStat for other aligners (e.g. STAR, tophat2). 

echo -ne "The whole program starts at: "
date

#set working directory
wkDIR="/program/zhipeng/projects/Ath_lncRNAs_31072018/PM_BJ170289_22_ChIPseq_9137_16082018"
rawDIR="${wkDIR}/raw_data/Rawdata"
trimDIR="${wkDIR}/results/trim_galore"
bwaDIR="${wkDIR}/results/bwa"

#retrieve files
cd $rawDIR
fastq_FILES=$(ls *_R1.fq.gz)

#process file using loop
for f in $fastq_FILES
do
  filename=${f%_R1.fq.gz}
  echo -ne "Now is processing ${filename} ... "
  date

  #count number of raw reads
  cd $rawDIR
  rawLine=$(zcat ${filename}_R1.fq.gz |wc -l)
  rawCount=$((rawLine / 4))
  echo -ne "The number of raw reads is: $rawCount \n"

  #count number of clean reads
  cd $trimDIR
  cleanLine=$(zcat ${filename}_R1_trimmed.fq.gz | wc -l)
  cleanCount=$((cleanLine / 4))
  echo -ne "The number of clean reads is: $cleanCount \n"

  #count mapped reads
  cd $bwaDIR
  bwaMapStat -bam ${filename}.bwa_mem.bam -reads ${cleanCount}
  echo -ne "The number of clean reads is: $bwaDIR \n"
done

echo -ne "The whole program ends at : "
date
