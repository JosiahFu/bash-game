x=5
y=5
while true;
  do
    #echo "($x,$y)";
    clear
    echo "Use WASD to move."
    #Draw top
    echo -e "\033[0;31m ----------"
    #Draw middle
    i=10
    let y y++
    while [ "$i" != "$y" ]
    do
      echo "|          |"
      let i i--
    done

    echo -n "|"
    j=0
    while [ "$j" != "$x" ]
    do
      echo -n " "
      let j j++
    done
    echo -n -e "\033[0;33mO\033[0;31m"
    let j j++
    while [ "$j" != "10" ]
    do
      echo -n " "
      let j j++
    done
    echo "|"

    let i i--
    while [ "$i" != "0" ]
    do
      echo "|          |"
      let i i--
    done
    #Draw bottom
    let y y--
     echo -e " ----------\033[0m"

    #take user input
    read -n 1 -s action
    if [ "$action" == "w" ]; then
      let y y++
      if (( $y > 9 )); then
        y=9
      fi
    elif [ "$action" == "s" ]; then
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
