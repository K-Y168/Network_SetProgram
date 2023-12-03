@echo off

:管理者権限へ昇格

whoami /priv | find "SeDebugPrivilege" > nul
if %errorlevel% neq 0 (
@powershell start-process %~0 -verb runas
exit
)


:"Net_Setting_2.bat"をローカルへコピー＆ペースト

xcopy /d "<<Net_Setting_2.batを配置しているパス>>" "%USERPROFILE%"


:ネットワーク設定変更ファイルの実行

call "%USERPROFILE%\Net_Setting_2.bat"
