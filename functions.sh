#!/bin/bash

#!/bin/bash

strindex() { 
  x="${1%%$2*}"
  [[ $x = $1 ]] && echo -1|| echo ${#x}
}

Color_Text()
{
        echo -e " \e[0;$2m$1\e[0m"
}
Echo_Purple()
{
        echo $(Color_Text "$1" "35")
}
Echo_Red()
{
        echo $(Color_Text "$1" "31")
}
Echo_Green() {
        echo $(Color_Text "$1" "32")
}
Echo_Yellow () {
        echo $(Color_Text "$1" "33")
}
Echo_Cyan() {
        echo $(Color_Text "$1" "36")
}



