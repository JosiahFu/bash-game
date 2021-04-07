playerx=5
playery=5

enemyx=0
enemyy=0


screenx=0
screeny=0
while true;
  do
    #echo "($playerx,$playery)";
    clear
    echo "Use WASD to move."

    #Draw screen
    #Draw box
    echo -e "\033[0;31m ----------"
    for i in {0..9}; do
      echo "|          |"
    done
    echo " ----------"
    #Draw player
    let screenx=playerx+2
    let screeny=playery+3
    echo -n -e "\033["$screeny";"$screenx"H\033[0;32m0\033[0m"
    #Draw enemy
    let screenx=enemyx+2
    let screeny=enemyy+3
    echo -n -e "\033["$screeny";"$screenx"H\033[0;31mV\033[0m"
    echo -n -e "\033[14;0H"

    #take user input
    read -n 1 -s action
    if [ "$action" == "s" ]; then
      let playery playery++
      if (( $playery > 9 )); then
        playery=9
      fi
    elif [ "$action" == "w" ]; then
      let playery playery--
      if (( $playery < 0 )); then
        playery=0
      fi
    elif [ "$action" == "d" ]; then
      let playerx playerx++
      if (( $playerx > 9 )); then
        playerx=9
      fi
    elif [ "$action" == "a" ]; then
      let playerx playerx--
      if (( $playerx < 0 )); then
        playerx=0
      fi
    fi
    
    #make enemy move
    if (( $playery > $enemyy)); then
      let enemyy enemyy++
    elif (( $playery < $enemyy )); then
      let enemyy enemyy--
    elif (( $playerx > $enemyx)); then
      let enemyx enemyx++
    elif (( $playerx < $enemyx )); then
      let enemyx enemyx--
    fi
  done
