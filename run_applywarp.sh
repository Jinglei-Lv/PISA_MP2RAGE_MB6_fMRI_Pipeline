wd="/home/jingleil/Desktop/Jinglei_mnt/PISA_preprocess/MB6_New_pipeline"
rawdir="/home/jingleil/ldrive/Lab_ChristineG/JingleiL/PISA/Raw/MB6"
subid='473004'
EES='0.0006'      #Effective Echo Spacing time or Dwell time

pipelinedir="${wd}/Pipeline"

#bash $pipelinedir/cpfile_chdcm2nii.sh $wd $subid $rawdir

#bash $pipelinedir/T1_Bet.sh $wd $subid

#bash $pipelinedir/Run_topup.sh $wd $subid $EES

#bash $pipelinedir/Run_feat_prepro.sh $wd $subid

bash $pipelinedir/applywarp2filterdfMRI.sh $wd $subid

