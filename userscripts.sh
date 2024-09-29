contador_file="contador_incidencias.txt"

if [ -f "$contador_file" ]; then
    next_incidencia=$(cat "$contador_file")
else
    next_incidencia=0
fi
((next_incidencia++))
echo "$next_incidencia" > "$contador_file"
read -p "Introduce tu dirección de correo electrónico: " email

read -p "Introduce el tipo de incidencia: " tipo_incidencia

read -p "Describe la incidencia: " descripcion

fecha_actual=$(date "+%Y-%m-%d %H:%M:%S")

estado="Abierta"

echo "Número de incidencia: #$next_incidencia" >> incidencias.txt
echo "Usuario: $email" >> incidencias.txt
echo "Tipo de incidencia: $tipo_incidencia" >> incidencias.txt
echo "Descripción: $descripcion" >> incidencias.txt
echo "Fecha y hora de apertura: $fecha_actual" >> incidencias.txt
echo "Última modificación: $fecha_actual" >> incidencias.txt
echo "Estado: $estado" >> incidencias.txt
echo "" >> incidencias.txt
echo "" >> incidencias.txt

echo "Incidencia registrada correctamente."
	

