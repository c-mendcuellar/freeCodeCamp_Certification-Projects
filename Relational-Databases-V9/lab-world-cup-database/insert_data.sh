#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

TEAMS=()
FIRST_PUSH="true"
GAMES_DATA_FOR_QUERY=()
while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != "year" ]]
  then
    if [[ $FIRST_PUSH = "true" ]]
    then
      TEAMS+=("('$WINNER')")
      TEAMS+=("('$OPPONENT')")
      FIRST_PUSH="false"
    
    # comprobar si ya existe el equipo en TEAMS, haya sido WINNER u OPPONENT
    else
      if [[ -z $(echo ${TEAMS[@]} | grep "$WINNER") ]]
      then
        TEAMS+=("('$WINNER')")
      fi 
      if [[ -z $(echo ${TEAMS[@]} | grep "$OPPONENT") ]] 
      then
        TEAMS+=("('$OPPONENT')")
      fi
    fi

    # array inicial para datos de juegos
    GAMES_DATA_FOR_QUERY+=("($YEAR, $WINNER, $OPPONENT, $WINNER_GOALS, $OPPONENT_GOALS, '$ROUND')")
  fi
done < games.csv 

# parte de datos para query de insercion de TEAMS
TEAMS_FOR_QUERY=$(IFS=','; echo "${TEAMS[*]}")

# insertar todos los equipos en tabla teams en un solo query
INSERT_TEAMS_RESULT=$($PSQL "INSERT INTO teams(name) VALUES${TEAMS_FOR_QUERY}")
if [[ -n $(echo $INSERT_TEAMS_RESULT | grep "INSERT" ) ]]
then
  echo "INFO: teams inserted successfully into teams table"
fi

for (( QUERY_PART = 0; QUERY_PART < ${#GAMES_DATA_FOR_QUERY[@]}; QUERY_PART++ ))
do
  for (( TEAM = 0; TEAM < ${#TEAMS[@]}; TEAM++ ))
  do
    TEAM_NAME=$(echo ${TEAMS[$TEAM]} | sed "s/('\(.*\)')/\\1/")
    if [[ -n $(echo ${GAMES_DATA_FOR_QUERY[$QUERY_PART]} | grep "$TEAM_NAME") ]]
    then
      TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$TEAM_NAME'")
      GAMES_DATA_FOR_QUERY[$QUERY_PART]=$(echo ${GAMES_DATA_FOR_QUERY[$QUERY_PART]} | sed "s/${TEAM_NAME}/${TEAM_ID}/")
    fi
  done
done

GAMES_DATA_FOR_QUERY_STR=$(IFS=','; echo "${GAMES_DATA_FOR_QUERY[*]}")

# insert all games data in table games in one query
INSERT_TEAMS_RESULT=$($PSQL "INSERT INTO games(year, winner_id, opponent_id, winner_goals, opponent_goals, round) VALUES${GAMES_DATA_FOR_QUERY_STR}")
if [[ -n $(echo $INSERT_TEAMS_RESULT | grep "INSERT") ]]
then
  echo "INFO: games data inserted successfully into games table"
fi