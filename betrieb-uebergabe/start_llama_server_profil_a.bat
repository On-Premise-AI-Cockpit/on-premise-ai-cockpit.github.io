@echo off
title llama-server Profil A (8-16 GB Dienst-Laptop, CPU-schonend)
REM Passen Sie den Pfad zu llama-server.exe und Ihrer .gguf-Datei an:
llama-server -m ./modelle/Qwen3.5-4B-Q4_K_M.gguf --host 127.0.0.1 --port 8080 -ngl 0 -c 4096 -ctk q8_0 -ctv q8_0
pause
