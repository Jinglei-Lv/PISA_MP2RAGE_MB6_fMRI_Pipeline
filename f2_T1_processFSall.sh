#!/bin/bash
# file: processFSall

wd=$1
subid=$2

subid=PISA_${subid}
T1folder=${wd}/Preprocess/${subid}/T1

if [ -f ${T1folder}/T1_brain.nii.gz ]
then 
    echo "T1_brain exist! Skipping T1 preprocessing."
else
	rawfolder=${T1folder}/Raw/Data
	SUBJECTS_DIR=${T1folder}/FS
	mkdir -p ${rawfolder}
	mkdir -p ${SUBJECTS_DIR}
	mv ${T1folder}/T1.nii.gz ${rawfolder}/

	recon-all -all -i ${rawfolder}/T1.nii.gz -subjid Data -sd ${SUBJECTS_DIR} -no-isrunning -mprage

	cp ${SUBJECTS_DIR}/Data/mri/brain.mgz ${T1folder}/brain.mgz
	cp ${SUBJECTS_DIR}/Data/mri/T1.mgz ${T1folder}/T1.mgz

	mrconvert ${T1folder}/brain.mgz ${T1folder}/T1_brain.nii.gz
	mrconvert ${T1folder}/T1.mgz ${T1folder}/T1.nii.gz

fi




