@echo off

:�Ǘ��Ҍ����֏��i

whoami /priv | find "SeDebugPrivilege" > nul
if %errorlevel% neq 0 (
@powershell start-process %~0 -verb runas
exit
)


:���[�J���֎��s�t�@�C���R�s�[���y�[�X�g

xcopy /d "<<���s�t�@�C���p�X��>>" "%USERPROFILE%"


:�l�b�g���[�N�ݒ�ύX�t�@�C���̎��s���uNet_Setting_2.bat�v��C�ӂ̏ꏊ�ɔz�u

call "%USERPROFILE%\Net_Setting_2.bat"