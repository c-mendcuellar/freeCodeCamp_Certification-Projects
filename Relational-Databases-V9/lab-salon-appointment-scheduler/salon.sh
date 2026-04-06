#!/bin/bash

PSQL="psql -X -U freecodecamp -d salon -tA -c"
echo -e "\n\~~~~~ MY SALON ~~~~~n"

MAIN_MENU()
{
  if [[ ! $1 ]]
  then
    echo -e "\nWelcome to My Salon, how can I help you?\n"
  else
    echo -e "\n$1\n"
  fi
  
  SERVICES=$($PSQL "SELECT * FROM services")

  echo -e "$SERVICES" | while IFS='|' read SERVICE_ID NAME
  do
    echo "${SERVICE_ID}) $NAME"
  done

  NUMBER_OF_SERVICES=$($PSQL "SELECT COUNT(*) FROM services")
  read SERVICE_ID_SELECTED

  if [[ ! (( $SERVICE_ID_SELECTED =~ ^[1-9]+$ && $SERVICE_ID_SELECTED -le $NUMBER_OF_SERVICES )) ]]
  then
    MAIN_MENU "I could not find that service. What would you like today?"
  else
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE
    PHONE_QUERY_RESULT=$($PSQL "SELECT phone FROM customers WHERE phone = '${CUSTOMER_PHONE}'")

    if [[ -z $PHONE_QUERY_RESULT ]]
    then
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read CUSTOMER_NAME
      INSERT_CUSTOMER_DATA_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('${CUSTOMER_PHONE}', '${CUSTOMER_NAME}')")
      
      if [[ -z $INSERT_CUSTOMER_DATA_RESULT ]]
      then
        echo "\nError during customer registration\n"
        MAIN_MENU
      else
        SERVICE_SELECTED=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
        echo -e "\nWhat time would you like your ${SERVICE_SELECTED}, ${CUSTOMER_NAME}?"
        read SERVICE_TIME
        CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE name = '${CUSTOMER_NAME}'")
        INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '${SERVICE_TIME}')")
        
        if [[ -z $INSERT_APPOINTMENT_RESULT ]]
        then
          echo -e "\nError during appointment registration\n"
        else
          echo -e "\nI have put you down for a ${SERVICE_SELECTED} at ${SERVICE_TIME}, ${CUSTOMER_NAME}."
        fi
      fi
    else
      echo -e "\nWhat time would you like your ${SERVICE_SELECTED}, ${CUSTOMER_NAME}?"
      read SERVICE_TIME
      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE name = '${CUSTOMER_NAME}'")
      INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '${SERVICE_TIME}')")
      
      if [[ -z $INSERT_APPOINTMENT_RESULT ]]
      then
        echo -e "\nError during appointment registration\n"
      else
        echo -e "\nI have put you down for a ${SERVICE_SELECTED} at ${SERVICE_TIME}, ${CUSTOMER_NAME}."
      fi
    fi
  fi
}

MAIN_MENU