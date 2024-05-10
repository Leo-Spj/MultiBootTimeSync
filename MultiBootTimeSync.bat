@echo off
chcp 65001 >nul

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Por favor, ejecuta este script como administrador.
    pause
    exit /b
)

:: Visualizar cambios en regedit: Equipo\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation

set key="HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation"
set valueName="RealTimeIsUniversal"
set valueType="REG_DWORD"
set valueData=1

reg query %key% /v %valueName% >nul 2>&1
if %errorlevel% equ 0 (
    echo La clave y el valor ya existen en el registro.
    
    choice /c NDR /m "¿Qué desea hacer? (N) No hacer nada, (D) Eliminar cambios, (R) Reemplazar: "
        if errorlevel 3 (
            echo Borrando el valor existente y creando uno nuevo...
            reg delete %key% /v %valueName% /f
            echo Se ha borrado el valor existente.
            reg add %key% /v %valueName% /t %valueType% /d %valueData% /f
            if %errorlevel% equ 0 (
                echo Valor DWORD creado exitosamente.
            ) else (
                echo Hubo un error al crear el valor DWORD.
            )
            echo Deshabilitando el servicio w32time...
            sc config w32time start= disabled
        ) else if errorlevel 2 (
            echo Borrando el valor existente...
            reg delete %key% /v %valueName% /f
            echo Se ha borrado el valor existente.
            sc config w32time start= auto
            pause
            exit /b
        ) else if errorlevel 1 (
            echo No se realizaron cambios.
            pause
            exit /b
        )
) else (
    echo La clave y el valor no existen en el registro.
    echo Creando un nuevo valor...
    reg add %key% /v %valueName% /t %valueType% /d %valueData% /f  
    echo Deshabilitando el servicio w32time...
    sc config w32time start= disabled    
)


pause