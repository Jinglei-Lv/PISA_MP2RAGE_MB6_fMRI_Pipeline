wd=$1
subid=$2
rawdir=$3

#subid= XXXX
#wd=/home/jingleil/Desktop/Jinglei_mnt/PISA_preprocess/MB6_New_pipeline/Pipeline/
#rawdir=/home/jingleil/ldrive/Lab_ChristineG/JingleiL/PISA/Raw/MB6/

if [ -d $wd/Preprocess/PISA_$subid/Task_log ]
then
    echo "PISA_$subid   log folder exist! Please check!"
else
	
	predir=$wd/Preprocess/PISA_$subid


	if [ -d "${rawdir}/PISA_${subid}_01" ]; then
	  rawdir=${rawdir}/PISA_${subid}_01
	else
	  rawdir=${rawdir}/PISA_${subid}
	fi

        cp -r ${rawdir}/Task_log ${predir}/Task_log

	
fi





