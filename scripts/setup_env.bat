@echo off
set LOG=%USERPROFILE%\Documents\Kolb_Radar_Project\outputs\setup_env.txt
set CONDA=%USERPROFILE%\anaconda3\Scripts\conda.exe
set PY=%USERPROFILE%\anaconda3\envs\kolb\python.exe
echo START %DATE% %TIME% > "%LOG%"
if not exist "%PY%" (
  "%CONDA%" create -n kolb python=3.11 -y >> "%LOG%" 2>&1
)
"%CONDA%" install -n kolb git -y >> "%LOG%" 2>&1
"%PY%" -m pip install --upgrade pip >> "%LOG%" 2>&1
"%PY%" -m pip install torch==2.5.1 --index-url https://download.pytorch.org/whl/cu121 >> "%LOG%" 2>&1
"%PY%" -m pip install numpy==1.26.4 scipy==1.14.1 matplotlib==3.10.0 trimesh==4.6.3 pyvista==0.44.2 ipykernel nbconvert nbformat mitsuba==3.3.0 >> "%LOG%" 2>&1
"%PY%" -m ipykernel install --user --name kolb --display-name "Python (kolb)" >> "%LOG%" 2>&1
cd /d %USERPROFILE%\Documents\Kolb_Radar_Project
if not exist InverseThzSim (
  "%USERPROFILE%\anaconda3\envs\kolb\Library\bin\git.exe" clone https://github.com/memamsaleh/InverseThzSim InverseThzSim >> "%LOG%" 2>&1
)
"%PY%" -c "import torch, numpy, mitsuba as mi, drjit as dr; print('torch', torch.__version__, torch.cuda.is_available(), torch.cuda.get_device_name(0)); print('numpy', numpy.__version__); print('mitsuba', mi.__version__, 'drjit', dr.__version__); print(mi.variants())" >> "%LOG%" 2>&1
"%PY%" -c "import mitsuba as mi; mi.set_variant('cuda_ad_rgb'); s=mi.load_dict({'type':'scene','sp':{'type':'sphere'}}); r=mi.Ray3f(mi.Point3f(0,0,-5),mi.Vector3f(0,0,1)); print('cuda ray test hit:', s.ray_intersect(r).is_valid())" >> "%LOG%" 2>&1
echo SETUP_DONE %DATE% %TIME% >> "%LOG%"
