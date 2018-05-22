## IS_Capstone_Spring2018
Independent study capstone for spring 2018. This capstone focuses on ChIP-seq analysis using command line, HPC scripting, and R. 

**Summarization of this semester of your independent study**

**Detailed list of all files within the GitHub repository**
This GitHub repository has five files:
  - Generic_HPC_Script.sh
    - This HPC script was provided by Megan as a base script to design other scripts in the repository.
  - bwa_script.sh
    - This HPC script will perform the BWA algorithm to align the fastq files to the HG19 reference genome.
  - bamtobed (terminal script)
    - This terminal script will transform the bam file from the BWA alignment to a bed file for SICER peak calling using bedtools bamtobed command.
  - sicer_script.sh 
    - This HPC script will call peaks using the SICER algorithm. This script will call peaks using input controls.
  - sicer_diff_script.sh
      - This HPC script will call peaks using the SICER algorithm. This script will perform differential peak calling.

### ChIP-seq data analysis - command line, bash scripting
1.	What tools are you using to analyze and visualize your results? Provide a detailed list with citations when possible.
  
#### 2.	VARI HPC Job Submission Script:
- Download the template HPC job script in your email and using the information provided here list each PBS command in   the job script and the corresponding function.
  - HPC Script
    - #PBS -l walltime=200:00:00 *(Sets maximum wall time, the job will not run for more than 200 hours)*
    - #PBS -l mem=20gb *(Memory request is 20 gb)*
    - #PBS -l nodes=1:ppn=1 *(Will be assigned to 1 node)* 
    - #PBS -M maggie.chasse@vai.org *(Send mail to this address)* 
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
  - cd /primary/projects/grohar/vari-core-generated-data/Capstone_Spring_2018
- How many files are in this directory? What is the command?
  - 12 files
  - ls | wc *(this command will count all files in the directory)* 
- Which is the largest file? What is the command?
  - The largest file is: 13IP9K9_merged_R2.fastq.gz
  - The command: ls -S | head -1
- What is R1 vs R2?
  - R1 and R2 are results of paired-end sequencing (forward and reverse). So the fastq file for r1 will have all the forward reads and the fastq for the R2 file will have all the reverse reads. 

#### 4.	ChIP-Seq read alignment:
- Which parameters are required to run BWA?
  - Default: 
    - Minimum seed length: Any read match that is shorter than this length will be excluded.
    - Maximum gap length: Gaps between reads longer tan this parameter will be excluded. 
    - Match score: Score for a matching base in a mapped read.
    - Mismatch penalty: Penalty for a mismatched base in a mapped read. 
    - Gap opening penalty: Penalty for opening a gap. Gaps allow for more reads to be mapped, but too many gaps will lower confidence in the alignment. 
    - Gap extension penalty: Penalty for extending a gap. Gaps allow for more reads to be mapped, but too many gaps will lower confidence in the alignment. 
    - Penalty for end clipping: Soft clipping of the 5'- and 3'- ends can be performed to maximize the global score. This score is related to the mismatch penalty.
  - User defined:
    - Index: Fasta file for genome reference. This is downloaded. (hg19.fasta) 
    - Experimental data: R1.fastq and R2.fastq (for paired-end)
- Which version of the human genome will you use for alignment? What are there differences between hg19 and GRCh38?
  - hg19 is from the UCSC genome project and GRCh38 is a product of NCBI. Both are reference genomes mapped with different coordinate systems and therefore, the annotations differ. Importantly, hg19 is a different genome than GRCh38 - ENCODE blacklist regions utilize hg19 and therefore, I will use hg19 for the alignment. Further, all qPCR validation used for ChIP-seq QC was with primers designed based on hg19. 
- Generate a new HPC job script with your BWA commands and appropriate parameters. Make sure to include it in the GitHub Repo. Submit your job script on the HPC.
  - bwa_script.sh *(script name for job submission)*
    - #! /bin/bash
    - #PBS -l walltime=200:00:00 *(Sets maximum wall time, the job will not run for more than 200 hours)*
    - #PBS -l mem=20gb *(Memory request is 20 gb)*
    - #PBS -l nodes=1:ppn=1 *(Will be assigned to 1 node)* 
    - #PBS -M maggie.chasse@vai.org *(Send mail to this address)* 
    - #PBS -m abe *(Mail alert for: A: Abortion of task; B: Beginning of task; E: End of task)*
    - #PBS -N Capstone_BWA *(Name of the job is “name”)*
    - module load bwa/0.7.5a *(load BWA module)*
    - bwa index /primary/projects/grohar/vari-core-generated-data/Capstone_Spring_2018/hg19.fa *(load index/reference seq)*
    - bwa mem hg19.fa r1.fq r2.fq > Capstone.sam *(actual command to align fastq to ref and output is sam)*
    - module load samtools *(load samtools for conversion to bam file)*
    - samtools view -Sb  Capstone.sam  >  Capstone.bam *(converts sam files to bam file)*
    - cd $PBS_O_WORKDIR *(Change directory to original working directory)*

