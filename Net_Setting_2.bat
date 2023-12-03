@echo off

::管理者権限へ昇格


whoami /priv | find "SeDebugPrivilege" > nul
if %errorlevel% neq 0 (
@powershell start-process %~0 -verb runas
exit
)


::IPv4アドレス設定をDHCPに変更


:dhcp

netsh interface ipv4 set address "イーサネット" dhcp

if %ERRORLEVEL% == 0 (goto dhcp2)

for /f "usebackq delims=" %%A in (`netsh interface ipv4 set address "イーサネット" dhcp`) do set ENABLE=%%A

if "%ENABLE%" == "DHCP はこのインターフェイスで既に有効です。" (goto dhcp2)

echo IPアドレス自動取得設定が正常に完了しませんでした。再度実行してください。
pause
goto dhcp


::DNSをDHCPで取得


:dhcp2
netsh interface ipv4 set dns "イーサネット" dhcp

if %ERRORLEVEL% == 0 (goto next)

echo DNS自動取得設定が正常に完了しませんでした。再度実行してください。
pause
goto dhcp2

:next

echo DHCPの設定は正常に完了しております。


::環境変数の設定※環境変数HOST1に内側の疎通確認を行う際のホスト名を設定


set COUNT=0
set DEG=回目
set TIMEOUTCOUNT=15
set INTERVAL=1
set HOST1=<<任意のサーバなど、内部ネットワークで通信確認が可能であるホストを指定>>
set HOST2=yahoo.co.jp

::内部ネットワークの疎通確認

:error1
timeout /t %INTERVAL%  > nul
set /a COUNT=COUNT+1
echo %HOST1%へICMPパケットを送信しています....%COUNT%%DEG%
if "%COUNT%" == "%TIMEOUTCOUNT%" goto errortimeout1
ping -n 1 %HOST1% | find "ms TTL=" > NUL
if %ERRORLEVEL% == 1 (goto error1)

echo;
echo;

echo %HOST1%への接続確認ができました
goto end1

echo;
echo;

:errortimeout1
echo;
echo;
echo %HOST1%への接続確認ができませんでした(社内ネットワーク）
echo;
echo;
echo ネットワーク設定状況を確認して、再度接続確認してください
echo Enterを押すと再度接続確認ができます
pause
set COUNT=0
goto error1

:end1

echo;
echo;


::外部ネットワークの疎通確認※yahoo.co.jpで確認


set COUNT=0

:error2
timeout /t %INTERVAL%  > nul
set /a COUNT=COUNT+1
echo %HOST2%へICMPパケットを送信しています....%COUNT%%DEG%
if "%COUNT%" == "%TIMEOUTCOUNT%" goto errortimeout2
ping -n 1 %HOST2% | find "ms TTL=" > NUL
if %ERRORLEVEL% == 1 (goto error2)

echo;
echo;

echo %HOST2%への接続確認ができました
goto end2

:errortimeout2
echo;
echo;
echo %HOST2%への接続確認ができませんでした(社外ネットワーク）
echo;
echo;
echo ネットワーク設定状況を確認して、再度接続確認してください
echo Enterを押すと再度接続確認ができます
pause
set COUNT=0
goto error2

:end2


::環境変数の初期化※必要ないが他のプログラムに組み込む場合などに利用


set ENABLE=
set COUNT=
set DEG=
set TIMEOUTCOUNT=
set INTERVAL=
set HOST1=
set HOST2=
echo;
echo;
echo DHCPの変更、通信確認完了しました。
echo;
pause
del /s /q "%USERPROFILE%\Net_Setting_2.bat"
