@echo off
rem usage: run_nb.bat NOTEBOOK_BASENAME  (environment variables KOLB_* are passed through)
set NB=%1
set P=%USERPROFILE%\Documents\Kolb_Radar_Project
set PY=%USERPROFILE%\anaconda3\envs\kolb\python.exe
set PYTHONIOENCODING=utf-8
cd /d %P%\notebooks
echo START %NB% %DATE% %TIME% > "%P%\outputs\run_%NB%.txt"
"%PY%" -m jupyter nbconvert --to notebook --execute --inplace --ExecutePreprocessor.kernel_name=kolb --ExecutePreprocessor.timeout=-1 %NB%.ipynb >> "%P%\outputs\run_%NB%.txt" 2>&1
echo EXIT %ERRORLEVEL% %DATE% %TIME% >> "%P%\outputs\run_%NB%.txt"
