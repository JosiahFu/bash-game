x=5
y=5
screenx=0
screeny=0
while true;
  do
    #echo "($x,$y)";
    let screenx=x+2
    let screeny=y+3
    clear
    echo "Use WASD to move."
    #Draw top
    echo -e "\033[0;31m ----------"
    for i in {0..9}; do
      echo "|          |"
    done
    echo " ----------"
    echo -n -e "\033["$screeny";"$screenx"H\033[0;33m0\033[0m"
    echo -n -e "\033[14;0H"

    #take user input
    read -n 1 -s action
    if [ "$action" == "s" ]; then
      let y y++
      if (( $y > 9 )); then
        y=9
      fi
    elif [ "$action" == "w" ]; then
      let y y--
      if (( $y < 0 )); then
        y=0
      fi
    elif [ "$action" == "d" ]; then
      let x x++
      if (( $x > 9 )); then
        x=9
      fi
    elif [ "$action" == "a" ]; then
      let x x--
      if (( $x < 0 )); then
        x=0
      fi
    fi
  done
