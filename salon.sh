#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\nWelcome to My Salon, how can I help you?"
SERVICE_MENU() {
  if [[ $1 ]]; then
    echo -e "\n$1"
  fi
  #Show services
  echo "$($PSQL "SELECT * FROM services")" | while read SERVICE_ID BAR SERVICE_NAME; do
    echo "$SERVICE_ID) $SERVICE_NAME"
  done;
  read SERVICE_ID_SELECTED
  CHOICE=$($PSQL "SELECT * FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  FORMATTED_CHOICE=$(echo $CHOICE | sed -r 's/[0-9]+ *\| *//')
  if [[ -z $CHOICE ]]; then
    SERVICE_MENU "I could not find that service. What would you like today?"
  else
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
    if [[ -z $CUSTOMER_NAME ]]; then
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read CUSTOMER_NAME
      INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone,name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
      CUSTOMER_NAME=$CUSTOMER_NAME
    fi
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
    FORMATTED_CUSTOMER_NAME=$(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//')
    echo -e "\nWhat time would you like me to $FORMATTED_CHOICE, $FORMATTED_CUSTOMER_NAME?"
    read SERVICE_TIME
    INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id,service_id,time) VALUES($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
    echo "I have put you down for a $FORMATTED_CHOICE at $SERVICE_TIME, $CUSTOMER_NAME."
  fi
}

SERVICE_MENU
