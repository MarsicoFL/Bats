We have 1 bat under analysis, with the following algorithm we can choose the other 19 to be sequenced. We consider:
 
 - Sex balance.
 - Picking from different colonies.
 - Maximizing genetic diversity through PCA analysis and kmeans clustering.
 - Check that selected bats are not related.
 - Show it in two dimensional PCA.

For this, we will use metadata file, and genenetwork.csv file, with the genetic information from the bats.

```python 
from sklearn.decomposition import PCA
from sklearn.preprocessing import StandardScaler
import numpy as np

# Eliminar las primeras columnas no genéticas de Bats.csv
genetic_data = bats_df.iloc[:, 4:].transpose()

# Manejar valores faltantes (NaN) - reemplazarlos con la mediana de cada columna
genetic_data_filled = genetic_data.fillna(genetic_data.median())

# Estandarizar los datos
scaled_data = StandardScaler().fit_transform(genetic_data_filled)

# Realizar el PCA
pca = PCA(n_components=2)  # Reducir a 2 componentes principales para visualización
principal_components = pca.fit_transform(scaled_data)

# Convertir a DataFrame para facilidad de manejo
pca_df = pd.DataFrame(data=principal_components, columns=['PC1', 'PC2'])
pca_df['Animal_ID'] = genetic_data.index

# Mostrar las primeras líneas del dataframe resultante del PCA
pca_df.head()
```

Ploteo

```python 
import matplotlib.pyplot as plt

# Establecer el estilo y tamaño del gráfico
plt.figure(figsize=(10, 7))
plt.style.use('ggplot')

# Colores y marcadores para colonia y sexo
colors = {'GC':'blue', 'LC':'red'}
markers = {'M':'o', 'F':'s'}

# Graficar cada murciélago según su colonia y sexo
for colony, color in colors.items():
    for sex, marker in markers.items():
        subset = pca_df[(pca_df['Colony'] == colony) & (pca_df['Sex'] == sex)]
        plt.scatter(subset['PC1'], subset['PC2'], color=color, marker=marker, s=50, label=f'{colony}-{sex}')

# Configurar título y leyenda
plt.title('PCA de Datos Genéticos de Murciélagos')
plt.xlabel('PC1')
plt.ylabel('PC2')
plt.legend()
plt.grid(True)
plt.show()
```

<img src="https://github.com/MarsicoFL/batPed/assets/55600771/5072c38c-96ef-4173-b36c-f606f1b6e376" width="80%">

```python 
# Número de murciélagos a seleccionar de cada categoría
num_to_select = 5  # 5 machos y 5 hembras de cada colonia

# Crear un DataFrame vacío para almacenar los murciélagos seleccionados
selected_bats = pd.DataFrame()

# Seleccionar murciélagos de diferentes áreas del gráfico, asegurando el equilibrio de sexo y colonia
for colony in ['GC', 'LC']:
    for sex in ['M', 'F']:
        subset = pca_df[(pca_df['Colony'] == colony) & (pca_df['Sex'] == sex)]
        
        # Seleccionar murciélagos de manera equitativa en el espacio PC1 y PC2
        # Para ello, ordenamos por PC1 y PC2 y seleccionamos de manera intercalada
        subset_sorted = subset.sort_values(by=['PC1', 'PC2'])
        selected_from_subset = subset_sorted.iloc[::len(subset) // num_to_select][:num_to_select]
        
        selected_bats = selected_bats.append(selected_from_subset)

selected_bats.reset_index(drop=True, inplace=True)
selected_bats
```

The selection!

