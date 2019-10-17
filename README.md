# PISA-pipeline
Preprocessing pipeline for the PISA project: Prospective Imaging Study of Aging

1. This pipeline depends on the HCP pipeline for fMRI distortion correction. Refer to the following link for setup information.
   https://github.com/Washington-University/HCPpipelines
   Change the path of HCP pipeline in the first line of MotionC_Topup_BasedonHCP.sh.
    "source /home/jingleil/bin/HCP-Pipelines-master/Examples/Scripts/SetUpHCPPipeline.sh"
2. runall_temp.sh is a template to generate indivisual pipeline 
   See examples in /Examples.
3. Function list:
   1) f1*  Copy file + change to nifiti + organize output folder.
   2) f2*  T1 skullp removal.
   3) f3*  Topup distortion correction.
   4) f4*  fMRI preprocessing with feat.
   5) f5*  Warp fMRI to std space.
   6) f6*  Copy fMRI task log files.
   7) f7*  Parse the task log files.
   8) f8*  Model the fMRI activation with feat.
 4. How to run?
    Change the prefix "PISA" in relevent files to your own project.
    Please refer to the PISA data folder for raw data organization.
      L:\Lab_ChristineG\JingleiL\PISA\Raw\MB6
    Make sure the paths are well sorted.
    In your work directory, creat the following folders "Pipeline" - Where this pipeline stays.
                                                         "Preprocess"- Where the preprocessed data stays.
                                                         "Runs"- Where run scipt stays (The files in /Example)
                                                          "script_log"- where the .sh .log .err for each subject stays.
 5.  Set the wd in the scripts of "mkscript_run_xxxx.sh"  and "runall_temp.sh"
 6.  Run the mkscript_run_xxxx.sh in a terminal.


# Note:
  1. Make sure fsl, Freesurfer, Mrtrix is installed and well configured in the profile.
  dcminfo is a tool used from Mrtrix.
  2. Check the raw data folder and make sure it's well named and organized.  And delete duplicated scans because some scans especially the fMRI scans, were suspended and restarted. If youdon't delete the them the pipeline wouldn't run.
  3. In "check_phase_encoding_dir.sh", make changes based on the Mrtrix version.
     If MRtrix 3.0_RC2, set the ispos as "ispos=$(dcminfo ${file1} -csa|grep PhaseEncodingDirectionPositive|awk '{print $3}')" .
     if MrTRIX 3.0_RC3, set the ispos as "ispos=$(dcminfo ${file1} -csa|grep PhaseEncodingDirectionPositive|awk '{print $5}')" .
  4. To use the "MotionC_Topup_BasedonHCP.sh"  Set the corrrect path for HCP pipeline.
      source /home/jiahuiw/bin/HCP-Pipelines-master/Examples/Scripts/SetUpHCPPipeline.sh
  5. Before you run, change the permission of all HCP scipts executable.
