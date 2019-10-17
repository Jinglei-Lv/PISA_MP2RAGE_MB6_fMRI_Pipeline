#!/bin/bash

wd="/home/jingleil/Desktop/Jinglei_mnt/PISA_preprocess/MB6_New_pipeline"
rawdir="/home/jingleil/ldrive/Lab_ChristineG/JingleiL/PISA/Raw/MB6"
subid='@ID'
EES='0.0006'      #Effective Echo Spacing time or Dwell time

pipelinedir="${wd}/Pipeline"

 $pipelinedir/f1_cpfile_chdcm2nii.sh $wd $subid $rawdir

    strap=$(fslhd ${wd}/Preprocess/PISA_${subid}/AP_SE/AP_SE)
    if [[ ${strap} = *"phaseDir=+"* ]] 
    then
        str1='Y'
    else
        str1='N'
    fi
   
    strpa=$(fslhd ${wd}/Preprocess/PISA_${subid}/PA_SE/PA_SE)
    if [[ ${strpa} = *"phaseDir=-"* ]] 
    then
        str2='Y'
    else
        str2='N'
    fi
    

strall="$str1 $str2"

if [[ ${strall} = "Y Y" ]]
then
    echo "$strall"

     $pipelinedir/f2_T1_processFSall.sh $wd $subid

     $pipelinedir/f3_Run_topup.sh $wd $subid $EES

     $pipelinedir/f4_Run_feat_prepro.sh $wd $subid

     $pipelinedir/f5_applywarp2filterdfMRI.sh $wd $subid
    
     $pipelinedir/f6_cp_task_log_only.sh $wd $subid $rawdir

     $pipelinedir/f7_run_parse_log.sh $wd $subid

     $pipelinedir/f8_Run_feat_model.sh $wd $subid

else
    echo "AP:${str1} PA:${str2} Fild map was not set with correct phase encoding direction."
fi



