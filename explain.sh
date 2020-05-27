#!/bin/bash
# explain.sh begins
explain() {
    if [ "$#" -eq 0 ]; then
        while read -p "Command: " cmd; do
            curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$cmd"
        done
        echo "Bye!"
    elif [ "$#" -eq 1 ]; then
        curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$1"
    else
        echo "Usage"
        echo "explain                  interactive mode."
        echo "explain 'cmd -o | ...'   one quoted command to explain it."
    fi
}

#version pour le site explainshell.com
#la requete get est de la forme "https://explainshell.com/explain?cmd=ps+aux"
explain2() {
    URL=$(echo "http://explainshell.com/explain/$1?args=${@:2}" | sed -e 's/ /+/g')
    curl -s "$URL" | sed -n '/<pre/,/<\/pre>/p' | sed -n '/<pre/,/<\/pre>/p' | sed -s 's/<[^>]*>//g' | \
    sed -e 's/^ *//g;s/ *$//g' | grep '.' | cat

}
