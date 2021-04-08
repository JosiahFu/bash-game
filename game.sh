#variables
turn=0
score=0

playerx=5
playery=5

enemyx=5
enemyy=2

goalx=5
goaly=8

distx=0
disty=0
screenx=0
screeny=0

#main loop
while true;
  do
    #echo "($playerx,$playery)";
    clear
    echo "Use WASD to move. Collect the + and don't touch the X!"
    echo "Score: $score"

    #Draw screen
    #Draw box
    echo " ----------"
    for i in {0..9}; do
      echo "|          |"
    done
    echo " ----------"
    #Draw goal
    let screenx=goalx+2
    let screeny=goaly+4
    echo -n -e "\033["$screeny";"$screenx"H\033[0;32m+\033[0m"
    #Draw player
    let screenx=playerx+2
    let screeny=playery+4
    echo -n -e "\033["$screeny";"$screenx"H\033[0;33m0\033[0m"
    #Draw enemy
    let screenx=enemyx+2
    let screeny=enemyy+4
    echo -n -e "\033["$screeny";"$screenx"H\033[0;31mX\033[0m"
    echo -n -e "\033[15;0H"
    
    #test for lose
    if [ "$playerx" == "$enemyx" ]; then
      if [ "$playery" == "$enemyy" ]; then
        echo Game over
        sleep 2s
        break
      fi
    fi
    
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
    if (( "$turn" == "0" )); then
      turn=1
      let distx=playerx-enemyx
      let disty=playery-enemyy
      #get absolute values
      if (( ${distx##*[+-]} >= ${disty##*[+-]} )); then
        if (( $playerx > $enemyx)); then
          let enemyx enemyx++
        elif (( $playerx < $enemyx )); then
          let enemyx enemyx--
        fi
      else
        if (( $playery > $enemyy)); then
          let enemyy enemyy++
        elif (( $playery < $enemyy )); then
          let enemyy enemyy--
        fi
      fi
    else
      turn=0
    fi

    #test for collect
    if [ "$playerx" == "$goalx" ]; then
      if [ "$playery" == "$goaly" ]; then
        let score score++
        goalx=$(($RANDOM % 10))
        goaly=$(($RANDOM % 10))
      fi
    fi
  done
