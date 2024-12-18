#!/bin/bash

touch users.txt

sed 's/:.*//' /etc/passwd > users.txt

i=1
for user in $(cat users.txt); do
  echo "$i. $user"
  ((i++))
done
