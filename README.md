# Overview
This repository contains the data and code for the BatPed project, which focuses on estimating kinship coefficients in bat populations using RNA-seq data.

# Bat1K
Link members area: https://bat1k.com/bat1k-members-area/

# Repository Contents
**BatNotes**: Notes and roadmap of the project.

**BatKinship.ipynb**: This Jupyter notebook contains the main analysis for the project. It includes the code for estimating kinship coefficients and any associated data exploration and visualization.

**BatMetadata.csv**: This CSV file contains metadata for the bat samples used in the project. This include information such as: sample ID, sex, Age and any colony of each bat.

**FromGeneNetworkToPlink.R**: This R script is used to convert gene network data into a format that can be used with PLINK.

**TechnicalReport.pdf**: This PDF file contains a manuscript describing the methods and results in detail.

**bat.map** and **bat.ped**: These files are in PLINK format and contain the genotype information for the bat samples. The .map file describes the marker positions, and the .ped file contains the genotype information.

**plink2.kin0**: This file contains the output from PLINK's kinship coefficient estimation. It includes the estimated kinship coefficients for each pair of individuals in the study.

**BatCoding_DrafMetadata_RWO_RWW_03May2023**: This file contains both coding types (i.e A103 that corresponds to RNA-seq data, and GSO-120-q that correspond to a specific bat). It is just for compatibility purposes.

**sec_PCA** files: eigenvec correspond to the values for each component for each individual. Eigenvalues correspond to the values for each component that divided over the sum of them is the percentage of variance explained.

**population_assignment**: the colony of each individual.

**plink.fst**: fst values for each marker.

**ibs_unrolled**: identical by descendant values for each pais (n*(1-n))/2.


# References
https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6868348/

https://primus.gs.washington.edu/primusweb/res/documentation.html

https://www.cog-genomics.org/plink/

https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6573782/
