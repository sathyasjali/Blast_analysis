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

#### Citations

- Altschul SF, Gish W, Miller W, Myers EW, Lipman DJ. Basic local alignment search tool. *J Mol Biol*. 1990;215(3):403-410.
- Camacho C, Coulouris G, Avagyan V, et al. BLAST+: architecture and applications. *BMC Bioinformatics*. 2009;10:421.
- Di Tommaso P, Chatzou M, Floden EW, et al. Nextflow enables reproducible computational workflows. *Nat Biotechnol*. 2017;35(4):316-319.
- Cock PJ, Antao T, Chang JT, et al. Biopython: freely available Python tools for computational molecular biology and bioinformatics. *Bioinformatics*. 2009;25(11):1422-1423.
