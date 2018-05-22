#PBS: portable batch system

#! /bin/bash
#PBS -l walltime=200:00:00 #Max run time is 200 hours
#PBS -l mem=20gb #Request 20gb memory
#PBS -l nodes=1:ppn=1 #1 node
#PBS -M maggie.chasse@vai.org #Email
#PBS -m abe #Abort; Beginning; End emails
#PBS -N name #Name of the job
cd $PBS_O_WORKDIR #Change to working directory
