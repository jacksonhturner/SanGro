nextflow.enable.dsl=2

include { PARSE_METADATA } from "./modules/metadata.nf"
include { COLLATE        } from "./modules/collate.nf"
include { MAFFT          } from "./modules/mafft.nf"
include { TRIMAL         } from "./modules/trimal.nf"
include { IQTREE         } from "./modules/iqtree.nf"

workflow {
	ch_input = file(params.input)
	
	PARSE_METADATA(ch_input)

	PARSE_METADATA.out.gene_csv
	.splitCsv( header: true, sep: ',')
	.map { row -> file(row.gene) }
        .set { gene_ch }

        COLLATE(gene_ch.collect())

        if (params.no_mafft) {
                IQTREE(COLLATE.out.collate_ch)
        } else {
	        MAFFT(COLLATE.out.collate_ch)
        }

	if (params.mask_data) {
		TRIMAL(MAFFT.out.mafft_ch)
		IQTREE(TRIMAL.out.trimal_ch)
	} else {
		IQTREE(MAFFT.out.mafft_ch)
	}
}
