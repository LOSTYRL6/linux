AbrirFirefox() {
firefox $archivo_html
}

EditarHTML() {
nano $archivo_html
}

archivo_html="pagina.html"
CrearHtml() {
if [ -s $archivo_html ]; then
        echo "El archivo HTML ya contiene datos."
    else
        echo "<!DOCTYPE html>" > $archivo_html
        echo "<html>" >> $archivo_html
        echo "<head>" >> $archivo_html
        echo "<title>Página de prueba</title>" >> $archivo_html
        echo "</head>" >> $archivo_html
        echo "<body>" >> $archivo_html
        echo "<h1>Hola, este es un sitio de prueba.</h1>" >> $archivo_html
        echo "</body>" >> $archivo_html
        echo "</html>" >> $archivo_html
        echo "Archivo HTML creado en: $archivo_html"
        fi
}

DarPermiso() {
   chmod 755 $archivo_html
   echo "Permisos cambiados."
}

QuitarPermiso() {
   chmod -r $archivo_html
   echo "Permisos quitado"
}

GestionarPaginaWeb() {
Opcion=1
 while [ $Opcion != 0 ]
    do
    	echo ""
        echo "1- Crear Html"
        echo "2- Dar Permiso HTML"
        echo "3- Quitar Permiso"
        echo "4- Editar Html"
        echo "5- Abrir en Firefox"
        echo "0- Salir"
        echo ""
        read -p "Elige una opción: " Opcion

        case $Opcion in
            1)
                CrearHtml
                ;;
            2)
                DarPermiso
                ;;
            3)
              	QuitarPermiso
                ;;
            4)
            	EditarHTML
            	;;
            5)
            	AbrirFirefox
            	;;
            0)
            	mostratMenu
            	;;
            *)
                echo "Opción no válida. Inténtalo de nuevo."
                ;;
        esac
    done
}


IniciarServeis() {
	sudo service "$1" start
	echo "el servicio ha sido iniciado"
	echo ""	
}

AturarServeis() {
	sudo service "$1" stop 
	echo "el servicio ha sido detenido"
	echo ""	
}

ReiniciarServeis() {
	sudo service "$1" restart
	echo "el servicio ha sido reiniciado"
	echo ""	
}

EstadoServeis() {
	estado=$(sudo service "$1" status )
	echo "el estado de $1 es $estado"
}



GestionarServeisFTP() {
Opcion=1
 while [ $Opcion != 0 ]
    do
    	echo ""
        echo "1-Iniciar Serveis "
        echo "2-Aturar Serveis "
        echo "3-reiniciar Serveis "
        echo "4- Estado del serveis"
        echo "0-Sortir"
        echo ""
        read -p "Elige una opción: "  Opcion

        case $Opcion in
            1)
            	 read -p "escribe le nombre entero del servicio: " servicio
                IniciarServeis "$servicio"
                ;;
            2)
            	 read -p "escribe le nombre entero del servicio: " servicio
                AturarServeis "$servicio"
                ;;
            3)
            	 read -p "escribe le nombre entero del servicio: " servicio
            	ReiniciarServeis "$servicio"
            	;;
            4)
            	 read -p "escribe le nombre entero del servicio: " servicio
            	EstadoServeis "$servicio"
            	;;    
            0)
               mostratMenu
                ;;
            *)
                echo "Opción no válida. Inténtalo de nuevo."
                ;;
        esac
    done
}