#### 5.	Alignment QC:
- Look for a tool that could be used to assess ChIP strength using the aligned BAM files. Provide the website and/or citation.
  - A tool to QC the ChIP from the aligend BAM files is MultiQC. Source: http://multiqc.info Citation: Ewels et al, 2016. Bioinformatics.
- Write a command that could be used to generate QC figures or metrics.
  - Must be in the directory where bam files are located to run the following command: 
    - multiqc . *or* firefox multiqc_report.html & 
- What should you be looking for?
  - MultiQC is used to create summaries of all samples. Firstly, you should look at the general statistics (particularly the number of reads and % duplication). Next, looking at the QualiMap tab will give you information on the quality of the mapping. The coverage histogram will define the coverage and read depth across the genome. The GC distribution will show the amount of GC regions mapped for a given sample. Overall, you want to make sure that each replicate of each sample (control vs. experimental) has similar read depth and distributions. 

#### 6.	Peak Calling:
- You can pick one of several ChIP-seq peak calling methods. Provide your reasoning as to why you selected the specific peak calling tool, the website and citation.
  - To call peaks for histone modifications, I am choosing to use SICER (Zhang et al, 2009. Bioinformatics.). Unlike MACS, a well-established peak calling program, SICER defines diffuse and broad distribution, rather than a well-defined peak like transcription factor binding. For this experiment, the IP was performed for H3K9me3, an abundant histone mark that is established at highly repetitive sequences. Therefore, to properly assign peaks, an algorithm and program built to identify diffuse domains is required. SICER (Spatial clustering method for the Identification of ChIP-Enriched Regions) pools signals from nucleosomes in a region of the genome to create ‘islands’, rather than the traditional window. Pooling the signals improves the signal-to-noise ratio and therefore helps to overcome the noise of diffuse peaks. SICER can be used for peak calling with and without a control as well as differential peak calling. The parameters to be defined are fragment size, window size, and gap size. Source code: https://home.gwu.edu/~wpeng/Software.htm 
- Using your previously generated alignment files, identify areas of enrichment in your sequencing data relative to input. What considerations need to be made to call peaks for your type of ChIP-seq data? (Think about histone marks vs. transcription factors)
  - Peak calling algorithms for histone marks vs. transcription factors were briefly discussed above. Unlike histone marks (or chromatin remodelers) which will form broad diffuse peaks across the genome, transcription factors bind to DNA through consensus sequence recognition and therefore form distinct sharp peaks. Thus, peak calling for a transcription factor IP would benefit from the MACS algorithm, rather than SICER (Zhang et al, 2008. Genome Biol.). 
**- Generate a new HPC job script with your peak calling commands and appropriate parameters. Make sure to include it in the GitHub Repo.**

7.	What are the ENCODE Blacklist regions? Why are they used to filter ChIP-seq peaks? You can find the files here.
- ENCODE Blacklist regions are regions of the genome that have a high signal/count mappability due to their unstructured and highly repetitive nature (e.g. centromeres). These regions were defined by showing enrichment across multiple ChIP-seq experiments, regardless of IP target. The blacklisted ChIP peaks are cell type and experimental independent and therefore need to be filtered out to remove ‘false positive’ peaks during ChIP-seq analysis (Carroll et al, 2014. Front Genet). 

8.	What are the next steps after peak calling? How do you associate biological function to your areas of enrichment? Write a potential walkthrough of tools that could be used, either on the command line or in R.
- After peak calling, the peaks need to be annotated so peaks with genomic context can be defined. To accomplish this, ChIPpeakAnno (Zhu et al, 2010. BMC Bioinformatics.)and ChIPseeker (Yu et al, 2015. Bioinformatics.)from Bioconductor can be used. Here, ChIPpeakAnno will obtain gene information around the peak, including gene ontology terms to associate biological functions with the area of interest. Further, ChIPpeakAnno will find the nearest gene, TF binding sites, and other related functionalities. ChIPseeker, like ChIPpeakAnno, will annotate peaks and define the nearest gene. In addition, ChIPseeker allows the ChIP dataset to be compared with other ChIP sets in the GEO database. ChIPseeker can be used to create visualizations of the data including heatmaps, distance from TSS, enrichment at specific genomic features, etc. Next, differential binding analyiss can be performed with SICER (as described above) or runDiff in R. Differential binding will define unique peaks in the treatment or experimental condition compared to solvent. Lastly, GO (gene ontology) term analysis and motif analysis can be performed.  Biocondoctor (in R) offers packages to acocmplish both of these objectives.



