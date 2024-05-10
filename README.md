# Sincronizador de Hora Windows-Linux

Este script para Windows soluciona el conflicto de hora que ocurre cuando se tienen instalados Windows y Linux en un sistema de dual boot. Debido a que ambos sistemas operativos almacenan la hora en diferentes formatos, al cambiar de uno a otro, la hora se desconfigura.

## Descripción

Crea un nuevo valor en el Registro o reemplazar uno existente, el script configura Windows para que guarde la hora en el mismo formato que Linux (UTC). Esto evita que la hora se desconfigure al cambiar entre sistemas operativos.

## Uso

1. Descarga el archivo `MultiBootTimeSync.bat` desde este repositorio.
2. Haz clic derecho en el archivo y selecciona "Ejecutar como administrador".
3. Sigue las instrucciones que aparecen en la consola.

> Nota: Si estás reemplazando un valor existente, el script deshabilitará y volverá a habilitar el servicio `w32time` automáticamente.

