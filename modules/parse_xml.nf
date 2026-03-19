process PARSE_XML {
    publishDir "results/parsed", mode: 'copy', pattern: "*.csv"

    input:
    path xml_file

    output:
    path "${xml_file.baseName}.csv"

    script:
    """
    python3 <<EOF
    from Bio.Blast import NCBIXML
    import csv

    # Parse the XML file
    with open("${xml_file}", "r") as xml_handle:
        blast_records = NCBIXML.parse(xml_handle)
        
        # Open the CSV file for writing
        with open("${xml_file.baseName}.csv", "w", newline='') as csv_file:
            csv_writer = csv.writer(csv_file)
            csv_writer.writerow(['Query ID', 'Hit ID', 'E-value', 'Bit Score', 'Alignment Length'])
            
            # Extract information from each BLAST record
            for blast_record in blast_records:
                for alignment in blast_record.alignments:
                    for hsp in alignment.hsps:
                        csv_writer.writerow([
                            blast_record.query,
                            alignment.hit_id,
                            hsp.expect,
                            hsp.bits,
                            hsp.align_length
                        ])
    EOF
    """
}