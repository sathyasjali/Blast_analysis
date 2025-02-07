#! /usr/bin/env nextflow

/*
 * create blast database for reference transcriptome file
 */

process MAKEBLASTDB {
    publishDir params.outdir, mode: 'copy'

    input:
        path reference_file

    output:
        tuple val(reference_file.baseName), path("blast_db/${reference_file.baseName}.*")


    script:
    """
    mkdir -p blast_db
    makeblastdb -in ${reference_file} -out blast_db/${reference_file.baseName}.* -parse_seqids -dbtype nucl
    """
}