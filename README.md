# ATAC-seq analysis
本仓库主要记录一ATAC处理过程中所用的脚本。
## 一键生成ATAC运行脚本
fq2peak.pl <atac.conf>
运行该脚本时，需要在脚本目录下有一个atac.conf文件
### atac.conf格式
$path/to/you/genome/genome.fa\
$path/to/you/cleandata\
$path/to/you/picard/java\
4.09e8\
id_1   id_1_1.clean.fq.gz     id_1_2.clean.fq.gz

## 合并Peak
### mergePeaks合并
mergePeaks -gsize ### narrowpeak/sample1.narrowPeak narrowpeak/sample2.narrowPeak ... >total_peak_merge.txt\
>使用homer软件中的mergePeaks\
>-gsize 基因组大小信息\
>结果中Total subpeaks的意思是当前合并的peak有对应多少个子peak\
### sort peak
sort -V -k2,3 total_peak_merge.txt >total_peak_merge.sort.txt\
>按照染色体名和start坐标排序total peak\
>在excel中整理并给没一个peak一个consensus peak ID\
### 注释每个样本一致性样本中的占有情况
./occupy.pl ptotal_peak_merge.sort.txt >total_peak_merge.sort.occupy.txt
