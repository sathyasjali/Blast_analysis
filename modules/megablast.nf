#! /usr/bin/env nextflow

/*
 * Megablast with query sequence
 */

process MEGABLAST {
    publishDir params.outdir, mode: 'copy'

    input:
    tuple val(db_name), path(db_path), path(query)

    output:
     tuple val(query.baseName), path("${query.baseName}_vs_${db_name}.xml")

    script:
    """
    echo "Running MEGABLAST with query: ${query}, database: ${db_path}"
    blastn -task megablast -query ${query} -db '${db_path}' -out "${query.baseName}_vs_${db_name}.xml" -outfmt 5 -evalue 1e-5 -max_target_seqs 10
    """
    }