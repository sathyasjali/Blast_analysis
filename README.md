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


3. **Data Organization**:
   - Each database is transposed into a row of data (e.g., `db_dir` becomes the column name).
   - This structure organizes all databases together, making it easy to run BLAST searches against them.

4. **BLAST Search Execution**:
   - Run BLAST searches on each query against all databases simultaneously.
   - The results are stored in another database (e.g., `blast_output`).

5. **Data Extraction and Parsing**:
   -  Parse the XML output from BLAST into a structured format, likely for easier analysis.

6. **Results Collection**:
   - The parsed results are flattened into a single file per database.
