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
