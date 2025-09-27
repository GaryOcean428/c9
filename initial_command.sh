#!/bin/bash

# Run database setup first
if [ -f "/root/setup_database.sh" ]; then
    echo "Setting up database connection..."
    /root/setup_database.sh
fi

# Check if INITIAL_COMMAND is set and not empty
if [ -n "$INITIAL_COMMAND" ]; then
  echo "Running initial command: $INITIAL_COMMAND"
  eval "$INITIAL_COMMAND"
else
  echo "No initial command provided, proceeding normally."
fi

