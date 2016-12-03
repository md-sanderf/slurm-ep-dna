#!/bin/bash
#
#SBATCH --job-name=megacc-dna-ep-test
#SBATCH --output=megacc-dna-ep-test-stdout.txt
#SBATCH --array=1 #the array size 
#SBATCH --ntasks=1
#SBATCH --time=10:00
#SBATCH --mem-per-cpu=200

val=$(sed "${SLURM_ARRAY_TASK_ID}q;d" /home/tuf79348/ep_env/testlist2.txt)
echo $val
mao=/home/tuf79348/ep_env/ancestral_seqs_ML_predict_living_seqs_nucleotide.mao
echo $mao
aln=/home/tuf79348/ep_env/${val}_58.fas
echo $aln
tree=/home/tuf79348/ep_env/${val}_58.nwk
echo $tree
output=/home/tuf79348/ep_env/${val}_58.csv
echo $output
args=$mao\ $aln\ $tree\ $output
echo $args

srun echo running megacc calculations for $val
echo /home/tuf79348/ep_env/megacc_7161102 -a $mao -d $aln -t $tree -o $output
#srun /home/tuf79348/ep_env/megacc_7161102 -a $mao -d $aln -t $tree -o $output
bash run_ep.sh $args
srun echo finished megacc calculations for $val
