@echo off

REM Check if HEAD exists (empty repo case)
git rev-parse --verify HEAD >nul 2>&1
if %errorlevel% neq 0 (
  REM No commits yet → treat as clean
  exit /b 0
)

REM Check for modified but uncommitted files
git diff-index --quiet HEAD --
if %errorlevel% equ 0 (
  exit /b 0
  ) else (
  exit /b 1
)
