#! /usr/bin/env nextflow

/*
 * create blast database for reference transcriptome file
 */

process MAKEBLASTDB {
    publishDir "${params.refOutDir}", mode: 'copy'

    input:
        path reference_file

    output:
        tuple val(reference_file.baseName), path("${params.refOutDir}/${reference_file.baseName}.*")

    script:
    """
    makeblastdb -in ${reference_file} -out ${params.refOutDir}/${reference_file.baseName} -parse_seqids -dbtype nucl
    """
}