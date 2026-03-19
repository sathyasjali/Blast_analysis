# Blast Analysis Pipeline

A Nextflow DSL2 pipeline for running MEGABLAST searches against multiple reference genomes and parsing results into CSV format.

## Overview

This pipeline automates three steps:

1. **MAKEBLASTDB** — Builds a nucleotide BLAST database for each reference genome (`.fna`)
2. **MEGABLAST** — Searches a query FASTA against each database in parallel
3. **PARSE_XML** — Parses BLAST XML output into CSV with key hit metrics

## Requirements

- [Nextflow](https://www.nextflow.io/) (>= 22.10)
- [Docker](https://www.docker.com/)

## Usage

```bash
nextflow run main.nf
```

### Parameters

| Parameter          | Default          | Description                        |
|--------------------|------------------|------------------------------------|
| `referenceDir`     | `data/reference` | Directory containing reference `.fna` files |
| `queriesDir`       | `data/reads`     | Directory containing query FASTA   |
| `outdir`           | `results`        | Output directory                   |
| `evalue`           | `1e-5`           | E-value threshold                  |
| `max_target_seqs`  | `10`             | Maximum target sequences per query |

### Resume a previous run

```bash
nextflow run main.nf -resume
```

## Output

```
results/
├── blast_db/          # BLAST databases
├── blast_results/     # Raw XML output
└── parsed/            # CSV files (Query ID, Hit ID, E-value, Bit Score, Alignment Length)
```

## Pipeline DAG

```
references (*.fna)
       │
   MAKEBLASTDB ──┐
                  ├── combine ── MEGABLAST ── PARSE_XML ── *.csv
   query.fasta ──┘
```

## Containers

- BLAST: `community.wave.seqera.io/library/blast:2.16.0`
- Biopython: `quay.io/biocontainers/biopython:1.78`
