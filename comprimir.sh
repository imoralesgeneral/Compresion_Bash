#!/bin/bash
###################################################
## Esta aplicación sirve para comprimir ficheros ##
##                                               ## 
## Autor: Isaac                                  ##
## Versión: 1                                    ##
##                                               ##
###################################################
INPUT=""
OUTPUT=""
COMPRESSION=""
# Función que muestra el panel de ayuda
function ayuda() {
	echo ""
	echo " La llamada al comando debe ser:"
	echo ""
	echo " comprimir [OPCIONES] [VALOR]"
	echo ""
	echo " Donde OPCIONES puede ser: "
	echo ""
	echo " -i --input  || Fichero(s) a comprimir"
	echo " -o --output || Nombre del fichero de salida"
	echo " -t --type   || Tipo de compresión"
	echo " -h --help   || Muestra esta pantalla"
	echo ""
	echo "--------------------------------------------"
	echo " La compresión puede ser:                 ||"
	echo " zip   gz   tar   tgz   tbz2              ||" 
	echo "--------------------------------------------"
	echo ""
	exit 1
}

# Si no se introduce ningún parámetro se muestra el panel de ayuda
if [[ $# -lt 1 ]] ; then
	echo "No ha introducido ningún parámetro"
	ayuda
fi

# Asigno los valores de los parámetros a las variables input, output, compression
while [ -n "$1" ]; do
	case "$1" in 
	-i|--input)
		INPUT=$2
		shift
		;;
	-o|--output)
		OUTPUT=$2
		shift
		;;
	-t|--type)
		COMPRESSION=$2
		shift
		;;
	-h|--help)
		ayuda
		;;
	-*) echo "Comando $1 no reconocido"
		ayuda
		;;
	esac
	shift
done

# Si alguno de esos valores no se ha añadido muestro el panel de ayuda
if [[ "$INPUT" == "" || "$OUTPUT" == "" || "$COMPRESSION" == "" ]]; then
	echo "Faltan los parámetros necesarios"
	ayuda
fi

# Comprimo los ficheros en el tipo indicado
case "$COMPRESSION" in
	"zip")
		zip "$OUTPUT".zip $INPUTs
		;;
	"gz")
		gzip -c $INPUT > "$OUTPUT".gz 
		;;
	"tar")
		tar cvf "$OUTPUT".tar $INPUT
		;;
	"tgz")
		tar czvf "$OUTPUT".tar.gz $INPUT
		;;
	"tbz2")
		tar -c $INPUT | bzip2 > "$OUTPUT".tar.bz2
		;;
	*)
		ayuda
		;;
esac
echo ""
echo "El tipo de compresión que se efectuará es: "$COMPRESSION
echo ""
echo "Input: $INPUT"
echo ""
ls $INPUT
echo ""
echo "Output: "$OUTPUT

