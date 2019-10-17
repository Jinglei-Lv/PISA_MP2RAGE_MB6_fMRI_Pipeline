wd=${1}
subid=${2}

subid=PISA_${subid}

prefolder=${wd}/Preprocess/${subid}
inputfolder=$prefolder/PA_TASK
structfolder=$prefolder/T1

cp $wd/Pipeline/temp_pre.fsf ${inputfolder}/pre.fsf

strtmp=$(echo s:TEMPinputdir:${inputfolder}:)
sed ${strtmp} <${inputfolder}/pre.fsf > ${inputfolder}/tmp.fsf

#MAIN STRUCTURAL
strtmp=$(echo s:TEMPstructdir:${structfolder}:)
sed ${strtmp} <${inputfolder}/tmp.fsf > ${inputfolder}/pre.fsf
rm ${inputfolder}/tmp.fsf

feat ${inputfolder}/pre.fsf
