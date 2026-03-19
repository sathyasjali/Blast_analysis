### Blast analysis pipeline

Nextflow DSL2 pipeline for running MEGABLAST searches against multiple reference genomes and parsing results into CSV.

#### Steps

1. **MAKEBLASTDB** - Build nucleotide BLAST database for each reference genome
2. **MEGABLAST** - Search query FASTA against each database in parallel
3. **PARSE_XML** - Parse BLAST XML output into CSV

#### Requirements

- Nextflow (>= 22.10)
- Docker

#### Usage

```bash
nextflow run main.nf
nextflow run main.nf -resume
```

#### Parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| `referenceDir` | `data/reference` | Reference `.fna` files |
| `queriesDir` | `data/reads` | Query FASTA directory |
| `outdir` | `results` | Output directory |
| `evalue` | `1e-5` | E-value threshold |
| `max_target_seqs` | `10` | Max target sequences |

#### Output

```
results/
  blast_db/        - BLAST databases
  blast_results/   - Raw XML output
  parsed/          - CSV files
```

#### Containers

- BLAST: `community.wave.seqera.io/library/blast:2.16.0`
- Biopython: `quay.io/biocontainers/biopython:1.78`
