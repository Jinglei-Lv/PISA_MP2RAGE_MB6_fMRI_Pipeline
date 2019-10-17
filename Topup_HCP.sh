

# 1 WoringDir 2 Neg_seq 3 Pos_seq (Pos: AP   Neg: PA) 4 Ref.nii.gz 5 Effective Echo Spacing (in s) 6 UnwarpDir y- for PA

source /home/jingleil/bin/HCP-Pipelines-master/Examples/Scripts/SetUpHCPPipeline.sh

WorkingDirectory="$1"
PhaseEncodeNegative="$2"
PhaseEncodePositive="$3"
Ref="$4"
DwellTime="$5"
UnwarpDir="$6"

PipelineScripts=${HCPPIPEDIR_fMRIVol}
GlobalScripts=${HCPPIPEDIR_Global}


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









