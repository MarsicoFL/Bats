We have 1 bat under analysis, with the following algorithm we can choose the other 19 to be sequenced:

```python 
import numpy as np

# Step 1: Calculate Genetic Diversity

def hamming_distance(row1, row2):
    """Compute the Hamming distance between two rows of SNP data."""
    return np.sum(row1 != row2)

# Extract only the SNP columns from the merged dataset
snp_data = merged_data.iloc[:, 1:-3]

# Calculate the average Hamming distance for each bat
diversity_scores = []
for index, bat in snp_data.iterrows():
    distances = [hamming_distance(bat, other_bat) for i, other_bat in snp_data.iterrows() if i != index]
    diversity_scores.append(np.mean(distances))

# Add the diversity scores to the merged dataset
merged_data['diversity_score'] = diversity_scores

# Display the first few rows with the diversity scores added
merged_data[['Animal_ID', 'Colony', 'Sex', 'diversity_score']].head()
```
