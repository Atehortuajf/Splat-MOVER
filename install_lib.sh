#!/bin/bash

python -m pip install --upgrade pip
python -m pip install setuptools==67.6.0

pip uninstall torch torchvision functorch tinycudann
python -m pip install --pre torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cu121

# install lang sam
git clone https://github.com/luca-medeiros/lang-segment-anything
pushd lang-segment-anything
git checkout a1a95572ba16b4661d8fb7b9388a998ce3391f95
rm pyproject.toml
cp ../pyproject_langsam.toml pyproject.toml # use our .toml file to avoid dependency conflicts
python -m pip install -e .
popd

# unused
conda install -c "nvidia/label/cuda-11.8.0" cuda-toolkit

# install tiny cuda nn
pip install ninja git+https://github.com/NVlabs/tiny-cuda-nn/#subdirectory=bindings/torch

# install these specific versions
pip install nerfstudio==1.1.0 gsplat==0.1.13 gradio-client=0.7.0 huggingface-hub==0.16.4
pip install -r requirements.txt

# install vrb
git clone https://github.com/shikharbahl/vrb
pushd vrb
pip install \
einops==0.6.1 \
scikit_learn==1.2.2 \
gdown \
tensorboard==2.13.0 \
ftfy \
regex \
tqdm \
torchtyping
mkdir models
bash download_model.sh
popd

# install graspnet
git clone https://github.com/graspnet/graspnet-baseline.git
pushd graspnet
pushd graspnet-baseline
pushd pointnet2
python setup.py install
popd
pushd knn
python setup.py install
git clone https://github.com/graspnet/graspnetAPI.git
pushd graspnetAPI
pip install .
popd
popd
popd
popd

# install clip
pip install git+https://github.com/openai/CLIP.git
python -m pip install -e .

# install groundingdino
git clone https://github.com/IDEA-Research/GroundingDINO
pushd GroundingDINO
pip install -e .
mkdir weights
pushd weights
wget -q https://github.com/IDEA-Research/GroundingDINO/releases/download/v0.1.0-alpha/groundingdino_swint_ogc.pth
popd
popd
