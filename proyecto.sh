#!/bin/bash

# ========================
# Manuel Ivan Salgado Garduño
# Proyecto de Programación en Shell
# Módulos: Archivos, Procesos, Usuarios, Sistema, Salir
# ========================

while true; do
  echo -e "\n===== MENÚ PRINCIPAL ====="
  echo "1. Archivos"
  echo "2. Procesos"
  echo "3. Usuarios y Grupos"
  echo "4. Sistema"
  echo "5. Salir"
  read -p "Seleccione una opción [1-5]: " opc

  case $opc in
    1)
      while true; do
        echo -e "\n--- ARCHIVOS ---"
        echo "1. Mostrar archivos"
        echo "2. Atributos de archivos"
        echo "3. Listar directorios"
        echo "4. Regresar"
        read -p "Seleccione una opción: " arch

        case $arch in
          1)
            read -p "Nombre del archivo: " file
            [ -f "$file" ] && more "$file" || echo "Archivo no encontrado"
            ;;
          2)
            read -p "Archivo: " file
            if [ -e "$file" ]; then
              echo "Nombre: $file"
              stat -c "I-nodo: %i" "$file"
              stat -c "Dueño: %U" "$file"
              stat -c "Tamaño: %s bytes" "$file"
              tipo=$(stat -c %F "$file")
              echo "Tipo de archivo: $tipo"
              stat -c "Fecha de modificación: %y" "$file"
              stat -c "Permisos dueño: %A" "$file"
              stat -c "Permisos grupo: %A" "$file"
              stat -c "Permisos otros: %A" "$file"
            else
              echo "Archivo no válido"
            fi
            ;;
          3)
            read -p "Nombre del directorio (relativo o absoluto): " dir
            if [ -d "$dir" ]; then
              ls -lhS "$dir" | more
            elif [ -d "/$dir" ]; then
              ls -lhS "/$dir" | more
            else
              echo "Directorio no válido"
            fi
            ;;
          4)
            break
            ;;
          *)
            echo "Opción inválida"
            ;;
        esac
      done
      ;;
    2)
      while true; do
        echo -e "\n--- PROCESOS ---"
        echo "1. Listar todos los procesos"
        echo "2. Procesos de un usuario"
        echo "3. Buscar procesos"
        echo "4. Regresar"
        read -p "Seleccione una opción: " proc

        case $proc in
          1)
            ps aux | more
            ;;
          2)
            read -p "Usuario: " user
            ps -u "$user" | more
            ;;
          3)
            read -p "Nombre del proceso: " pname
            ps aux | grep "$pname" | grep -v grep
            ;;
          4)
            break
            ;;
          *)
            echo "Opción inválida"
            ;;
        esac
      done
      ;;
    3)
      while true; do
        echo -e "\n--- USUARIOS Y GRUPOS ---"
        echo "1. Información de un usuario"
        echo "2. Información de un grupo"
        echo "3. Total de usuarios y logins"
        echo "4. Total de grupos y nombres"
        echo "5. Regresar"
        read -p "Seleccione una opción: " ug

        case $ug in
          1)
            read -p "Usuario: " user
            if id "$user" &> /dev/null; then
              login=$(getent passwd "$user" | cut -d: -f1)
              uid=$(getent passwd "$user" | cut -d: -f3)
              gid=$(getent passwd "$user" | cut -d: -f4)
              grupo=$(getent group "$gid" | cut -d: -f1)
              comentario=$(getent passwd "$user" | cut -d: -f5)
              home=$(getent passwd "$user" | cut -d: -f6)
              shell=$(getent passwd "$user" | cut -d: -f7)
              echo -e "Login: $login\nUID: $uid\nGID: $gid\nGrupo: $grupo\nComentario: $comentario\nHome: $home\nShell: $shell"
            else
              echo "Usuario no encontrado"
            fi
            ;;
          2)
            read -p "Grupo: " grupo
            getent group "$grupo" | awk -F: '{print "GID: "$3"\nNombre: "$1"\nUsuarios secundarios: "$4}' || echo "Grupo no encontrado"
            ;;
          3)
            echo "Usuarios login:"
            grep -E "/home|/bin/bash" /etc/passwd | cut -d: -f1
            grep -E "/home|/bin/bash" /etc/passwd | wc -l | xargs echo "Total:"
            ;;
          4)
            echo "Grupos de personas:"
            grep -vE '^(daemon|bin|sys|lp|sync|games|man|mail|news)' /etc/group | cut -d: -f1
            grep -vE '^(daemon|bin|sys|lp|sync|games|man|mail|news)' /etc/group | wc -l | xargs echo "Total:"
            ;;
          5)
            break
            ;;
          *)
            echo "Opción inválida"
            ;;
        esac
      done
      ;;
    4)
      while true; do
        echo -e "\n--- SISTEMA ---"
        echo "1. Usuarios conectados"
        echo "2. Actividad de un usuario"
        echo "3. Características del sistema"
        echo "4. Tiempo activo del sistema"
        echo "5. Regresar"
        read -p "Seleccione una opción: " sis

        case $sis in
          1)
            who
            ;;
          2)
            read -p "Usuario: " usuario
            w | grep "$usuario"
            ;;
          3)
            echo "Hostname: $(hostname)"
            echo "Sistema operativo: $(uname -s)"
            echo "Versión SO: $(uname -r)"
            echo "Número de CPUs: $(nproc)"
            lscpu | grep "Model name" | awk -F: '{print "CPU: "$2}'
            free -h | awk '/Mem:/ {print "RAM: "$2}'
            free -h | awk '/Swap:/ {print "Swap: "$2}'
            df -h / | awk 'NR==2 {print "Partición /: "$2}'
            ;;
          4)
            uptime -p
            ;;
          5)
            break
            ;;
          *)
            echo "Opción inválida"
            ;;
        esac
      done
      ;;
    5)
      echo "Saliendo..."
      exit 0
      ;;
    *)
      echo "Opción no válida"
      ;;
  esac

done

