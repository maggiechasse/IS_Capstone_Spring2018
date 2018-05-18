# IS_Capstone_Spring2018
Independent study capstone for spring 2018. This capstone focuses on ChIP-seq analysis using command line, HPC scripting, and R. 

**Summarization of this semester of your independent study**

**Detailed list of all files within the GitHub repository**

## ChIP-seq data analysis - command line, bash scripting
1.	What tools are you using to analyze and visualize your results? Provide a detailed list with citations when possible.
  
#### 2.	VARI HPC Job Submission Script:
- Download the template HPC job script in your email and using the information provided here list each PBS command in   the job script and the corresponding function.
  - HPC Script
    - #PBS -l walltime=200:00:00 *(Sets maximum wall time, the job will not run for more than 200 hours)*
    -  #PBS -l mem=20gb *(Memory request is 20 gb)*
    -  #PBS -l nodes=1:ppn=1 *(Will be assigned to 1 node)* 
    -  #PBS -M maggie.chasse@vai.org *(Send mail to this address)* 
    - #PBS -m abe *(Mail alert for: A: Abortion of task; B: Beginning of task; E: End of task)*
    - #PBS -N name *(Name of the job is “name”)*
    - cd $PBS_O_WORKDIR *(Change directory to original working directory)*
- How do you cancel a job after it was been submitted?
  - qdel with the job ID will delete a job from the queue.
- What is the command to submit a job to the HPC?
  - qsub with the script name will submit a job to the queue.
- What should you never do on the HPC? (Several possible answers!)
  - You should never use nodes not assigned to general use (e.g. lab or core specific nodes). Further, as HPC is a shared resource, you should not request more memory than you need for a project.

3.  Location of the data: /primary/projects/grohar/vari-core-generated-data/Capstone_Spring_2018
- Using Linux commands, change to this directory on the HPC. What is the command?
- How many files are in this directory? What is the command?
- Which is the largest file? What is the command?
- What is R1 vs R2?
  - R1 and R2 are results of paired-end sequencing (forward and reverse). So the fastq file for r1 will have all the forward reads and the fastq for the R2 file will have all the reverse reads. 

#### 4.	ChIP-Seq read alignment:
- Which parameters are required to run BWA?
  - Organism and genome to align the reads against.
  - Minimum seed length: Any read match that is shorter than this length will be excluded.
  - Maximum gap length: Gaps between reads longer tan this parameter will be excluded. 
  - Match score: Score for a matching base in a mapped read.
  - Mismatch penalty: Penalty for a mismatched base in a mapped read. 
  - Gap opening penalty: Penalty for opening a gap. Gaps allow for more reads to be mapped, but too many gaps will lower confidence in the alignment. 
  - Gap extension penalty: Penalty for extending a gap. Gaps allow for more reads to be mapped, but too many gaps will lower confidence in the alignment. 
  - Penalty for end clipping: Soft clipping of the 5'- and 3'- ends can be performed to maximize the global score. This score is related to the mismatch penalty.
- Which version of the human genome will you use for alignment? What are there differences between hg19 and GRCh38?
  - hg19 is from the UCSC genome project and GRCh38 is a product of NCBI. Both are reference genomes mapped with different coordinate systems and therefore, the annotations differ. Importantly, hg19 is a different genome than GRCh38 - ENCODE blacklist regions utilize hg19 and therefore, I will use hg19 for the alignment. Further, all qPCR validation used for ChIP-seq QC was with primers designed based on hg19. 
- Generate a new HPC job script with your BWA commands and appropriate parameters. Make sure to include it in the GitHub Repo. Submit your job script on the HPC.
    - #PBS -l walltime=200:00:00 *(Sets maximum wall time, the job will not run for more than 200 hours)*
    -  #PBS -l mem=20gb *(Memory request is 20 gb)*
    -  #PBS -l nodes=1:ppn=1 *(Will be assigned to 1 node)* 
    -  #PBS -M maggie.chasse@vai.org *(Send mail to this address)* 
    - #PBS -m abe *(Mail alert for: A: Abortion of task; B: Beginning of task; E: End of task)*
    - #PBS -N name *(Name of the job is “name”)*
    - cd $PBS_O_WORKDIR *(Change directory to original working directory)*
    

#### 5.	Alignment QC:
- Look for a tool that could be used to assess ChIP strength using the aligned BAM files. Provide the website and/or citation. - Write a command that could be used to generate QC figures or metrics.
- What should you be looking for?

#### 6.	Peak Calling:
- You can pick one of several ChIP-seq peak calling methods. Provide your reasoning as to why you selected the specific peak calling tool, the website and citation.
- Using your previously generated alignment files, identify areas of enrichment in your sequencing data relative to input. What considerations need to be made to call peaks for your type of ChIP-seq data? (Think about histone marks vs. transcription factors)
- Generate a new HPC job script with your peak calling commands and appropriate parameters. Make sure to include it in the GitHub Repo.

7.	What are the ENCODE Blacklist regions? Why are they used to filter ChIP-seq peaks? You can find the files here.
- ENCODE Blacklist regions are regions of the genome that have a high signal/count mappability due to their unstructured and highly repetitive nature (e.g. centromeres). These regions were defined by showing enrichment across multiple ChIP-seq experiments, regardless of IP target. The blacklisted ChIP peaks are cell type and experimental independent and therefore need to be filtered out to remove ‘false positive’ peaks during ChIP-seq analysis (Carroll et al, 2014. Front Genet). 

8.	What are the next steps after peak calling? How do you associate biological function to your areas of enrichment? Write a potential walkthrough of tools that could be used, either on the command line or in R.
- After peak calling,
- GO
- Tools


