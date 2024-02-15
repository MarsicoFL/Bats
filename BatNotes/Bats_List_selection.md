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

genetic_data = bats_df.iloc[:, 4:].transpose()

genetic_data_filled = genetic_data.fillna(genetic_data.median())

scaled_data = StandardScaler().fit_transform(genetic_data_filled)

pca = PCA(n_components=2)  # Reducir a 2 componentes principales para visualización
principal_components = pca.fit_transform(scaled_data)

pca_df = pd.DataFrame(data=principal_components, columns=['PC1', 'PC2'])
pca_df['Animal_ID'] = genetic_data.index
pca_df.head()
```

Plot

```python 
import matplotlib.pyplot as plt

plt.figure(figsize=(10, 7))
plt.style.use('ggplot')

colors = {'GC':'blue', 'LC':'red'}
markers = {'M':'o', 'F':'s'}

for colony, color in colors.items():
    for sex, marker in markers.items():
        subset = pca_df[(pca_df['Colony'] == colony) & (pca_df['Sex'] == sex)]
        plt.scatter(subset['PC1'], subset['PC2'], color=color, marker=marker, s=50, label=f'{colony}-{sex}')

plt.title('PCA de Datos Genéticos de Murciélagos')
plt.xlabel('PC1')
plt.ylabel('PC2')
plt.legend()
plt.grid(True)
plt.show()
```

<img src="https://github.com/MarsicoFL/batPed/assets/55600771/5072c38c-96ef-4173-b36c-f606f1b6e376" width="80%">

```python 
num_to_select = 5  # 5 machos y 5 hembras de cada colonia

selected_bats = pd.DataFrame()

for colony in ['GC', 'LC']:
    for sex in ['M', 'F']:
        subset = pca_df[(pca_df['Colony'] == colony) & (pca_df['Sex'] == sex)]
        
        subset_sorted = subset.sort_values(by=['PC1', 'PC2'])
        selected_from_subset = subset_sorted.iloc[::len(subset) // num_to_select][:num_to_select]
        
        selected_bats = selected_bats.append(selected_from_subset)

selected_bats.reset_index(drop=True, inplace=True)
selected_bats
```

The selection!

|       PC1 |       PC2 | Animal_ID | Colony | Sex |
|----------:|----------:|:----------|:-------|:----|
| -23.9876  | -18.286   | GSO-12-p  | GC     | M   | 
|  13.498   | -13.1921  | GSO-138-d | GC     | M   | 
|  27.143   |  22.4251  | GSO-97-c  | GC     | M   |
|  37.656   |  -4.86746 | GSO-143-p   | GC     | F   | 
|  52.8923  | -20.8896  | GSO-63-g  | GC     | M   | 
|   2.14418 |   2.47417 | GSO-116-b | GC     | F   |
|  25.0437  |  -3.15348 | GSO-111-c  | GC     | M   | 
|  31.3515  | -39.149   | GSO-45-k  | GC     | F   | 
|  40.4481  | -30.7723  | GSO-59-c  | GC     | F   | 
|  43.2621  |  27.6184  | GSO-58-f  | GC     | F   | 
| -53.6469  | -29.3207  | GSO-79-p  | LC     | M   |
| -48.7845  |  11.1514  | GSO-129-b | LC     | M   |
| -39.8911  |  19.5242  | GSO-90-n  | LC     | M   |
| -29.414   |  31.7277  | GSO-133-h | LC     | M   |
| -26.9571  |  -9.0733  | GSO-33-k  | LC     | M   | 
| -50.4741  | -20.2984  | GSO-88-c  | LC     | F   |
| -33.6347  |  10.1725  | GSO-6-d   | LC     | F   | 
| -26.4434  | -48.3378  | GSO-112-n | LC     | F   |
| -13.7882  | -26.2434  | GSO-70-p  | LC     | F   |
|  -1.48976 | -27.0941  | GSO-25-p  | LC     | M   | 

(*) Indicate that this individuals could be changed and are released from gender balance definition.

Now we plot it:

```python 
plt.figure(figsize=(10, 7))
plt.style.use('default')

plt.scatter(pca_df['PC1'], pca_df['PC2'], color='lightgray', label='Not Selected', s=50, alpha=0.7)

english_labels = {'GC': 'GC', 'LC': 'LC', 'M': 'Male', 'F': 'Female'}
for colony, color in colors.items():
    for sex, marker in markers.items():
        subset = selected_bats[(selected_bats['Colony'] == colony) & (selected_bats['Sex'] == sex)]
        plt.scatter(subset['PC1'], subset['PC2'], color=color, marker=marker, s=50, label=f'{english_labels[colony]}-{english_labels[sex]} Selected', edgecolor='black')

plt.title('PCA of Bat Genetic Data (Selected Bats Highlighted)')
plt.xlabel('PC1')
plt.ylabel('PC2')
plt.legend()
plt.grid(True)
plt.show()
```


<img src="https://github.com/MarsicoFL/batPed/assets/55600771/7d6671eb-4b8c-4915-9748-4dee1e5e22a7" width="80%">


We also check it with previously performed clustering (available on the bat dropbox):

![clustering](https://github.com/MarsicoFL/batPed/assets/55600771/497eac72-ac6f-46dd-8aa5-ce1a4133b1ec)

## Relationships
From those more related, in LC colony, we plot IBD2 versus IBD0

![KinshipLC](https://github.com/MarsicoFL/Bats/assets/55600771/1a8b10a9-a62f-4790-ac38-f9c532329563)

Pair GSO-129 and GSO-84 results in the most parent-child likely pair. 

