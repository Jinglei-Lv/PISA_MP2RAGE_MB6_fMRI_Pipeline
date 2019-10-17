wd=${1}
subid=${2}
subid=PISA_${subid}


prefolder=${wd}/Preprocess/${subid}
inputfolder=$prefolder/PA_TASK

cp $wd/Pipeline/temp_model.fsf ${inputfolder}/temp.fsf

substr=

strtmp=$(echo s:@TEMPinputfolder:${prefolder}:)
sed ${strtmp} <${inputfolder}/temp.fsf > ${inputfolder}/model.fsf

rm ${inputfolder}/temp.fsf

feat ${inputfolder}/model.fsf
