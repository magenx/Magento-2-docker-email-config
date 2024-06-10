#!/bin/bash

# Define a marker file to indicate if the container is running for the first time
FIRST_RUN_FILE="${ROUNDCUBEMAIL_ROOT_PATH}/.firstrun"
# Check if the marker file exists
if [ ! -f ${FIRST_RUN_FILE} ]; then
    echo "First run detected. Running initial database setup..."
    # Place the commands you want to run only on the first start here
    cd ${ROUNDCUBEMAIL_ROOT_PATH}
    mysql ${ROUNDCUBEMAIL_DATABASE} < SQL/mysql.initial.sql
    # Create the marker file to indicate that the initial setup has been run
    touch ${FIRST_RUN_FILE}
fi
# Run the main command passed as arguments
exec "$@"
