#!/bin/bash

read -p "Enter a number: " NUM

if [ $NUM -gt 0 ]; then
        echo "The number is Positive."
elif [ $NUM -lt 0 ]; then
        echo "The number is Negative."
else
        echo "The number is Zero"
fi
