#!/bin/bash -ue
iqtree2 -s alignment.fasta.mafft        -m MFP+MERGE        -B 1000        -rcluster 10        -bnni        -nt 1
