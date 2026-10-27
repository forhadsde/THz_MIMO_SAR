@echo off
rem usage: run_gen.bat NWORKERS BUDGET_HOURS
set P=%USERPROFILE%\Documents\Kolb_Radar_Project
set PY=%USERPROFILE%\anaconda3\envs\kolb\python.exe
set PYTHONIOENCODING=utf-8
set KOLB_NWORKERS=%1
set KOLB_BUDGET_HOURS=%2
cd /d %P%\notebooks
for /L %%i in (1,1,%1) do call :launch %%i
goto :eof
:launch
set /a W=%1-1
start "kolb_gen_%W%" /min cmd /c "set KOLB_WORKER=%W%&& "%PY%" -m jupyter nbconvert --to notebook --execute --ExecutePreprocessor.kernel_name=kolb --ExecutePreprocessor.timeout=-1 --output-dir=%P%\outputs\logs --output 03_worker_%W%.ipynb 03_generate_synthetic_dataset.ipynb > %P%\outputs\logs\03_worker_%W%.txt 2>&1"
goto :eof
