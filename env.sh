#!/bin/bash

# base repo is in scratch
export PROJ_HOME=$SCRATCH
echo "PROJ_HOME is $PROJ_HOME"

module purge
module load anaconda/2021.05-py38
module load modtree/gpu
module load gcc/11.2.0
module load cmake/3.20.0
module load cuda/12.0.1
module list

export SPLAT_HOME=$PROJ_HOME/splat-mover
export SPLAT_DATASET_PATH=$SPLAT_HOME/data

conda activate nerfstudio
if [ -d "$SPLAT_HOME/nerfstudio/bin" ]; then
    source "$SPLAT_HOME/nerfstudio/bin/activate"
else
    echo "python venv 'nerfstudio' does not exist, did you run 'install_lib.sh'?"
fi

export OMP_NUM_THREADS=32
export RAFT_HOME=$PROJ_HOME/raft/cpp
export OPENBLAS_HOME=$PROJ_HOME/openblas
export LIB64=/usr/lib64

export CUDA_HOME=$(dirname $(which nvcc))/..

# ensure we can link against libcuda.so (stubs)
export LD_LIBRARY_PATH=$SPLAT_HOME/nerfstudio/lib64/python3.10/site-packages/nvidia/nvjitlink/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$LIB64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$PROJ_HOME/.conda/envs/2021.05-py38/nerfstudio/lib/stubs:$LD_LIBRARY_PATH

# for x86(-64) architecture only
export TCNN_CUDA_ARCHITECTURES=80

# workaround for ENOENT error
VSCODE_IPC_HOOK_CLI=$( lsof | grep $UID/vscode-ipc | awk '{print $(NF-1)}' | head -n 1 )
