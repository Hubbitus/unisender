#!/bin/bash

# !!!
#При подключении, обазательно должна быть задана переменная $GETOPTS_STRING
#GETOPT_STRING=":mnopq:rs4:"
#LONG_GETOPT_STRING="longopt-one, longopt-two:, longoptthree::"

#Переписано с использованием длинных опций, взяв за пример http://software.frodo.looijaard.name/getopt/docs.php

getopt_CMD=/usr/bin/getopt

# Обработка опций командной строки с помощью 'getopts'.

# Попробуйте вызвать этот сценарий как:
# 'scriptname -mn'
# 'scriptname -oq qOption' (qOption может быть любой произвольной строкой.)
# 'scriptname -qXXX -r'
#
# 'scriptname -qr'    - Неожиданный результат: "r" будет воспринят как дополнительный аргумент опции "q"
# 'scriptname -q -r'  - То же самое, что и выше
#  Если опция ожидает дополнительный аргумент ("flag:"), то следующий параметр
#  в командной строке, будет воспринят как дополнительный аргумент этой опции.

long_getopt_parse(){

#set -x
set -- `$getopt_CMD -u --options "$GETOPT_STRING" --longoptions "$LONG_GETOPT_STRING" -- "$@"`

	while [ ! -z "$1" -a "$1" != '--' ]; do
	OPTION=${1/#-/}		#One
	OPTION=${OPTION/#-/}	#May be two
#	echo '$OPTION='$OPTION'; $OPTARG='$2

		if [ "$OPTION" ]; then
		eval "export OPT$OPTION=\"$2\""
		shift	#$2
		else
		eval "export OPT$OPTION=777"
		fi
	shift
	done
#tail, to renew in caller
export NON_OPT=$( echo $@ | sed -r 's/^-- *//' )
}

#long_getopt_parse $@