|    |       PC1 |       PC2 | Animal_ID | Colony | Sex | MinimumAgeYrs |
|---:|----------:|----------:|:----------|:-------|:----|--------------:|
|  0 | -23.9876  | -18.286   | GSO-12-p  | GC     | M   | NaN           |
|  1 |  13.498   | -13.1921  | GSO-138-d | GC     | M   | NaN           |
|  2 |  27.143   |  22.4251  | GSO-97-c  | GC     | M   | NaN           |
|  3 |  37.656   |  -4.86746 | GSO-143-p   | GC     | *   | NaN           |
|  4 |  52.8923  | -20.8896  | GSO-63-g  | GC     | M   | NaN           |
|  5 |   2.14418 |   2.47417 | GSO-116-b | GC     | F   | NaN           |
|  6 |  25.0437  |  -3.15348 | GSO-111-c  | GC     | *   | NaN           |
|  7 |  31.3515  | -39.149   | GSO-45-k  | GC     | F   | NaN           |
|  8 |  40.4481  | -30.7723  | GSO-59-c  | GC     | F   | NaN           |
|  9 |  43.2621  |  27.6184  | GSO-58-f  | GC     | F   | NaN           |
| 10 | -53.6469  | -29.3207  | GSO-79-p  | LC     | M   | 5.5589        |
| 11 | -48.7845  |  11.1514  | GSO-129-b | LC     | M   | 8.2411        |
| 12 | -39.8911  |  19.5242  | GSO-90-n  | LC     | M   | 0.720548      |
| 13 | -29.414   |  31.7277  | GSO-133-h | LC     | M   | 2.23562       |
| 14 | -26.9571  |  -9.0733  | GSO-33-k  | LC     | M   | 5.5589        |
| 15 | -50.4741  | -20.2984  | GSO-88-c  | LC     | *   | *           |
| 16 | -33.6347  |  10.1725  | GSO-6-d   | LC     | F   | 1.80822       |
| 17 | -26.4434  | -48.3378  | GSO-112-n | LC     | F   | 6.83836       |
| 18 | -13.7882  | -26.2434  | GSO-70-p  | LC     | F   | 5.27123       |
| 19 |  -1.48976 | -27.0941  | GSO-25-p  | LC     | *   | *       |

(*) Indicate that this individuals could be changed and are released from gender balance definition.

Now we plot it:

```python 
# Establecer el estilo y tamaño del gráfico
plt.figure(figsize=(10, 7))
plt.style.use('default')

# Graficar todos los murciélagos en gris
plt.scatter(pca_df['PC1'], pca_df['PC2'], color='lightgray', label='Not Selected', s=50, alpha=0.7)

# Resaltar los murciélagos seleccionados según su colonia y sexo
english_labels = {'GC': 'GC', 'LC': 'LC', 'M': 'Male', 'F': 'Female'}
for colony, color in colors.items():
    for sex, marker in markers.items():
        subset = selected_bats[(selected_bats['Colony'] == colony) & (selected_bats['Sex'] == sex)]
        plt.scatter(subset['PC1'], subset['PC2'], color=color, marker=marker, s=50, label=f'{english_labels[colony]}-{english_labels[sex]} Selected', edgecolor='black')

# Configurar título y leyenda
plt.title('PCA of Bat Genetic Data (Selected Bats Highlighted)')
plt.xlabel('PC1')
plt.ylabel('PC2')
plt.legend()
plt.grid(True)
plt.show()
```


<img src="https://github.com/MarsicoFL/batPed/assets/55600771/7d6671eb-4b8c-4915-9748-4dee1e5e22a7" width="80%">


We also check it with previously performed clustering:

![clustering](https://github.com/MarsicoFL/batPed/assets/55600771/497eac72-ac6f-46dd-8aa5-ce1a4133b1ec)

## Re-analyzing admixture

Some time ago, we performed a pairwise kinship analysis between the bats. We detected some relatedness, but one of intriguing thinghs was the obtained coefficients for unrelatedness. Below:

![Captura desde 2023-11-15 09-04-38](https://github.com/MarsicoFL/batPed/assets/55600771/0e5e9bc2-37f8-4909-acc9-5d90d8430211)

We expect kinship = zero, with some degree of variance, but with zero and the mode. In this case we see a shift to lower values, this is also consistent with an highly admixed population.

