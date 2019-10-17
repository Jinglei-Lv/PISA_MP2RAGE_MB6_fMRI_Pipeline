wd=$1
subid=$2

for i in $wd/Preprocess/PISA_$subid/Task_log/PISA_${subid}*Viewing_1*.log
do
     logfile1=$i
     
done

for i in $wd/Preprocess/PISA_$subid/Task_log/PISA_${subid}*Viewing_2*.log
do
     logfile2=$i
done

echo $logfile1
echo $logfile2

TR=0.82
rmvolnum=10
outdir=$wd/Preprocess/PISA_$subid/Task_log/EVs
mkdir $outdir

matlab -nojvm -nodisplay -nosplash -r "addpath '${wd}/Pipeline'; parse_log('${logfile1}','${logfile2}',${TR},${rmvolnum},'${outdir}'); exit;"






