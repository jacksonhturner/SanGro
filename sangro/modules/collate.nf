process COLLATE{
   label 'lil_mem'

   publishDir(path: "${publish_dir}/collate", mode: "symlink")

   input:
     path(genes)

   output:
     path("alignment.fasta"), emit: collate_ch

   script:
     """
     cat ${genes} >> alignment.fasta
     """ 
}
