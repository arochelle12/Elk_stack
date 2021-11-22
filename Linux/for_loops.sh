#!/bin/bash

states=('Texas' 'California' 'New York' 'Colorado' 'Hawaii')


for state in ${states[@]}
do
  if [ $state = 'Hawaii' ]
  then
    echo 'Hawaii is the best!'
  else
    echo "I'm not fond of Hawaii"
  fi
done



numbers=(0..9)

for num in ${numbers[@]}
do
  if [ $num = 3 ] || [ $num = 5 ] || [ $num = 7 ]
  then 
    echo $num
  fi
done

