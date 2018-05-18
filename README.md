# IS_Capstone_Spring2018
Independent study capstone for spring 2018. This capstone focuses on ChIP-seq analysis using command line, HPC scripting, and R. 
Independent Study Capstone Project - Spring 2018

Summarization of this semester of your independent study

Detailed list of all files within the GitHub repository

ChIP-seq data analysis - command line, bash scripting
1.	What tools are you using to analyze and visualize your results? Provide a detailed list with citations when possible.
2.	VARI HPC Job Submission Script:
a.	Download the template HPC job script in your email and using the information provided here list each PBS command in the job script and the corresponding function.
o	SCRIPT:
	#PBS -l walltime=200:00:00
•	Sets maximum wall time, the job will not run for more than 200 hours
	#PBS -l mem=20gb
•	Memory request is 20 gb
	#PBS -l nodes=1:ppn=1
•	Will be assigned to 1 node 
	#PBS -M maggie.chasse@vai.org
•	Send mail to this address 
	#PBS -m abe
•	Mail alert for:
o	A: Abortion of task
o	B: Beginning of task
o	E: End of task
	#PBS -N name
•	Name of the job is “name”
o	
	cd $PBS_O_WORKDIR
•	Change directory to original working directory
b.	
c.	How do you cancel a job after it was been submitted?
1.	qdel <jobid> will delete a job from the queue 
d.	What is the command to submit a job to the HPC?
1.	qsub <scriptname>
a.	 What should you never do on the HPC? (Several possible answers!)
1.	You should never use nodes not assigned to general use (e.g. lab or core specific nodes). Further, as HPC is a shared resource, you should not request more memory than you need for a project.
2.	Location of the data: /primary/projects/grohar/vari-core-generated-data/Capstone_Spring_2018
a. Using Linux commands, change to this directory on the HPC. What is the command?
b. How many files are in this directory? What is the command?
c. Which is the largest file? What is the command?
d. What is R1 vs R2?
3.	ChIP-Seq read alignment:
a. Which parameters are required to run BWA?
b. Which version of the human genome will you use for alignment? What are there differences between hg19 and GRCh38?
c. Generate a new HPC job script with your BWA commands and appropriate parameters. Make sure to include it in the GitHub Repo.
d. Submit your job script on the HPC.
4.	Alignment QC: Look for a tool that could be used to assess ChIP strength using the aligned BAM files. Provide the website and/or citation. Write a command that could be used to generate QC figures or metrics. What should you be looking for?
5.	Peak Calling: a. You can pick one of several ChIP-seq peak calling methods. Provide your reasoning as to why you selected the specific peak calling tool, the website and citation.
b. Using your previously generated alignment files, identify areas of enrichment in your sequencing data relative to input. What considerations need to be made to call peaks for your type of ChIP-seq data? (Think about histone marks vs. transcription factors)
c. Generate a new HPC job script with your peak calling commands and appropriate parameters. Make sure to include it in the GitHub Repo.
6.	What are the ENCODE Blacklist regions? Why are they used to filter ChIP-seq peaks? You can find the files here.
a.	ENCODE Blacklist regions are regions of the genome that have a high signal/count mappability due to their unstructured and highly repetitive nature (e.g. centromeres). These regions were defined by showing enrichment across multiple ChIP-seq experiments, regardless of IP target. The blacklisted ChIP peaks are cell type and experimental independent and therefore need to be filtered out to remove ‘false positive’ peaks during ChIP-seq analysis (Carroll et al, 2014. Front Genet). 
7.	What are the next steps after peak calling? How do you associate biological function to your areas of enrichment? Write a potential walkthrough of tools that could be used, either on the command line or in R.
a.	After peak calling,
b.	GO


