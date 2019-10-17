wd=$1
subid=$2
rawdir=$3

#subid= XXXX
#wd=/home/jingleil/Desktop/Jinglei_mnt/PISA_preprocess/MB6_New_pipeline/Pipeline/
#rawdir=/home/jingleil/ldrive/Lab_ChristineG/JingleiL/PISA/Raw/MB6/

if [ -d $wd/Preprocess/PISA_$subid ]
then
    echo "PISA_$subid folder exist! Please check!"
else
	mkdir $wd/Preprocess/PISA_$subid
	predir=$wd/Preprocess/PISA_$subid


	if [ -d "${rawdir}/PISA_${subid}_01" ]; then
	  rawdir=${rawdir}/PISA_${subid}_01
	else
	  rawdir=${rawdir}/PISA_${subid}
	fi
        cp -r ${rawdir}/Task_log ${predir}/Task_log

	if [ -d "${rawdir}/PISA_${subid}_01_${subid}" ]; then
	  rawmridir=${rawdir}/PISA_${subid}_01_${subid}
	elif [ -d "${rawdir}/PISA_${subid}_01_${subid}_01" ]; then
	  rawmridir=${rawdir}/PISA_${subid}_01_${subid}_01
	elif [ -d "${rawdir}/PISA_${subid}_01_${subid}" ]; then
	  rawmridir=${rawdir}/PISA_${subid}_01_${subid}
	elif [ -d "${rawdir}/PISA_${subid}_01_PISA_${subid}_01" ]; then
	  rawmridir=${rawdir}/PISA_${subid}_01_PISA_${subid}_01
	elif [ -d "${rawdir}/PISA_${subid}_${subid}" ]; then
	  rawmridir=${rawdir}/PISA_${subid}_${subid}
	elif [ -d "${rawdir}/PISA_${subid}_PISA_${subid}" ]; then
	  rawmridir=${rawdir}/PISA_${subid}_PISA_${subid}
	fi

	echo $rawmridir

	cp -r ${rawmridir}/*MP2RAGE*UNI-DEN* ${predir}/T1
	cp -r ${rawmridir}/AP*SE_FMAP* ${predir}/AP_SE
	cp -r ${rawmridir}/PA*SE_FMAP* ${predir}/PA_SE
	cp -r ${rawmridir}/*SE_FMAP_AP* ${predir}/AP_SE
	cp -r ${rawmridir}/*SE_FMAP_PA* ${predir}/PA_SE   		
	cp -r ${rawmridir}/*NEWS_CLIP_*_EP2D_BOLD_MB6_* ${predir}/PA_TASK

	cp -r ${rawmridir}/B*/*MP2RAGE*UNI-DEN* ${predir}/T1
	cp -r ${rawmridir}/B*/AP*SE_FMAP* ${predir}/AP_SE
	cp -r ${rawmridir}/B*/PA*SE_FMAP* ${predir}/PA_SE
	cp -r ${rawmridir}/B*/*SE_FMAP_AP* ${predir}/AP_SE
	cp -r ${rawmridir}/B*/*SE_FMAP_PA* ${predir}/PA_SE   		
	cp -r ${rawmridir}/B*/*NEWS_CLIP_*_EP2D_BOLD_MB6_* ${predir}/PA_TASK

	  
	for i in ${predir}/*
	do
	   echo $i
	   if [ -d "$i" ]; then
		   cd $i
		   rm *.nii.*
		   dcm2nii -a y *.IMA
		   rm *.IMA

	   fi


	done

	cp ${predir}/T1/co*.nii.gz ${predir}/T1/T1.nii.gz
	cp ${predir}/PA_SE/*.nii.gz ${predir}/PA_SE/PA_SE.nii.gz
	cp ${predir}/AP_SE/*.nii.gz ${predir}/AP_SE/AP_SE.nii.gz
	cp ${predir}/PA_TASK/*.nii.gz ${predir}/PA_TASK/PA_TASK.nii.gz
fi





