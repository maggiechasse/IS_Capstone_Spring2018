#! /bin/bash
#PBS -l walltime=200:00:00 
#PBS -l mem=20gb 
#PBS -l nodes=1:ppn=1 
#PBS -M maggie.chasse@vai.org 
#PBS -m abe 
#PBS -N Capstone_BWA
module load bwa/0.7.5a 
bwa index /primary/projects/grohar/vari-core-generated-data/Capstone_Spring_2018/hg19.fa 
bwa mem hg19.fa r1.fq r2.fq > Capstone.sam module load samtools 
samtools view -Sb  Capstone.sam  >  Capstone.bam 
cd $PBS_O_WORKDIR 
