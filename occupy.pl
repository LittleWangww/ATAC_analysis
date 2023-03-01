#!/usr/bin/perl -w
use strict;

my $infile=shift;
#Author: wangww
#time:2023-3-1
open(F,"$infile");
my %hash;
my %hash2;
my $header=<F>;
while(<F>){
    chomp;
    my @a=split/\t/,$_;
    my $length=abs($a[3]-$a[2]+1);
    $hash2{$a[0]}="$a[0]\t$a[1]\t$a[2]\t$a[3]";
    my @b=split/\|/,$a[6];
    foreach my $peakfile(@b){
        $peakfile=~/([a-zA-Z]+)/;
        my $class=$1;
        $hash{$a[0]}{$class}=1;
    }
}
close F;

my @class=("sample1","sample2","sample3","sample4","sample5","sample6","sample7","sample8"); #根据实际情况修改
print "peakid\tchr\tstart\tend\tsample1\tsample2\tsample3\tsample4\tsample5\tsample6\tsample7\tsample8\n";
foreach my $peakid(keys %hash){
    print "$hash2{$peakid}\t";
    foreach my $classid(@class){
        if(exists $hash{$peakid}{$classid}){
            print "1\t";
        }else{
            print "0\t";
        }
    }
    print "\n";
}
