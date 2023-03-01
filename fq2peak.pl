#!/usr/bin/perl -w
#从cleandata.fa.gz 到bed ATAC分析
#配置文件atac.conf
#firstline:ref_genome path
#reads path
#picard path
#genome size
use strict;

(my $infile)=@ARGV;
if (@ARGV != 1) {die "Usage:\n atac.conf \n";}
open(I,"$infile");
open(O,">run.atac-fq2bed.sh");
chomp(my $ref_genome=<I>);
chomp(my $reas_path=<I>);
chomp(my $picard=<I>);
chomp(my $genome_size=<I>);
while(<I>){
chomp;
my @array=split(/\s+/,$_);
my $id=$array[0];
my $fq1=$array[1];
my $fq2=$array[2];
print O "time bowtie2 --very-sensitive -x $ref_genome -p 20 -X 2000 -1 $reas_path/$fq1 -2 $reas_path/$fq2 -S $id.sam && samtools view -f 2 -q 30 -o $id.pairs.bam $id.sam && samtools sort -o $id.pairs.sort.bam $id.pairs.bam && java -jar $picard/picard.jar MarkDuplicates REMOVE_DUPLICATES=true I=$id.pairs.sort.bam O=$id.pairs.dedup.sort.bam M=$id.duplicates.log && samtools index $id.pairs.dedup.sort.bam && samtools view -h $id.pairs.dedup.sort.bam|grep -v 'chrM'|grep -v 'chrC'|samtools sort -O bam  -@ 5 -o ->$id.final.bam &&samtools index $id.final.bam  &&samtools flagstat $id.final.bam>$id.final.stat&& java -jar $picard/picard.jar CollectInsertSizeMetrics I=$id.final.bam O=$id.insert_size_metrics.txt H=$id.insert_size_histogram.pdf M=0.5  &&bedtools bamtobed -i $id.final.bam>$id.bed && macs2 callpeak -t $id.bed -n $id --shift -100 --extsize 200 --nomodel -B --SPMR -g $genome_size --outdir 00macs2out 2>$id.macs2.log\n";
}
