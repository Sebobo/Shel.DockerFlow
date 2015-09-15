#!/bin/bash

# Exit with error if a command returns a non-zero status
set -e

# Get id of the owner
if [ -d /var/www ]; then
	user_id=`stat -c "%u" /var/www`
	user_group=50

	# Check status of directory owner and guest account
	user_exists=false
	guest_exists=false
	getent passwd ${user_id} >/dev/null 2>&1 && user_exists=true
	getent passwd guest >/dev/null 2>&1 && guest_exists=true

	# Check if user does not exist in passwd
	if [ "$user_exists" = false ]; then
		if [ "$guest_exists" = false ]; then
			# Create user for volume access so writing to the project works fine
			echo "User $user_id does not yet exist. Adding..."
			adduser --system --uid=${user_id} --gid=${user_group} --home /home/guest --shell /bin/bash guest
		else
			# Change uid of guest user to new uid
			echo "Changing guests id to $user_id"
			usermod -u ${user_id} guest
		fi
	fi
fi

# Update app container host file to be able to access host machine
export DOCKER_HOST_IP=$(route -n | awk '/UG[ \t]/{print $2}')
echo "${DOCKER_HOST_IP}	dockerhost" >> /etc/hosts

# Update app container host file to be able to access web container
cat /ip_address.txt >> /etc/hosts

# Run normal command
exec "$@"
