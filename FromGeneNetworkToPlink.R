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
