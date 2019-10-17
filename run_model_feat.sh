wd="/home/jingleil/Desktop/Jinglei_mnt/PISA_preprocess/MB6_New_pipeline"
rawdir="/home/jingleil/ldrive/Lab_ChristineG/JingleiL/PISA/Raw/MB6"

for subid in $(cat ./back_up/ids2_1.txt)
do
   echo $subid
   nohup ${wd}/Pipeline/Run_feat_model.sh $wd $subid 1>${wd}/script_log/${subid}_model_feat.log 2>${wd}/script_log/${subid}_model_feat.err &
 

done
