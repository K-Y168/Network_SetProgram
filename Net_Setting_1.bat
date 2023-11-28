@echo off

:管理者権限へ昇格

whoami /priv | find "SeDebugPrivilege" > nul
if %errorlevel% neq 0 (
@powershell start-process %~0 -verb runas
exit
)


:ローカルへ実行ファイルコピー＆ペースト

xcopy /d "<<実行ファイルパス名>>" "%USERPROFILE%"


:ネットワーク設定変更ファイルの実行※「Net_Setting_2.bat」を任意の場所に配置

call "%USERPROFILE%\Net_Setting_2.bat"