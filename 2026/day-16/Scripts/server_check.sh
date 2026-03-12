#!/bin/bash

read -p "Enter service name: " SERVICE
read -p "Enter choice(y/n) : " CHOICE

if [ "$CHOICE" = "y" ]; then
        systemctl status $SERVICE
else
        echo "Skipped."
fi

~           