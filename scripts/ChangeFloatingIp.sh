

#!/bin/bash -x
source /home/ubuntu/scripts/base.sh

SERVER_IP="10.212.172.50"
SERVER_IDS=("9c7a3c77-f948-4bb1-9067-f1c7eec03fc5" "57f4fe3c-3590-4351-b5b9-3145a1753d43" "164bf2b0-aad5-40fc-9b71-6bd2078f4e02")

STATUS=$(openstack server list --long | grep 10.212.172.50 | awk '{print $6}')
SERVER_ID=$(openstack server list --long | grep 10.212.172.50 | awk '{print $2}')

is_server_down(){
	local server_id=$1
	local status=$(openstack server show $server_id -c status -f value)

	if [[ "$status" == "SHUTOFF" || "$status" == "ERROR" ]]; then
		return 0
	else
		return 1
	fi
}

if [[ -n "$SERVER_ID" && $(is_server_down "$SERVER_ID") ]]; then
        while openstack floating ip list --status ACTIVE | grep -q "$SERVER_IP"; do
	        sleep 5
	done
	for SERVER in "${SERVER_IDS[@]}"; do
		ok "Done"
		if ! is_server_down "$SERVER"; then
			openstack server add floating ip $SERVER $SERVER_IP
			echo "Floating IP $SERVER_IP reassigned to server $SERVER"
			exit 0
		fi
	done
fi
