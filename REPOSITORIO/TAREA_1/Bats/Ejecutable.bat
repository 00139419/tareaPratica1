@echo off
setlocal
cd "C:\Program Files (Arm)\pdi-ce-9.4.0.0-343\data-integration"
start "Ejecutando ETL" /wait "C:\BATS\Ejecutable.bat" /file:"C:\REPOSITORIO\TAREA_1\Jobs\J_Main.kjb"