EliminarUsuario() {
  echo "Usuarios creados por este script:"
    for userdir in /srv/ftp/*; do
        if [ -d "$userdir" ]; then
            username=$(basename "$userdir")
            echo "$username"
        fi
    done

    read -p "Ingrese el nombre del usuario FTP que desea eliminar: " username

    if [ -z "$username" ]; then
        echo "Debe ingresar un nombre de usuario."
    else
        if id "$username" &>/dev/null; then
            sudo deluser --remove-home "$username"
            sudo rmdir /srv/fts/$username
            echo "Usuario FTP $username eliminado exitosamente."
        else
            echo "El usuario $username no existe."
        fi
    fi
}

ListarUsuario() {
 echo "Usuarios FTP creados por este script:"
    for userdir in /srv/ftp/*; do
        if [ -d "$userdir" ]; then
            username=$(basename "$userdir")
            echo "$username"
        fi
    done
}

AgregarUsuarioFTP() {
read -p "Ingrese el nombre de usuario FTP: " username
if [ -z "$username" ]; then
    echo "Debe ingresar un nombre de usuario."
else
if id "$username" &>/dev/null; then
    echo "El usuario $username ya existe."
else

sudo adduser --shell /bin/false --disabled-password --gecos "" "$username"

sudo mkdir -p /srv/ftp/$username
sudo chown $username:$username /srv/ftp/$username
sudo chmod 700 /srv/ftp/$username

echo "Usuario FTP $username creado exitosamente."
fi
fi
}
GestionarUsuariosFTP() {
Opcion=1
 while [ $Opcion != 0 ]
    do
    	echo ""
        echo "1- EliminarUsuario"
        echo "2- ListarUsuario"
        echo "0- Volver al menú principal"
        echo ""
        read -p "Elige una opción: " Opcion

        case $Opcion in
            1)
                EliminarUsuario
                ;;
            2)
                ListarUsuario
                ;;
            0)
            	mostratMenu
                ;;
            *)
                echo "Opción no válida. Inténtalo de nuevo."
                ;;
        esac
    done
}


ResoldreIncidencias() {
 Opcion=1
    while [ $Opcion != 0 ]
    do
    	echo ""
        echo "1- Agregar usuario FTP"
        echo "2- Gestionar usuarios FTP"
        echo "3- Gestionar Serveis"
        echo "4- Gestionar PaginaWeb"
        echo "0- Volver al menú principal"
        echo ""
        read -p "Elige una opción: " Opcion

        case $Opcion in
            1)
                AgregarUsuarioFTP
                ;;
            2)
                GestionarUsuariosFTP
                ;;
            3)
            	GestionarServeisFTP
            	;;  
            4)
            	GestionarPaginaWeb
            	;;	  
            0)
                mostratMenu
                ;;
            *)
                echo "Opción no válida. Inténtalo de nuevo."
                ;;
        esac
    done
}

MostrarProcesso() {
echo "Mostrando incidencias en processo"
echo "--------------------------------"

grep -B 5 "Estado: En proceso" incidencias.txt
echo ""
echo ""
}
MostrarAbiertas() {
echo "Mostrando incidencias abiertas"
echo "--------------------------------"

grep -B 5 "Estado: Abierta" incidencias.txt
echo ""
echo ""
}
MostrarCerrado() {
echo "Mostrando incidencias Cerrada"
echo "--------------------------------"

grep -B 5 "Estado: Cerrada" incidencias.txt
echo ""
echo ""
}
MostrarCompletadas() {
echo "Mostrando incidencias Completadas"
echo "--------------------------------"

grep -B 5 "Estado: Completada" incidencias.txt
echo ""
echo ""
}
MostrarIncidencia() {
while IFS= read -r line
do
echo "$line"
done < incidencias.txt
}

CambiarEstado() {
    echo "Incidencias disponibles:"
    cat incidencias.txt
    echo ""

    read -p "Introduce el número de incidencia que deseas modificar: " numero_incidencia

    # Buscar la incidencia por número
    if grep -q "Número de incidencia: #$numero_incidencia" incidencias.txt; then

        # Obtener el estado actual de la incidencia
        estado_actual=$(grep -A 6 "Número de incidencia: #$numero_incidencia" incidencias.txt | grep "Estado:" | awk -F ": " '{print $2}')

        if [ -z "$estado_actual" ]; then
            echo "No se pudo obtener el estado de la incidencia #$numero_incidencia. Verifica el formato del archivo."
        else
            echo "El estado actual de la incidencia #$numero_incidencia es '$estado_actual'."

            if [ "$estado_actual" = "Completada" ] || [ "$estado_actual" = "Cerrada" ]; then
                echo "La incidencia ya está marcada como completada o cerrada. No se puede cambiar el estado."
            else
                echo "Selecciona el nuevo estado para la incidencia:"
                echo "1. Abierta"
                echo "2. En proceso"
                echo "3. Cerrada"
                echo "4. Completada"
                read -p "Elije una opción (1/2/3/4): " opcion_estado

                case $opcion_estado in
                    1) nuevo_estado="Abierta" ;;
                    2) nuevo_estado="En proceso" ;;
                    3) nuevo_estado="Cerrada" ;;
                    4) nuevo_estado="Completada" ;;
                    *)
                        echo "Opción no válida. No se cambió el estado de la incidencia."
                        ;;
                esac

                if [ "$estado_actual" != "Completada" ] && [ "$estado_actual" != "Cerrada" ]; then
                    sed -i "/^Número de incidencia: #$numero_incidencia$/,/^$/ s/Estado: .*/Estado: $nuevo_estado/" incidencias.txt
                    echo "El estado de la incidencia #$numero_incidencia ha sido cambiado a '$nuevo_estado'."
                    echo ""
                fi
            fi
        fi

    else
        echo "No se encontró ninguna incidencia con el número #$numero_incidencia."
    fi
}

MostratGestionar() {
Opcion=1
while [ $Opcion != 0 ] 
do
echo "1-Mostrar todos los incidencias"
echo "2-MOstrar incidencias abiertas"
echo "3-Mostrar incidenicas en processps"
echo "4-Mostrar incidencias cerradas"
echo "5-mostrat incidencias completadas"
echo "6-Canviar estado a una incidencia"
echo "0-Salir al menu principal"
echo ""
read -p "tu respuesta: " Opcion
case $Opcion in
1)
MostrarIncidencia
;;
2)
MostrarAbiertas
;;
3)
MostrarProcesso
;;
4)
MostrarCerrado
;;
5)
MostrarCompletadas
;;
6)
CambiarEstado
;;
0)
mostratMenu
;;
*)
echo "No se entendio repite por favor"
;;
esac
done
}

mostratMenu() {
Opcion=1
while [ $Opcion != 0 ]
do
echo "Menu principal"
echo "1- Gestionar Incidencias"
echo "2- Resolver incidencias"
echo "0- Salir"
echo "Elija la opcion"
echo ""
read -p "Tu respuesta: " Opcion
case $Opcion in
1)
MostratGestionar
;;
2)
ResoldreIncidencias
;;
0)
echo "Nos vemos"
;;
*)
echo "no se entendio repite de nuevo"
;;
esac
done
}

mostratMenu
 
 
