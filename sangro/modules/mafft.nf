process MAFFT{
    label 'mafft'
    label 'big_mem'
    
    publishDir(path: "${publish_dir}/mafft", mode: "symlink")

    input:
        path(gene)
        
    output:
        path("${gene}.mafft"), emit: mafft_ch

    script:
        """
        mafft ${gene} > ${gene}.mafft
        """
}
