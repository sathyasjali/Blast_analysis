#!/usr/bin/env nextflow
nextflow.enable.dsl=2

// Include module processes
include { MAKEBLASTDB } from './modules/makeblastdb.nf'
include { MEGABLAST }   from './modules/megablast.nf'
include { PARSE_XML }   from './modules/parse_xml.nf'

workflow {

    // Create channels for reference and query files
    references = Channel.fromPath("${params.referenceDir}/*.fna")
    query = Channel.fromPath("${params.queriesDir}/test.fasta")

    // Map each reference file to a tuple (db_name, reference file)
    dbInput = references.map { ref_file ->
        def db_name = ref_file.getFileName().toString().split('\\.')[0]
        tuple(db_name, ref_file)
    }

    // Build the BLAST DB for each reference
    blastDBs = MAKEBLASTDB(dbInput)

    // Combine each blastDB with the query file
    blastInput = blastDBs.combine(query)

    // Run MEGABLAST for each combination
    blastResults = MEGABLAST(blastInput)

    // Parse XML results to CSV
    PARSE_XML(blastResults)
}
