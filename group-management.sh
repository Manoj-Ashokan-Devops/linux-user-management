#!/bin/bash
# Ensure the scripr is run with root user privileges 
if [[ $EUID -ne 0 ]]; then
  echo "Error: Please run this script with sudo (eg., sudo ./group_management.sh)"
  exit 1
fi

# Map each groups to its corresponding user
declare -A GROUP_USERS=(["developers"]="devuser1" ["testers"]="testuser1" ["operations"]="opuser1")
for group in "${!GROUP_USERS[@]}"; do
#1. Create the group if its doesn't already exist
   if getent group "$group" &>/dev/null; then
     echo "Group '$group' already exists. Skipping creation."
   else
     groupadd "$group"
     echo "Created group: $group"
   fi
   for user in ${GROUP_USERS[$group]}; do
    if id "$user" &>/dev/null; then
       usermod -aG "$group" "$user"
       echo "Added '$user' to the '$group'."
    else
       echo "Warning: user '$user' does not exist. Run user-creation.sh first."
     fi
   done
done


