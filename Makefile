

SRC := src
DATA := data
PROCESSED := processed

ENV_TCGA=TCGA_synapse


Tissues = BRCA HNSC KIRP LIHC MESO READ STAD THCA UCS CESC COAD FPPP KICH LAML LUAD OV PCPG SARC THYM UVM BLCA CHOL BLBC GBM KIRC LGG LUSC PAAD PRAD SKCM TGCT

############ Donload Synapse TCGA data #################
data:
	source activate $(ENV_TCGA); python $(SRC)/Obtain_data.py

############## Process mutation data ###################

PATHMT = IlluminaGA_DNASeq
MTData = $(addsuffix /Mutation.csv, $(addprefix $(PROCESSED)/, $(Tissues)))

PROCESS_MT: $(MTData)


$(MTData):	$(PROCESSED)/%/Mutation.csv:	
	mkdir -p $(PROCESSED)/$*
	python $(SRC)/Process_DNASeq.py $@ `ls data/$*/*/*.maf`
	#$(DATA)/$*/$(PATHMT)/genome.wustl.edu_$*_IlluminaGA_DNASeq.maf


