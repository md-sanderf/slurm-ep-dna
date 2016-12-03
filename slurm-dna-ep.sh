#!/bin/bash
#
#SBATCH --job-name=dna-ep
#SBATCH --output=slurm-dna-ep-stdout.txt
#
#SBATCH --ntasks=3
#SBATCH --time=10:00
#SBATCH --mem-per-cpu=200

val=$(sed "${SLURM_ARRAY_TASK_ID}q;d" /home/tuf79348/ep_env/testlist.txt)

srun hostname
srun echo running dna_ep_setup.py $val
srun /home/tuf79348/ep_env/bin/python /home/tuf79348/ep_env/dna_ep_setup.py $val
srun echo finished dna_ep_setup.py $val

srun echo running megacc calculations for $val
srun /home/tuf79348/ep_env/megacc -a /home/tuf79348/ep_env/####.mao -d /tmp/$val_1.fasta -t /tmp/$val_1.nwk -o /tmp/$val_1.csv
srun /home/tuf79348/ep_env/megacc -a /home/tuf79348/ep_env/####.mao -d /tmp/$val_2.fasta -t /tmp/$val_2.nwk -o /tmp/$val_2.csv
srun /home/tuf79348/ep_env/megacc -a /home/tuf79348/ep_env/####.mao -d /tmp/$val_3.fasta -t /tmp/$val_3.nwk -o /tmp/$val_3.csv
srun /home/tuf79348/ep_env/megacc -a /home/tuf79348/ep_env/####.mao -d /tmp/$val_4.fasta -t /tmp/$val_4.nwk -o /tmp/$val_4.csv
srun /home/tuf79348/ep_env/megacc -a /home/tuf79348/ep_env/####.mao -d /tmp/$val_5.fasta -t /tmp/$val_5.nwk -o /tmp/$val_5.csv
srun /home/tuf79348/ep_env/megacc -a /home/tuf79348/ep_env/####.mao -d /tmp/$val_6.fasta -t /tmp/$val_6.nwk -o /tmp/$val_6.csv
srun /home/tuf79348/ep_env/megacc -a /home/tuf79348/ep_env/####.mao -d /tmp/$val_7.fasta -t /tmp/$val_7.nwk -o /tmp/$val_7.csv
srun /home/tuf79348/ep_env/megacc -a /home/tuf79348/ep_env/####.mao -d /tmp/$val_8.fasta -t /tmp/$val_8.nwk -o /tmp/$val_8.csv
srun /home/tuf79348/ep_env/megacc -a /home/tuf79348/ep_env/####.mao -d /tmp/$val_9.fasta -t /tmp/$val_9.nwk -o /tmp/$val_9.csv
srun /home/tuf79348/ep_env/megacc -a /home/tuf79348/ep_env/####.mao -d /tmp/$val_10.fasta -t /tmp/$val_10.nwk -o /tmp/$val_10.csv
srun /home/tuf79348/ep_env/megacc -a /home/tuf79348/ep_env/####.mao -d /tmp/$val_11.fasta -t /tmp/$val_11.nwk -o /tmp/$val_11.csv
srun echo finished megacc calculations for $val

srun echo running dna_ep_recombination.py for $val
srun /home/tuf79348/ep_env/bin/python /home/tuf79348/ep_env/dna_ep_recombination.py $val /home/tuf79348/ep_env/results
srun echo finished dna_ep_recombination.py for $val
