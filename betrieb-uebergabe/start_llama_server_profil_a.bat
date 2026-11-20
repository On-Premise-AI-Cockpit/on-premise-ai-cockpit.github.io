@echo off
title llama-server Profil A (8-16 GB Dienst-Laptop, CPU-schonend)
rem Passen Sie den Pfad zu llama-server.exe und zur .gguf-Datei an.
rem schluessel.txt: eine Zeile mit einem langen, zufaelligen Schluessel (nicht weitergeben, nicht einchecken).
rem Denselben Schluessel tragen Sie im Cockpit zur Laufzeit in das Feld "API-Schluessel" ein.
rem --host 127.0.0.1: nur von diesem Rechner erreichbar. --api-key-file: llama-server beantwortet sonst Browser-Anfragen jeder Herkunft.
cd /d "%~dp0"
if not exist schluessel.txt (
  echo Bitte zuerst die Datei schluessel.txt mit einem eigenen Schluessel neben dieser Startdatei anlegen.
  pause
  exit /b 1
)
llama-server -m ./modelle/Qwen3.5-4B-Q4_K_M.gguf --host 127.0.0.1 --port 8080 --api-key-file schluessel.txt -ngl 0 -c 4096 -ctk q8_0 -ctv q8_0
pause
