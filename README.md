# Overview
This repository contains the data and code for the BatPed project, which focuses on estimating kinship coefficients in bat populations using RNA-seq data.

# Repository Contents
BatKinship.ipynb: This Jupyter notebook contains the main analysis for the project. It includes the code for estimating kinship coefficients and any associated data exploration and visualization.

BatMetadata.csv: This CSV file contains metadata for the bat samples used in the project. This may include information such as sample ID, species, location, and any other relevant details.

FromGeneNetworkToPlink.R: This R script is used to convert gene network data into a format that can be used with PLINK, a free, open-source whole genome association analysis toolset.

Rename script.R to FromGeneNetworkToPlink.R: This appears to be an instruction rather than a file. If it's a file, it might need renaming or removing.

Update README.md: This appears to be a commit message rather than a file. If it's a file, it might need renaming or removing.

TechnicalReport.pdf: This PDF file contains a technical report or manuscript describing the project and the results in detail.

bat.map and bat.ped: These files are in PLINK format and contain the genotype information for the bat samples. The .map file describes the marker positions, and the .ped file contains the genotype information.

plink2.kin0: This file contains the output from PLINK's kinship coefficient estimation. It includes the estimated kinship coefficients for each pair of individuals in the study.

Please refer to the individual files for more detailed information.



# References
https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6868348/
https://primus.gs.washington.edu/primusweb/res/documentation.html
https://www.cog-genomics.org/plink/
https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6573782/
