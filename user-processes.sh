#!/bin/bash

# This project was inspired by training, however, this script is custom solves a problem for quickly investigating resource usage.
# Specifically, it was inspired by training exercises that expect you to solve a problem without giving you the solutions, as anyone expects in the workforce.
#
# 
# Ex: EXERCISE 3: Bash Script - User Processes
# Write a bash script using Vim editor that checks all the processes running for the current user (USER env var) and prints out the processes in console.
# 
# EXERCISE 4: Bash Script - User Processes Sorted
# Extend the previous script to ask for a user input for sorting the processes output either by memory or CPU consumption, and print the sorted list.
# 
# EXERCISE 5: Bash Script - Number of User Processes Sorted
# Extend the previous script to ask additionally for user input about how many processes to print.

echo "This program tells you your current processes running for your user."
echo "Please type 'mem' or 'cpu' to sort by memory or cpu resources. "

read SortingInput
SortCmdOption=""

if [ "$SortingInput" == "mem" ]
then
         SortCmdOption=6
         echo "Sorting by Memory..."
elif [ "$SortingInput" == "cpu" ]
then
         SortCmdOption=3
         echo "Sorting by CPU..."
else
         echo "This process failed. Recheck logic or investigate elsewhere."
fi

echo "Additionally, please tell us how many of the processes you would like to see at this time."

read NumOfProcesses

ps aux | grep $USER | sort -rn -k $SortCmdOption | head -n $NumOfProcesses
