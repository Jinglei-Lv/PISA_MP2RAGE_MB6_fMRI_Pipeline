wd=$1
subid=$2
EES=$3      #Effective Echo Spacing time or Dwell time
subid=PISA_$2

prefolder=${wd}/Preprocess/${subid}


 mkdir $prefolder/Topup
 echo Topup
 vnum=$(fslval $prefolder/PA_TASK/PA_TASK.nii.gz dim4)
 echo "Volume number: $vnum"
 rmnum=10
 nvnum=$((${vnum}-${rmnum}))
 echo "Volume number: $nvnum"
 fslroi $prefolder/PA_TASK/PA_TASK.nii.gz $prefolder/PA_TASK/PA_TASK_rm10.nii.gz 10 $nvnum
 fslroi $prefolder/PA_TASK/PA_TASK_rm10.nii.gz $prefolder/Topup/Ref_Task 0 1
 
    str=$(fslhd $prefolder/PA_TASK/PA_TASK.nii.gz)
    if [[ ${str} = *"phaseDir=-"* ]] 
    then
        unwarpdir='y-'
    else
        unwarpdir='y'
    fi

 echo "The unwarping direction for fMRI is ${unwarpdir}"

 cp $prefolder/AP_SE/AP_SE.nii.gz  $prefolder/Topup/SE_AP.nii.gz
 cp $prefolder/PA_SE/PA_SE.nii.gz  $prefolder/Topup/SE_PA.nii.gz

${wd}/Pipeline/MotionC_Topup_BasedonHCP.sh ${prefolder}/Topup PA_TASK_rm10 Ref_Task SE_PA SE_AP ${unwarpdir} ${prefolder}/PA_TASK ${EES}

