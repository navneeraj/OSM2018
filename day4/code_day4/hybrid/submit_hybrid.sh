#!/bin/bash
#SBATCH -N
#SBATCH --tasks-per-node=2
#SBATCH -c 8

export OMP_NUM_THREADS=4
module load openmpi

### hybrid executable
mpirun -np 1 ./1a.hello_world_hybrid.exec

