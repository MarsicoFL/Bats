library(tidyverse)
library(data.table)
setwd("/home/franco/Escritorio/Evo/BatProject/Test")

data <- X01_Master_Bat_Genotypes_19Apr2023_Filtered_HWE_MAF_QUAL_SFAM_for_GN_with_Metadata[, -c(1:3)]


# Creamos una función para combinar los valores de REF y ALT
combinar_genotipo <- function(ref, alt, valor){
  if (valor == 0){
    return(paste(ref, ref, sep="/"))
  } else if (valor == 1){
    return(paste(ref, alt, sep="/"))
  } else if (valor == 2){
    return(paste(alt, alt, sep="/"))
  } else {
    return(NA) # Si hay algún otro valor, devolvemos NA
  }
}

# Aplicamos la función a todas las columnas que contienen los genotipos (excluyendo las columnas 'REF' y 'ALT')
df <- data %>% rowwise() %>%
  mutate(across(starts_with("GSO"), ~combinar_genotipo(REF, ALT, .)))

#CHR <- X01_Master_Bat_Genotypes_19Apr2023_Filtered_HWE_MAF_QUAL_SFAM_for_GN_with_Metadata$CHR
#marker <- X01_Master_Bat_Genotypes_19Apr2023_Filtered_HWE_MAF_QUAL_SFAM_for_GN_with_Metadata$MARKER_ID
#Position <- X01_Master_Bat_Genotypes_19Apr2023_Filtered_HWE_MAF_QUAL_SFAM_for_GN_with_Metadata$Mb_v0423
#Individual_ID <- names(X01_Master_Bat_Genotypes_19Apr2023_Filtered_HWE_MAF_QUAL_SFAM_for_GN_with_Metadata[, -c(1:5)])
#Family_ID <- rep(0, 105)
#Paternal_ID <- rep(0, 105)
#Maternal_ID <- rep(0, 105)
#Phenotype <- rep(-9,105)
#Individual_ID <- as.data.frame(Individual_ID)
#Sex <- merge(Individual_ID, SexMet, by.x = "Individual_ID", by.y = "V1", all.x = TRUE)
#SexMet <- as.data.frame(cbind(Metadata$Animal_ID, Metadata$Sex...11))
#names(SexMet)
#Sex[43, 2] <- 0
#merge(Individual_ID, SexMet, by.x = "Individual_ID", by.y = "V1", all = TRUE)
#Individual_ID[97, 2] <- 0
#Individual_ID$Sex <- SexMet$V2[match(Individual_ID$Individual_ID, SexMet$V1)]
#Sex <- Individual_ID$Sex
#set <- as.data.frame(cbind(Family_ID, Individual_ID$Individual_ID, as.numeric(Paternal_ID), as.numeric(Maternal_ID), as.numeric(Individual_ID$Sex), as.numeric(Phenotype)))
#bat.ped <- as.data.frame(cbind(set, data))
#bat.ped$V5[bat.ped$V5 == 1] <- 2
#bat.ped$V5[bat.ped$V5 == 0] <- 1
#fwrite(bat.ped, "bat.ped", sep = " ")

meta<- bat[, c(1:6)]

df2 <- as.data.frame(t(df[, -c(1:2)]))

df3 <- cbind(meta, df2)
fwrite(df3, "bat_prelim.ped")

df3[df3 == "NA" | is.na(df3)] <- "0/0"


getwd()
library(data.table)


separar_columna <- function(columna) {
  return(separate(df2, col = columna, into = paste0(columna, "_separado"), sep = "/"))
}

# Aplicar la función a todas las columnas del dataframe
columnas_separadas <- lapply(names(df2), separar_columna)



fwrite(df3, "bat.ped", sep = " ")
