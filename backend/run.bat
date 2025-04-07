@echo off

set venv=venv
where python >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    goto :found_python
) ELSE (
    echo Python nao encontrado. Instale ou configure como caminho do sistema.
)

:found_python
if not exist %venv% (
    echo Criando ambiente virtual...
    python -m venv %venv% 
    echo Ambiente virtal criado.
)

echo Ativando ambiente virtual...
call %venv%/Scripts/activate
echo Ambiente virtal ativado.

echo Instalando dependencias...
pip install -r requirements.txt >nul 2>&1
echo Dependencias instaladas.

echo Ativando servidor...
python manage.py runserver

