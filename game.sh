#variables
turn=0
score=0

playerx=5
playery=5

enemy1x=5
enemy1y=2

enemy2x=4
enemy2y=2

enemy3x=6
enemy3y=2

goalx=5
goaly=8

distx=0
disty=0
goalchange=1
chosendirection=0
circleposition=0
circledirection=(+x +y -y +y +x -y -x +x "" "" -x +x -x +y -y +y -x -y)

#colors
reset="\033[0m"
yellow="\033[0;33m"
red="\033[0;31m"
green="\033[0;32m"

#main loop
while true;
  do
    #echo "($playerx,$playery)";
    clear
    echo -e "Use WASD to move the ${yellow}0$reset. Collect the $green+$reset and don't touch the ${red}X$reset!"
    echo -e "Score: $green$score$reset"

    #Draw screen
    #Draw box
    echo " ----------"
    for i in {0..9}; do
      echo "|          |"
    done
    echo " ----------"
    #Draw goal
    echo -n -e "\033["$(($goaly + 4))";"$(($goalx + 2))"H${green}+"
    #Draw player
    echo -n -e "\033["$(($playery + 4))";"$(($playerx + 2))"H${yellow}0"
    #Draw enemy
    echo -n -e "\033["$(($enemy1y + 4))";"$(($enemy1x + 2))"H${red}X"
    echo -n -e "\033["$(($enemy2y + 4))";"$(($enemy2x + 2))"H${red}X"
    echo -n -e "\033["$(($enemy3y + 4))";"$(($enemy3x + 2))"H${red}X"
    echo -n -e "${reset}\033[15;0H"
    
    #test for lose
    if [[ "$playerx" == "$enemy1x" && "$playery" == "$enemy1y" || "$playerx" == "$enemy2x" && "$playery" == "$enemy2y" || "$playerx" == "$enemy3x" && "$playery" == "$enemy3y" ]]; then
      echo Game over
      sleep 2s
      break
    fi
    
    #take user input
    read -n 1 -s action
    if [ "$action" == "s" ]; then
      let playery++
      if (( $playery > 9 )); then
        playery=9
        continue
      fi
    elif [ "$action" == "w" ]; then
      let playery--
      if (( $playery < 0 )); then
        playery=0
        continue
      fi
    elif [ "$action" == "d" ]; then
      let playerx++
      if (( $playerx > 9 )); then
        playerx=9
        continue
      fi
    elif [ "$action" == "a" ]; then
      let playerx--
      if (( $playerx < 0 )); then
        playerx=0
        continue
      fi
    else
      continue
    fi
    
    #make enemy move
    if (( "$turn" == "0" )); then
      turn=1

      #enemy 1
      let distx=playerx-enemy1x
      let disty=playery-enemy1y
      #get absolute values
      if (( ${distx##*[+-]} >= ${disty##*[+-]} )); then
        if (( $playerx > $enemy1x)); then
          let enemy1x++
        else
          let enemy1x--
        fi
      else
        if (( $playery > $enemy1y)); then
          let enemy1y++
        else
          let enemy1y--
        fi
      fi

      #enemy 2
      if (( $(($RANDOM % 2)) == 0 )); then
        if (( enemy2x == 0 )); then
          let enemy2x++
        elif (( enemy2x == 9 )); then
          let enemy2x--
        elif (( $(($RANDOM % 2)) == 0 )); then
          let enemy2x++
        else
          let enemy2x--
        fi
      else
        if (( enemy2y == 0 )); then
          let enemy2y++
        elif (( enemy2y == 9 )); then
          let enemy2y--
        elif (( $(($RANDOM % 2)) == 0 )); then
          let enemy2y++
        else
          let enemy2y--
        fi
      fi

      #enemy 3
      #if (( goalchange == 1 )); then
        let enemy3x=goalx
        let enemy3y=goaly
        while (( enemy3x == goalx && enemy3y == goaly )); do
          let enemy3x=goalx+$RANDOM%3-1
          let enemy3y=goaly+$RANDOM%3-1
        done
        goalchange=0
      #else
      #  let distx=playerx-enemy3x
      #  let disty=playery-enemy3y
      #  let circleposition=distx+3*disty
      #  let chosendirection=${circledirection[(($circleposition*2+$RANDOM%2))]}
      #  if [[ "$chosendirection" == "-x" ]]; then
      #    let enemy3x--
      #  elif [[ "$chosendirection" == "+x" ]]; then
      #    let enemy3x++
      #  elif [[ "$chosendirection" == "-y" ]]; then
      #    let enemy3y--
      #  elif [[ "$chosendirection" == "+y" ]]; then
      #    let enemy3y++
      #  fi
      #fi
    else
      turn=0
    fi

    #test for collect
    if [[ "$playerx" == "$goalx" && "$playery" == "$goaly" ]]; then
      let score++
      goalx=$(($RANDOM % 10))
      goaly=$(($RANDOM % 10))
      goalchange=1
    fi
  done
