
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

    bet ${T1folder}/T1.nii.gz ${T1folder}/T1_brain.nii.gz -f 0.3 -R -S -B

fi
