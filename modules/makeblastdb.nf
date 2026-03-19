#!/usr/bin/env nextflow

process MAKEBLASTDB {
    publishDir "${params.outdir}/blast_db", mode: 'copy'
    
    input:
        // Expect a tuple: (db_name, reference FASTA file)
        tuple val(db_name), path(ref_fasta)
        
    output:
        // Output a tuple: (db_name, path to directory containing DB files)
        // The directory “blast_db” will include files such as ${db_name}.nin, .nhr, .nsq, etc.
        tuple val(db_name), path("blast_db")
    
    script:
    """
    mkdir -p blast_db
    makeblastdb -in ${ref_fasta} -dbtype nucl -out blast_db/${db_name}
    """
}
