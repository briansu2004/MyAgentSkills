git diff-index --quiet HEAD
if %errorlevel% neq 0 (
  exit /b 1
  ) else (
  exit /b 0
)
