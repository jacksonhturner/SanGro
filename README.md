![sangro](https://github.com/jacksonhturner/SanGro/assets/80480626/be642ebd-b66e-4097-a8f1-cbe7dcba3cde)

# SanGro: Phylogenetic Analysis from Sanger Sequences

SanGro is a simple phylogenetics pipeline executed through nextflow designed to construct a phylogeny from single gene sequences such as Sanger sequencing results or viral genes. It accomplishes this by collating individual sequence files into a multiple sequence file with a custom python script (`COLLATE`), aligning the resulting file with `mafft` (`MAFFT`), masking the alignment for missing data with `trimal` (`TRIMAL`), and creating a ML phylogeny by `iqtree2` (`IQTREE`). 

### Why use SanGro?

* Automated through nextflow with minimal user input
* Designed for single sequences
* Scalable and customizeable for custom use
* Fast, often producing trees from sequences in >5 minutes
## Input/Output

* Input: metadata file, shell script
* Output: ML phylogeny

### Metadata

A metadata .csv file is required to initiate SanGro. This file is structured in the following format:

```
id,gene
taxonA,/file/path/to/taxonA.fasta
taxonB,/file/path/to/taxonB.fasta
```

The `id` column represents the name of the taxon to be represented in the phylogeny and the `gene` column denotes a full path to the sequence file.

### Shell script

SanGro is initiated through a shell script that resembles the following:

```
nextflow run ../sangro/main.nf \
  --input metadata.csv \
  --publish_dir test_run/ \
  --masking_threshold 0.4 \
  -profile local, eight \
  -resume
```

### Parameters

There are five possible parameters, which are listed below:

| parameter | description | is required? | input type | 
| :--- | :--- | :--- | :--- |
| --input | a file path to the metadata file | yes | string |
| --publish-dir | a directory where output will be stored | yes | string |
| --masking_threshold | the percentage of missing data required for masking | no | value |
| --no_mafft | bypass the alignment step with mafft, off by default | no | boolean |
| --mask_data | mask missing data with trimal, defaults to no | no | boolean |
| -profile | a profile detailing computational requirements of job | yes | string |
| -resume | if pipeline is suspended and reinitiated, it will begin where it left off | no | N/A |

### Profiles

Configuration files located in `sangro/config/local.conf` are referenced by SanGro to determine the computational requirements of the pipeline. Two profiles exist, `local, four` which designates four cores to SanGro, and `local, eight` which designates eight. One must be chosen in the `-probile` parameter within the shell script to initiate SanGro.

## Installation and Dependencies

SanGro requires nextflow and singularity to run. 
Clone github repository to install SanGro.

## Quick start

An example run of SanGro using Diptera COI sequences is provided in `sangro/example_run`. Sample sequences for this example are stored in `sangro/example_run/sequence_data`. 

This dataset is designed to test the monophyly of *Aedes*, *Anopheles*, and *Culex* within Culicidae using two Dixidae specimens as outgroup taxa.

Metadata of sequences is provided below:

| id | organism | NCBI accession number |
| --- | --- | --- |
| Daestiv | *Dixella aestivalis* | NC_029354.1 |
| Dsubmac | *Dixa submaculata* | KX453764.1 |
| Acinreus | *Aedes cinreus* | OP828905.1 |
| Avexans | *Aedes vexans* | KC855606.1 |
| Cspinosus | *Culex spinosus* | KM593059.1 |
| Cdeclarator | *Culex declarator* | KM593057.1 |
| Aneomac | *Anopheles neomaculipalpus* | KM592986.1 |
| Akleini | *Anopheles kleini* | KC855665.1 |
| Alesteri | *Anopheles lesteri* | KC855664.1 |

To run SanGro, execute the shell script provided in `sangro/example_run/run_sangro.sh` with the following command within the `sangro/example_run` directory:

```
sh run_sangro.sh
```

Upon initiation, the nextflow interface will appear and the pipeline will run to completion or exit due to an error.

Output of SanGro is stored in the directory created by the `--publish-dir` parameter within the `run_sangro.sh` shell script.

For this example, access results by navigating to `test_run/project/publish/iqtree` and downloading the `trimal.treefile` file inside it.

The phylogeny produced by SanGro may be vizualised by importing `trimal.treefile` into a program such as iTOL or FigTree. The resulting phylogeny, appropriately rooted upon the clade representing Dixidae, is shown below:

(image goes here)

## Troubleshooting

The most commonly observed error is the termination of SanGro in the `PARSE_METADATA` step of the pipeline. This is often due to the incorrect input of data in the `metadata.csv` input file. If this occurs, ensure this file is correctly populated with sequence information and paths.

If other errors are encountered, please submit a comment in the `Issues` tab of this github page so that they may be promptly addressed and resolved. 
