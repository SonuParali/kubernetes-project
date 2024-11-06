#!/bin/bash

# Setting up variables
APP_URL="http://192.168.56.12:4499"
LOG_FILE="/var/log/app_health.log"

# Function to check the application's HTTP status
check_app_status() {
    # Sending a request to the application to get the HTTP status code
    http_status=$(curl -o /dev/null -s -w "%{http_code}" "$APP_URL")

    # Depends upon the application is 'up' or 'down' based on the HTTP status code
    if [[ $http_status -ge 200 && $http_status -lt 300 ]]; then
        echo "$(date): Application is UP (HTTP $http_status)." | tee -a "$LOG_FILE"
    else
        echo "$(date): Application is DOWN (HTTP $http_status)." | tee -a "$LOG_FILE"
    fi
}

# Status check function
check_app_status
