## Pop gen analyses (Previously done)

Just remembering, we obtained more relatedness within colonies than between them:
![Captura desde 2023-09-20 08-54-09](https://github.com/MarsicoFL/batPed/assets/55600771/5b775a93-6199-4537-ba1c-b029db3fe64d)

NOTE: Rename <4th degree instead of unrelated.

Analyzing the same with other plots:
![Captura desde 2023-09-20 08-55-56](https://github.com/MarsicoFL/batPed/assets/55600771/3c8f4a5c-fbe1-42c3-a3f6-65ac6e545a44)


Firstly, considering the 105 bats, analyzing the RNA-seq data (curated variants) we perform PCA analysis.
The following scree plot is obtained.

![Captura desde 2023-09-20 08-45-48](https://github.com/MarsicoFL/batPed/assets/55600771/e943636e-abb6-44f9-afb0-5c2a3e6db63e)


There is no clear kick point. We proceed plotting two or three major components:

![Captura desde 2023-09-20 08-47-13](https://github.com/MarsicoFL/batPed/assets/55600771/3076efbe-9a96-4784-ba35-12e8a2ebbecd)

We observe some separation between colonies, but not enough to declare a clear clustering. Also, we analyze FST, below the results:

![Captura desde 2023-09-20 08-48-12](https://github.com/MarsicoFL/batPed/assets/55600771/3684476c-d2cc-47c9-86c2-a25d433117f5)

In concordance with PCA, and with kinship results, we observe low population structure.


## Meeting notes
Ask for ID of the individual we are sequencing 
filtering criteria  for RNA seq -> Available on the dropbox 
sex cromosomes in RNAseq -> X chromosome is present
we shoud join the batellite meetings: https://bat1k.com/bat1k-meetings-batellites/

Candidate selection:
For selecting candidates to be genotyped: 

-balancing sex 
-maxizing genetic diversity through PCA (first five components or through multiscaling dimension algorithm)


Then check kinship to be sure that we are not capturing any first, second or third degree relationship.
Then check with Danny clustering to be sure that we agree.
Probably multiple options will be possible, so some random selection could be done, or an ad hoc criteria for selecting between them.
