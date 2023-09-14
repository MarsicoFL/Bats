## Relatedness Beyond Generations

We are investigating a population of 105 bats divided into two distinct colonies. Interestingly, these groups share a common ancestor dating back at least eight generations. Each colony was initially founded with a set of five males and five females, who were either siblings or cousins. Through computational simulations, we analyze the possible kinship relationships among the individuals within these bat colonies.

<img src="https://github.com/MarsicoFL/batPed/assets/55600771/05c481d0-b589-4e05-b001-a076ff296100" width="100%" />

## Can Two Individuals Share DNA from a Common Ancestor After Seven or More Generations?

Let's conduct an experiment based on this methodology: [ibdsim2](https://github.com/MarsicoFL/ibdsim2), following the model presented by [Science](https://www.science.org/doi/10.1126/science.aau1043).

We analyze the following example:

<img src="https://github.com/MarsicoFL/batPed/assets/55600771/d68ad83f-e5cc-4156-8cc1-da7dc3e25e47" width="100%" />

After running simulations of possible genomes (2000 in total) for individuals 26 and 38, we obtain:

<img src="https://github.com/MarsicoFL/batPed/assets/55600771/0cd9d6f3-139b-42c0-86a4-9fed9b171cb8" width="100%" />

How much DNA do they share? In most cases, they share zero or just a few centimorgans of their genomes.

## What About Inbreeding?

Given the information we have at the moment, most bats come from a common ancestor beyond seven generations. Therefore, at least the first generations likely experienced inbreeding. A conceptual case is presented below. Consider the following pedigree with inbreeding:

<img src="https://github.com/MarsicoFL/batPed/assets/55600771/b796be8a-37af-4fe2-aafc-afa33c7837c1" width="100%" />

When we analyze the individuals at the bottom, we find the following shared portions of the genome (based on 2000 simulations):

<img src="https://github.com/MarsicoFL/batPed/assets/55600771/1fbc43da-9c06-4e8e-a8ee-8f77a491d30f" width="100%" />

For comparison, consider the following pedigree, where two half-siblings are presented:

<img src="https://github.com/MarsicoFL/batPed/assets/55600771/2a104950-65e8-4f76-bd78-00a649afce26" width="50%" />

After seven generations, two individuals with strong inbreeding could share a similar amount of DNA as half-siblings.

<img src="https://github.com/MarsicoFL/batPed/assets/55600771/e73849bd-4c2b-4450-a84a-d5585a31185c" width="100%" />

Thore's work: https://www.fsigeneticssup.com/article/S1875-1768(19)30188-X/pdf
