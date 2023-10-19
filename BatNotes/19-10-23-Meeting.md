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
![PCA](https://github.com/MarsicoFL/batPed/assets/55600771/5072c38c-96ef-4173-b36c-f606f1b6e376)


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

          PC1        PC2  Animal_ID Colony Sex  MinimumAgeYrs
0  -23.987615 -18.285951   GSO-12-p     GC   M            NaN
1   13.497953 -13.192074  GSO-138-d     GC   M            NaN
2   27.142988  22.425062   GSO-97-c     GC   M            NaN
3   37.656008  -4.867459    GSO-2-h     GC   M            NaN
4   52.892262 -20.889642   GSO-63-g     GC   M            NaN
5    2.144183   2.474167  GSO-116-b     GC   F            NaN
6   25.043737  -3.153480   GSO-85-f     GC   F            NaN
7   31.351456 -39.149040   GSO-45-k     GC   F            NaN
8   40.448070 -30.772298   GSO-59-c     GC   F            NaN
9   43.262119  27.618370   GSO-58-f     GC   F            NaN
10 -53.646869 -29.320679   GSO-79-p     LC   M       5.558904
11 -48.784457  11.151435  GSO-129-b     LC   M       8.241096
12 -39.891073  19.524161   GSO-90-n     LC   M       0.720548
13 -29.414021  31.727736  GSO-133-h     LC   M       2.235616
14 -26.957074  -9.073299   GSO-33-k     LC   M       5.558904
15 -50.474143 -20.298393   GSO-99-p     LC   F       3.400000
16 -33.634671  10.172499    GSO-6-d     LC   F       1.808219
17 -26.443390 -48.337783  GSO-112-n     LC   F       6.838356
18 -13.788219 -26.243361   GSO-70-p     LC   F       5.271233
19  -1.489763 -27.094144   GSO-44-g     LC   F       4.589041

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

