#!/bin/bash
#Author: Carlos Mendez Coellar

PSQL="psql -tA -U freecodecamp -d number_guess -c"

START_GUESSING_GAME()
{
  SECRET_NUMBER=$(( $RANDOM % 1000 + 1 ))
  echo -e "\nSecret number: $SECRET_NUMBER"
  GUESS_COUNTER=1
  echo -e "\nGuess the secret number between 1 and 1000:"
  while :
  do
    read USER_GUESS
    if [[ ! $USER_GUESS =~ ^[0-9]+$ ]]
    then
      echo -e "\nThat is not an integer, guess again:"
      continue
    fi

    if [[ $USER_GUESS -lt $SECRET_NUMBER ]]
    then
      echo -e "\nIt's higher than that, guess again:"

    elif [[ $USER_GUESS -gt $SECRET_NUMBER ]]
    then
      echo -e "\nIt's lower than that, guess again:"

    else
      echo -e "\nYou guessed it in $GUESS_COUNTER tries. The secret number was $SECRET_NUMBER. Nice job!"
      REGISTER_GAME_DATA_RESULT=$($PSQL "INSERT INTO games(user_id, guesses) VALUES($1, $GUESS_COUNTER)")
      if [[ -z $(echo $REGISTER_GAME_DATA_RESULT | grep "INSERT") ]]
      then
        echo -e "\nAn error has ocurred when attempting to register this game session data."
      fi

      break

    fi

    (( GUESS_COUNTER+=1 ))
  done
}

echo -e "\nEnter your username:"
read USERNAME

USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME'")
if [[ -z $USER_ID ]]
then
  echo -e "\nWelcome, $USERNAME! It looks like this is your first time here."
  REGISTER_USER_RESULT=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
  if [[ -z $(echo $REGISTER_USER_RESULT | grep "INSERT") ]]
  then
    echo -e "\nAn error has ocurred when when attempting to register new user $USERNAME"
    exit 0
  fi

  NEW_USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME'")
  START_GUESSING_GAME $NEW_USER_ID

else
  USERS_GAMES=$($PSQL "SELECT COUNT(*) FROM games GROUP BY user_id HAVING user_id = $USER_ID")
  USERS_BEST_GUESS=$($PSQL "SELECT MIN(guesses) FROM games GROUP BY user_id HAVING user_id = $USER_ID")
  echo -e "\nWelcome back, ${USERNAME}! You have played ${USERS_GAMES} games, and your best game took ${USERS_BEST_GUESS} guesses."
  
  START_GUESSING_GAME $USER_ID

fi