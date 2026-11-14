#!/bin/bash
if [[ $EUID -ne 0 ]]; then
 echo "Error: Please run this script with sudo(e.g, sudo ./user-creation)"
 exit 1
fi

USERS=("devuser1" "testuser1" "opuser1")

for user in "${USERS[@]}"; do
 if id "$user" &>/dev/null; then
  echo "User '$user' already exists. Skipping."
 else
  useradd -m -s /bin/bash "$user"
  echo "Created user: $user"
fi
done

  
