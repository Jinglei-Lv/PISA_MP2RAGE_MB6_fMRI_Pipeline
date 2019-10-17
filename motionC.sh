
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
