@echo off

::�Ǘ��Ҍ����֏��i


whoami /priv | find "SeDebugPrivilege" > nul
if %errorlevel% neq 0 (
@powershell start-process %~0 -verb runas
exit
)


::IPv4�A�h���X�ݒ��DHCP�ɕύX


:dhcp

netsh interface ipv4 set address "�C�[�T�l�b�g" dhcp

if %ERRORLEVEL% == 0 (goto dhcp2)

for /f "usebackq delims=" %%A in (`netsh interface ipv4 set address "�C�[�T�l�b�g" dhcp`) do set ENABLE=%%A

if "%ENABLE%" == "DHCP �͂��̃C���^�[�t�F�C�X�Ŋ��ɗL���ł��B" (goto dhcp2)

echo IP�A�h���X�����擾�ݒ肪����Ɋ������܂���ł����B�ēx���s���Ă��������B
pause
goto dhcp


::DNS��DHCP�Ŏ擾


:dhcp2
netsh interface ipv4 set dns "�C�[�T�l�b�g" dhcp

if %ERRORLEVEL% == 0 (goto next)

echo DNS�����擾�ݒ肪����Ɋ������܂���ł����B�ēx���s���Ă��������B
pause
goto dhcp2

:next

echo DHCP�̐ݒ�͐���Ɋ������Ă���܂��B


::�����l�b�g���[�N�̑a�ʊm�F�����ϐ�HOST1�Ƀz�X�g����ݒ�


set COUNT=0
set DEG=���
set TIMEOUTCOUNT=15
set INTERVAL=1
set HOST1=<<�C�ӂ̃T�[�o�ȂǁA�����l�b�g���[�N�ŒʐM�m�F���\�ł���z�X�g���w��>>
set HOST2=yahoo.co.jp

:error1
timeout /t %INTERVAL%  > nul
set /a COUNT=COUNT+1
echo %HOST1%��ICMP�p�P�b�g�𑗐M���Ă��܂�....%COUNT%%DEG%
if "%COUNT%" == "%TIMEOUTCOUNT%" goto errortimeout1
ping -n 1 %HOST1% | find "ms TTL=" > NUL
if %ERRORLEVEL% == 1 (goto error1)

echo;
echo;

echo %HOST1%�ւ̐ڑ��m�F���ł��܂���
goto end1

echo;
echo;

:errortimeout1
echo;
echo;
echo %HOST1%�ւ̐ڑ��m�F���ł��܂���ł���(�Г��l�b�g���[�N�j
echo;
echo;
echo �l�b�g���[�N�ݒ�󋵂��m�F���āA�ēx�ڑ��m�F���Ă�������
echo Enter�������ƍēx�ڑ��m�F���ł��܂�
pause
set COUNT=0
goto error1

:end1

echo;
echo;


::�O���l�b�g���[�N�̑a�ʊm�F��yahoo.co.jp�Ŋm�F


set COUNT=0

:error2
timeout /t %INTERVAL%  > nul
set /a COUNT=COUNT+1
echo %HOST2%��ICMP�p�P�b�g�𑗐M���Ă��܂�....%COUNT%%DEG%
if "%COUNT%" == "%TIMEOUTCOUNT%" goto errortimeout2
ping -n 1 %HOST2% | find "ms TTL=" > NUL
if %ERRORLEVEL% == 1 (goto error2)

echo;
echo;

echo %HOST2%�ւ̐ڑ��m�F���ł��܂���
goto end2

:errortimeout2
echo;
echo;
echo %HOST2%�ւ̐ڑ��m�F���ł��܂���ł���(�ЊO�l�b�g���[�N�j
echo;
echo;
echo �l�b�g���[�N�ݒ�󋵂��m�F���āA�ēx�ڑ��m�F���Ă�������
echo Enter�������ƍēx�ڑ��m�F���ł��܂�
pause
set COUNT=0
goto error2

:end2


::���ϐ��̏��������K�v�Ȃ������̌�Ƀv���O������ǉ�����ꍇ�Ȃǂɗ��p


set ENABLE=
set COUNT=
set DEG=
set TIMEOUTCOUNT=
set INTERVAL=
set HOST1=
set HOST2=
echo;
echo;
echo DHCP�̕ύX�A�ʐM�m�F�������܂����B
echo;
pause
del /s /q "%USERPROFILE%\Net_Setting_2.bat"