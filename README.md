
<p align="center">

  <h1 align="center">SplatBot: Modular Robotic Simulation Stack for Adaptive Scene Interaction</h1>
  <p align="center"> 
    <span class="author-block">
        <a>Juan Atehortúa</a><sup>&#42;</sup>,</span>
    <span class="author-block">
        <a>Chikaha Tsuji</a><sup>&#42;</sup>,</span>
    <span class="author-block">
        <a>Harrison Zhang</a><sup>&#42;</sup>,</span>
  </p>
  <p align="center"><strong>MIT</strong></p>
  <p align="center"><strong><sup>&#42;</sup>Equal Contribution.</strong></p>
</p>

## SplatBot
Abstract here.

## Installation
This project builds off [Splat-MOVER](https://splatmover.github.io), which utilizes [Nerfstudio](https://docs.nerf.studio/quickstart/installation.html), [GraspNet](https://github.com/graspnet/graspnet-baseline), and [VRB](https://github.com/shikharbahl/vrb). This repository has been verified to work with the following package versions: `nerfstudio==1.1.0`, `gsplat==0.1.13`, and `lang-sam` with commit SHA `a1a9557`.

1. In the base of the repo, set up environment variables and check that you have CUDA installed.
```
source env.sh
```
2. Set up `conda` environment `nerfstudio` with Python `3.10.0` and activate it.
```
conda create --name nerfstudio
conda activate nerfstudio  
conda install python==3.10
```
3. Create a new Python virtual environment and activate it.
```
python3.10 -m venv nerfstudio
source nerfstudio/bin/activate
python -m pip install --upgrade pip
```
4. Verify that your Python and pip version and path (should match venv path) are correct.
```
which pip
which python
python --version
```
5. Run the install script, which also installs the libraries in `requirements.txt`. You may ignore the `numpy` version resolution error if it comes up.
```
bash install_lib.sh
```
6. Check that CUDA and environment variables are set up correctly. If the below command errors, it is likely that `export TCNN_CUDA_ARCHITECTURES=80` is the incorrect version set in `env.sh`. Read the error and set `TCNN_CUDA_ARCHITECTURES` as the correct version.
```
python -c "import tinycudann"
```
Perform a quick sanity check here. The major version of CUDA that PyTorch is compiled with should match that of your drivers and compiler path. E.g. `12.4.*` and `12.1.*` is ok, while `11.8.*` and `12.1.*` is not.
```
nvidia-smi
which nvcc
nvcc --version
python -c "import torch; print('CUDA Available:', torch.cuda.is_available(), 'CUDA Version:', torch.version.cuda)"
```
7. Register `sagesplat` with Nerfstudio (sets up command line tools).
```
ns-install-cli
```
8. Now, you can run `sagesplat` like other models in Nerfstudio using the following command. This will generate a shareable link where you can visualize the training.
```
ns-train sagesplat --data <path to the data directory for a given scene> --viewer.websocket-port 7008 --viewer.make-share-url True
```
For instance, using part of our dataset below (assuming the data is unzipped in `data`):
```
ns-train sagesplat --data data/asknerf_pot_burner_orange_2 --viewer.websocket-port 7008 --viewer.make-share-url True
```
You can try out the data used in the experiments [here](https://drive.google.com/drive/folders/1rMsVu8iJ4sm1TCf52bX_gTJOGPKmAlfJ?usp=sharing).
