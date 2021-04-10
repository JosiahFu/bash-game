#variables
turn=0
score=0

playerx=5
playery=5

enemyx=(2 4 6 8)
enemyy=(2 2 2 2)

goalx=5
goaly=8

distx=0
disty=0
targetx=0
targety=0


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
    for i in {0..3}; do
      echo -n -e "\033["$((${enemyy[$i]} + 4))";"$((${enemyx[$i]} + 2))"H${red}X"
    done
    echo -n -e "${reset}\033[15;0H"
    
    #test for lose
    for i in {0..3}; do
      if [[ "$playerx" == "${enemyx[$i]}" && "$playery" == "${enemyy[i]}" ]]; then
        echo Game over
        sleep 2s
        break 2
      fi
    done
    
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
      for i in {0..3}; do
        let distx=playerx-enemyx[$i]
        let disty=playery-enemyy[$i]
        let targetx=enemyx[$i]
        let targety=enemyy[$i]
        #get absolute values
        if (( ${distx##*[+-]} >= ${disty##*[+-]} )); then
          if (( $distx > 0)); then
            let targetx++
          elif (( $distx < 0)); then
            let targetx--
          fi
        else
          if (( $disty > 0)); then
            let targety++
          elif (( $disty < 0 )); then
            let targety--
          fi
        fi
        for j in {0..3}; do
          if (( $targetx == ${enemyx[$j]} && $targety == ${enemyy[$j]} )); then
            continue 2
          fi
        done
        let enemyx[$i]=targetx
        let enemyy[$i]=targety
      done
    else
      turn=0
    fi

    #test for collect
    if [[ "$playerx" == "$goalx" && "$playery" == "$goaly" ]]; then
      let score++
      goalx=$(($RANDOM % 10))
      goaly=$(($RANDOM % 10))
    fi
  done
