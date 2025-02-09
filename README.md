
# Simple Nextflow BLAST Pipeline (In progress) 

This Nextflow pipeline automates the process of running **BLAST (Basic Local Alignment Search Tool)** using the `blastn` algorithm with the `megablast` task. It creates BLAST databases from reference `.fna` files and compares input query sequences against these databases.

---
The README.md file has the following main sections:
1. **Include Modules**: This include three main modules:
   - `MAKEBLASTDB`: Creates BLAST databases for reference sequences.
   - `BLAST`: Runs BLAST searches on existing databases.
   - `Parse_XML`: Parses XML output from BLAST.

2. **Database Creation**:
   - it creates a database for each `.fna` file in the input folders.
   - These databases are stored in separate entities (`blast_db`).
   - script to create database
   `makeblastdb -in GCA_943181505.1_UFV02.1_cds_from_genomic.fna -out GCA_943 -parse_seqids -dbtype nucl`

## 🚀 Features

- **Automated BLAST Database Creation:** Uses `makeblastdb` to create nucleotide BLAST databases.
- **Efficient Sequence Alignment:** Leverages `blastn -task megablast` for fast and accurate alignments.
- **Reproducibility:** Utilizes Docker containers for consistent environments.
- **Parallel Processing:** Handles multiple reference and query files concurrently.

---

## 📦 Directory Structure

```bash
.
├── data/
│   ├── reads/
│   │   └── test.fasta         # Query sequences
│   └── references/
│       ├── ref1.fna           # Reference genome 1
│       └── ref2.fna           # Reference genome 2
├── results/                   # Output directory
├── main.nf                    # Nextflow script
└── nextflow.config            # Configuration file
```

---

## ⚙️ Prerequisites

- [Nextflow](https://www.nextflow.io/docs/latest/getstarted.html) (version 24.10.4 or higher)
- [Docker](https://docs.docker.com/get-docker/) for containerized execution

### Install Nextflow

```bash
curl -s https://get.nextflow.io | bash
sudo mv nextflow /usr/local/bin/
```

### Verify Docker

```bash
docker --version
```

---

## 🚀 Usage

### 1️⃣ Make the script executable

```bash
chmod +x main.nf
```

### 2️⃣ Run the pipeline

```bash
nextflow run main.nf
```

### 3️⃣ Optional Parameters

Override default parameters if needed:

```bash
nextflow run main.nf --input_fasta "path/to/query.fasta" --reference_dir "path/to/references" --output_dir "path/to/results"
```

---

## 🔍 Input Requirements

- **Query Sequences:** FASTA file (`.fasta`) located in `data/reads/`
- **Reference Genomes:** FNA files (`.fna`) located in `data/references/`

---

## 📤 Output

- **BLAST Result Files:** Saved in the `results/` directory in XML format (`outfmt 5`).
- **Example Output:**

```bash
results/
├── test_vs_ref1.out
└── test_vs_ref2.out
```

---

## 🗂️ Pipeline Overview

1. **MAKEBLASTDB:** Converts `.fna` reference files into BLAST databases.
2. **MEGABLAST:** Runs `blastn` with `-task megablast` against the databases.

---

## 🐳 Docker Configuration

The pipeline uses the following container:

```bash
community.wave.seqera.io/library/blast:2.16.0--540f4b669b0a0ddd
```

Ensure Docker is running before executing the pipeline.

---

## 🛠️ Troubleshooting

### ⚠️ Common Issues & Fixes

- **Fix:** Ensure `data/references/` and `data/reads/` contain the required files.
- **Fix:** This is handled using `blastn -task megablast` instead.

- **Docker Errors**
  - **Fix:** Ensure Docker is installed, running, and the container image is accessible.

---

## 📜 License

This pipeline is provided as-is under the **MIT License**.

---

## 📚 References

- [Nextflow Documentation](https://www.nextflow.io/docs/latest/index.html)
- [BLAST+ Documentation](https://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download)

---
