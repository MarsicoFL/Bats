
# Pipeline para el Ensamblaje de Secuencias de Nanopore

## Paso 1: Control de Calidad
- Utiliza NanoPlot para analizar la calidad de las lecturas de Nanopore.
- Comando:
  ```
  NanoPlot --fastq PAQ19633_pass_*.fastq.gz --plots_format png --loglength -o nanoplot_results
  ```

## Paso 2: Filtrado y Limpieza
- Filtra y limpia las lecturas con NanoFilt basándote en los criterios de calidad y longitud.
- Comando:
  ```
  gunzip -c PAQ19633_pass_*.fastq.gz | NanoFilt -q 7 -l 1000 > filtered_reads.fastq
  ```

## Paso 3: Ensamblaje de Secuencias
- Opciones:
  - Miniasm y minimap2 para un ensamblaje rápido.
  - Canu para un enfoque más preciso y detallado.
- Comandos para Miniasm:
  ```
  minimap2 -x ava-ont filtered_reads.fastq filtered_reads.fastq | gzip -1 > reads.paf.gz
  miniasm -f filtered_reads.fastq reads.paf.gz > assembly.gfa
  ```
- Comandos para Canu:
  ```
  canu -p assembly -d canu_assembly genomeSize=est_genome_size useGrid=false -nanopore-raw filtered_reads.fastq
  ```

## Paso 4: Evaluación del Ensamblaje
- Utiliza QUAST y BUSCO para evaluar la calidad y completitud del ensamblaje.
- Comandos:
  ```
  quast.py -o quast_results assembly.gfa
  busco -i assembly.gfa -o busco_output -m geno -l lineage_dataset
  ```

## Paso 5: Polishing (Pulido)
- Mejora la calidad del ensamblaje con Medaka o Racon.
- Comando para Medaka:
  ```
  medaka_consensus -i filtered_reads.fastq -d assembly.gfa -o medaka_output -t 16 -m r941_min_high_g303
  ```

## Paso 6: Anotación (Opcional)
- Anota el genoma ensamblado con Prokka o AUGUSTUS.
- Comando para Prokka:
  ```
  prokka --outdir prokka_output --prefix my_genome assembly.fasta
  ```

## Consideraciones Finales
- Asegúrate de tener suficiente memoria y CPU para ejecutar estas herramientas.
- Ajusta los parámetros según las necesidades de tus datos y organismo.
- La calidad y longitud de las lecturas pueden influir significativamente en el resultado del ensamblaje.
- La estimación del tamaño del genoma es importante para algunos ensambladores como Canu.
- La evaluación del ensamblaje es crucial para verificar la calidad y la completitud del genoma ensamblado.
