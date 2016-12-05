#!/bin/bash
#
#SBATCH --job-name=megacc-dna-ep-test
#SBATCH --output=megacc-dna-ep-test-stdout.txt
#SBATCH --array=1 #the array size 
#SBATCH --ntasks=1
#SBATCH --time=10:00
#SBATCH --mem-per-cpu=2000

module load openmpi #load openMPI

val=$(sed "${SLURM_ARRAY_TASK_ID}q;d" /home/tuf79348/ep_env/testlist2.txt)
echo $val
mao=/home/tuf79348/ep_env/ancestral_seqs_ML_predict_living_seqs_nucleotide.mao
tempmao=/scratch/ancestral_seqs_ML_predict_living_seqs_nucleotide.mao
cp $mao $tempmao
echo $mao
echo $tempmao
aln=/home/tuf79348/ep_env/${val}_58.fas
tempaln=/scratch/${val}_58.fas
cp $aln $tempaln
echo $aln
echo $tempaln
tree=/home/tuf79348/ep_env/${val}_58.nwk
temptree=/scratch/${val}_58.nwk
cp $tree $temptree
echo $tree
echo $temptree
output=/home/tuf79348/ep_env/${val}_58.csv
tempoutput=/scratch/${val}_58.csv
echo $output
echo $tempoutput
args=$tempmao\ $tempaln\ $temptree\ $tempoutput

echo running megacc calculations for $val
echo $args
#srun /home/tuf79348/ep_env/megacc_7161102 -a $mao -d $aln -t $tree -o $output
bash /home/tuf79348/ep_env/slurm-ep-dna-git/run_ep.sh $args
echo finished megacc calculations for $val
rm $tempmao
rm $tempaln
rm $temptree
cp $tempoutput $output
echo finished processing $val
