#! /usr/bin/env nextflow

/*
 * Genrate blast files
 */
// Include modules
include { MAKEBLASTDB } from './modules/makeblastdb.nf'
include { MEGABLAST } from './modules/megablast.nf'
// include { PARSE_XML } from './modules/parse_xml.nf'

params.outdir = 'results_ukd'
workflow {
    // Define input folders using params
    references = Channel.fromPath("${params.referenceDir}/*.fna")
    queries = Channel.fromPath("${params.queriesDir}/*.fasta")

    // Step 1: Create BLAST databases for each transcriptome
    blast_db = MAKEBLASTDB(references)
    blast_db_info = blast_db.map { db_name, db_file -> tuple(db_name, db_file) }
    
    // Step 2: Cross queries with database and run MEGABLAST
    //blast_db_results = MEGABLAST(blast_db_info)
    //megablast_results = queries.cross(blast_db_info).map { query, db_tuple -> tuple(db_tuple[0], db_tuple[1], query) } | MEGABLAST
    megablast_results = queries.cross(blast_db_info).map { query, db_tuple -> tuple(db_tuple[0], db_tuple[1], query) } | MEGABLAST()
}