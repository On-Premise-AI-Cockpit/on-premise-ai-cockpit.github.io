@echo off
title KI-Cockpit - Sicherer Lokalstart (127.0.0.1)
rem Vorher die Ollama-Desktop-App beenden (Lama-Symbol, Quit Ollama), sonst ist Port 11434 belegt.
set OLLAMA_HOST=127.0.0.1:11434
set OLLAMA_NO_CLOUD=1
start "Ollama Lokal (127.0.0.1)" cmd /k "ollama serve"
cd /d "%~dp0.."
start "KI-Cockpit Lokalserver" cmd /k "python -m http.server 8000 --bind 127.0.0.1"
timeout /t 2 >nul
start http://127.0.0.1:8000/stufe5-smart-cockpit/cockpit.html
echo Zum Beenden (Zuendschluessel abziehen) beide Konsolenfenster schliessen.
