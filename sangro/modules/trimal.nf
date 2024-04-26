process TRIMAL{
    label 'trimal'
    label 'lil_mem'

    publishDir(path: "${publish_dir}/trimal", mode: "symlink")

    input:
      path(mafft)
      val(masking_threshold)

    output:
        path("${mafft}.masked"), emit: trimal_ch

    script:
        """
        trimal -in ${mafft} -out ${mafft}.masked -gt ${masking_threshold}
        """
}
