#!/bin/bash
# Author: Carlos Mendez Coellar

PSQL="psql -tA -U freecodecamp -d periodic_table -c"

DATA_QUERYING()
{
  QUERY_ALL_DATA_RESULT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE $1 = $2")
  if [[ -z $QUERY_ALL_DATA_RESULT ]]
  then
    echo "I could not find that element in the database."
    exit 0
  
  else
    while IFS='|' read TYPE_ID ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS TYPE
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
    done <<< $QUERY_ALL_DATA_RESULT

  fi
}

if [[ ! $1 ]]
then
  echo "Please provide an element as an argument."

else
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    DATA_QUERYING "atomic_number" $1

  elif [[ $1 =~ ^[a-zA-Z]+$ && $(echo -n $1 | wc -m) -le 2 ]]
  then
    DATA_QUERYING "symbol" "'$1'"
    
  else
    DATA_QUERYING "name" "'$1'"
  
  fi  
fi