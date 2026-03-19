#!/usr/bin/env nextflow

process MEGABLAST {
    publishDir "${params.outdir}/blast_results", mode: 'copy'

    input:
        // Expect a tuple: (db_name, db_files directory, query file)
        tuple val(db_name), path(db_files), path(query)

    output:
        path "*_vs_*.xml"

    script:
    """
    echo "Running MEGABLAST: Query ${query} vs. Database ${db_name}"

    blastn -task megablast \
           -query ${query} \
           -db ${db_files}/${db_name} \
           -out ${query.baseName}_vs_${db_name}.xml \
           -outfmt 5 \
           -evalue ${params.evalue} \
           -max_target_seqs ${params.max_target_seqs}
    """
}
