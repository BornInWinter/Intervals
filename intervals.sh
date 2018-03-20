#!/bin/bash

# Dependencies: Beep

frequency=0
question=0
answer=0
key=''
response=''
right=0
wrong=0
point=0
pastp=0
corr=0
interval=96

function random2hertz() {
  frequency=$(( ( RANDOM  % 15000 ) + 21 ))
}

function hertz2question() {
  if [[ $(( ( RANDOM % 10 ) + 1 )) > 5 ]]
  then
    question=$interval
    answer=1
  else
    equestion=-$interval
    answer=0
  fi
}

function interval2question() {
  if [[ $(($point % 5)) == 0 && $pastp < $point ]]
  then
    interval=$(($interval/2))
  elif [[ $pastp > $point && $corr == 0 && $interval != 96 ]]
  then
    interval=$(($interval*2))
  fi
}

function question2answer() {
  if [ "$key" == "$answer" ]
  then
    response="\e[34;1m===> CORRECT\e[0m"
    right=$(($right+1))
    pastp=$point
    point=$(($point+1))
    corr=1
  elif [[ "$key" != "$answer" && "$key" != "2" && "$key" == "0" || "$key" == "1" ]]
  thenresponse="\e[31;1m===> WRONG\e[0m"wrong=$(($wrong+1))pastp=$pointpoint=$(($point-1))corr=0elif [ "$key" == "2" ]thenplayelseecho -e "\n\e[1m===> Unknown key . . .\e[0m\n"read -n 1 kkey=$kquestion2answerfi}

function question2answer() {
  if [ "$key" == "$answer" ]
  then
    response="\e[34;1m===> CORRECT\e[0m"
    right=$(($right+1))
    pastp=$point
    point=$(($point+1))
    corr=1
  elif [[ "$key" != "$answer" && "$key" != "2" && "$key" == "0" || "$key" == "1" ]]
  then
    response="\e[31;1m===> WRONG\e[0m"
    wrong=$(($wrong+1))
    pastp=$point
    point=$(($point-1))
    corr=0
  elif [ "$key" == "2" ]
  then
    play
  else
    echo -e "\n\e[1m===> Unknown key . . .\e[0m\n"
    read -n 1 k
    key=$k
    question2answer
  fi
}

function play() {
  beep -f $frequency
  sleep 0.2
  beep -f $(( $frequency + $question ))
  
  read -n 1 k
  key=$k
  
  question2answer
  echo -e "\n$response\t\e[34m$right\e[0m \e[31m$wrong\e[0m $point\e[1m interval: $interval\e[0m\n" 
}

while [ 1=1 ]
do
	random2hertz
	hertz2question
	play
	interval2question
done
