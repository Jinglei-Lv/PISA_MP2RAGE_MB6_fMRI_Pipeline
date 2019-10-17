

# 1 WoringDir 2 inputfmri 3 Reference_volume 4 Neg_seq 5 Pos_seq (Pos: AP   Neg: PA) 6 UnwarpDir y- for PA 7 fmridir 8 DwellTime

source /home/jingleil/bin/HCP-Pipelines-master/Examples/Scripts/SetUpHCPPipeline.sh

WorkingDirectory="$1"
InputfMRI="$2"
Ref="$3"
PhaseEncodeNegative="$4"
PhaseEncodePositive="$5"
UnwarpDir="$6"
fmridir="$7"
DwellTime="$8"  #Effective echo spacing time

PipelineScripts=${HCPPIPEDIR_fMRIVol}
GlobalScripts=${HCPPIPEDIR_Global}

MovementRegressor="Movement_Regressors" #No extension, .txt appended
MotionMatrixFolder="MotionMatrices"
MotionMatrixPrefix="MAT_"
MotionCorrectionType="MCFLIRT"



echo "Running Motion Correction..."
	mkdir -p "$fmridir"/MotionCorrection
	${RUN} "$PipelineScripts"/MotionCorrection.sh \
	    "$fmridir"/MotionCorrection \
	    "$fmridir"/"$InputfMRI" \
	    "$WorkingDirectory"/"$Ref" \
	    "$fmridir"/"$InputfMRI"_mc \
	    "$fmridir"/"$MovementRegressor" \
	    "$fmridir"/"$MotionMatrixFolder" \
	    "$MotionMatrixPrefix" \
	    "$MotionCorrectionType"

   


echo "Running Topup..."

# Use topup to distortion correct the ref scans
        # using a blip-reversed GE/SE pair "fieldmap" sequence

TopupConfig="${HCPPIPEDIR_Config}/b02b0.cnf"
GradientDistortionCoeffs="NONE"
UseJacobian="true"

mkdir -p "$WorkingDirectory"/FieldMap
${GlobalScripts}/TopupPreprocessingAll.sh \
    --workingdir=${WorkingDirectory}/FieldMap \
    --phaseone=${WorkingDirectory}/${PhaseEncodeNegative} \
    --phasetwo=${WorkingDirectory}/${PhaseEncodePositive} \
    --scoutin=${WorkingDirectory}/${Ref} \
    --echospacing=${DwellTime} \
    --unwarpdir=${UnwarpDir} \
    --owarp=${WorkingDirectory}/WarpField \
    --ojacobian=${WorkingDirectory}/Jacobian \
    --gdcoeffs=${GradientDistortionCoeffs} \
    --topupconfig=${TopupConfig} \
    --usejacobian=${UseJacobian}

echo "Apply Topup to fmri_mc..."

${FSLDIR}/bin/applywarp --rel --interp=spline -i ${fmridir}/${InputfMRI}_mc -r ${WorkingDirectory}/$Ref -w ${WorkingDirectory}/WarpField -o ${fmridir}/${InputfMRI}_mc_dc
${FSLDIR}/bin/fslmaths ${fmridir}/${InputfMRI}_mc_dc -mul ${WorkingDirectory}/Jacobian ${fmridir}/${InputfMRI}_mc_dc_jac









