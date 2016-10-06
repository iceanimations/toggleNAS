@echo off
for /f %%i in ('net use P: 2^> NUL') do (
    if %%i == Local (
        GOTO MOUNT
    )
    GOTO ERROR
)
GOTO UNMOUNT

:MOUNT
echo mounting local nas ...
SET DIRNAME=D:\LOCAL_NAS
IF NOT EXIST %DIRNAME% (
    mkdir %DIRNAME%
)
net use P: /DELETE /Y > NUL
timeout /nobreak /t 2 > NUL
subst P: D:\LOCAL_NAS
echo done!
GOTO END

:UNMOUNT
@echo off
echo mounting remote nas ...
subst P: /D
net use P: \\nasx\storage\Projects /PERSISTENT:YES > NUL
echo done!
GOTO END

:ERROR
echo no action is appropriate

:END
