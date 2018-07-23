#!/bin/bash

#PBS -l walltime=72:00:00,nodes=1:ppn=1
#PBS -joe /hpf/largeprojects/lauryl/results/bcbio_nextgen/control_VQSR_set/Crispr_CoverageAnalysis/GATK_DepthOfCoverage_Scripts/outputs
#PBS -N SAMPLE_GATK_DepthOfCoverage
#PBS -l vmem=40g,mem=40g

# Created by: Sam Khalouei
# Purpose: Runs GATK DepthOfCoverage. Another script "perform_GATK_DepthOfCoverage_2018_0519.sh" is used to replace the "SAMPLE" and "FILE" phrases in this 
#   script with the correct sample name and Bam file path

module load mugqic-pipelines/3.0.0
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/3.6 mugqic/R_Bioconductor/3.2.3_3.2 && \

outputfolder=/hpf/largeprojects/lauryl/results/bcbio_nextgen/control_VQSR_set/Crispr_CoverageAnalysis/GATK_DepthOfCoverage_Scripts

#rm -rf $outputfolder/GATK_DepthOfCoverage_output
mkdir -p $outputfolder/outputs

# The following line gives a list of options
#java -jar -Xmx10g /hpf/tools/centos6/mugqic-pipelines/source/resource/software/GenomeAnalysisTK/GenomeAnalysisTK-3.6/GenomeAnalysisTK.jar --help

java -jar -Xmx10g /hpf/tools/centos6/mugqic-pipelines/source/resource/software/GenomeAnalysisTK/GenomeAnalysisTK-3.6/GenomeAnalysisTK.jar \
-T DepthOfCoverage \
-R /hpf/largeprojects/ccmbio/naumenko/tools/bcbio/genomes/Mmusculus/mm10/seq/mm10.fa \
-o $outputfolder/outputs/SAMPLE \
-I FILE \
-ct 0 \
-ct 1 \
-ct 5 \
-ct 10 \
-ct 15 \
-ct 25 \
-ct 50 \
-ct 75 \
-ct 100 \
-ct 500 
#-L /hpf/largeprojects/lauryl/results/bcbio_nextgen/control_VQSR_set/Crispr_CoverageAnalysis/GATK_DepthOfCoverage_Scripts/wgs_crispr_chrInervals.bed
