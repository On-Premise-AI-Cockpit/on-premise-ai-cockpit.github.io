@echo off
title KI-Cockpit - Sicherer Lokalstart (127.0.0.1)
echo Starte lokale Ollama-Schnittstelle mit restriktivem Origin (kein Wildcard *)...
set OLLAMA_ORIGINS=http://localhost:8000,http://127.0.0.1:8000
start "Ollama Lokal (127.0.0.1)" cmd /k "ollama serve"
echo Starte lokalen Mini-Dateiserver auf 127.0.0.1:8000...
cd /d "%~dp0.."
start "KI-Cockpit Lokalserver" cmd /k "python -m http.server 8000 --bind 127.0.0.1"
timeout /t 2 >nul
start http://127.0.0.1:8000/stufe5-smart-cockpit/cockpit.html
echo Zum Beenden (Zuendschluessel abziehen) einfach beide Konsolenfenster schliessen.
