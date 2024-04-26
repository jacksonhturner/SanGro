process PARSE_METADATA {
    label 'pandas'

    publishDir "${publish_dir}/design", mode: 'copy'

    input:
        path design

    output:
        path 'gene.csv', emit: gene_csv

    script:
        """
        parse_design.py \
            ${design}
        """
}
