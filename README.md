# Proyecto de Programación en Shell

Este proyecto consiste en un script de bash que integra distintos módulos para la administración básica de un sistema Unix/Linux. Fue diseñado con base en los contenidos de los módulos 1, 2 y 3 del curso de Programación Avanzada en Shell del IIMAS-UNAM.

## Alumno
Manuel Ivan Salgado Garduño

## Requisitos
- Sistema operativo tipo Unix/Linux.
- Intérprete Bash (`/bin/bash`).
- Permisos de ejecución en el script.
- Sistema operativo usado Debian 12.

## Estructura General del Programa
El script muestra un menú principal con cinco opciones:

1. **Archivos**
    - Mostrar archivos (paginado).
    - Atributos de archivos.
    - Listar directorios ordenados por tamaño.

2. **Procesos**
    - Listar todos los procesos del sistema.
    - Listar procesos de un usuario.
    - Buscar procesos por nombre.

3. **Usuarios y Grupos**
    - Mostrar información de un usuario.
    - Mostrar información de un grupo.
    - Mostrar el número total de usuarios y logins personales.
    - Mostrar el número total de grupos de personas.

4. **Sistema**
    - Usuarios actualmente conectados.
    - Actividad de un usuario específico.
    - Características del sistema (hostname, SO, CPU, RAM, etc.).
    - Tiempo activo desde el último reinicio.

5. **Salir**
    - Finaliza la ejecución del script.

## Consideraciones Especiales
- El script cuenta con validaciones básicas para asegurar que los archivos o directorios existan.
- Se usa `more` para paginar salidas largas.
- Se implementa tolerancia a entradas inválidas (cadenas vacías, opciones fuera de rango).

## Ejecución del Programa
1. Dar permisos de ejecución:
```bash
chmod +x proyecto.sh
```
2. Ejecutar el script:
```bash
./proyecto.sh
```

## Pruebas Sugeridas
1. Presionar `Enter` sin escribir nada.
2. Escribir una cadena aleatoria como opción.
3. Ingresar una opción válida seguida de espacios o tabs.
4. Buscar una cadena recortada.
5. Buscar cadenas presentes en varios campos.
6. Probar colisiones: nombres iguales en usuarios y procesos.
7. Probar entradas correctas.
