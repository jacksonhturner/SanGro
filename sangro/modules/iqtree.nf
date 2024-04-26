process IQTREE {
   label 'iqtree'
   label 'sup_mem'

   publishDir(path: "${publish_dir}/iqtree", mode: "symlink")

   input:
      path(masked)

   output:
      path("*"), emit: iqtree_ch

   script:
       """
       iqtree2 -s ${masked} \
       -m MFP+MERGE \
       -B 1000 \
       -rcluster 10 \
       -bnni \
       -nt ${task.cpus}
       """

}
