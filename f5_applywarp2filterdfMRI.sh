wd=${1}
subid=${2}

subid=PISA_${subid}

prefolder=${wd}/Preprocess/${subid}
featfolder=$prefolder/PA_TASK/PA_TASK_rm10_mc_dc_jac.feat



/usr/share/fsl/5.0/bin/applywarp --ref=${featfolder}/reg/standard --in=${featfolder}/filtered_func_data.nii.gz --out=${featfolder}/filtered_func_data_std.nii.gz --warp=${featfolder}/reg/highres2standard_warp --premat=${featfolder}/reg/example_func2highres.mat --interp=spline

