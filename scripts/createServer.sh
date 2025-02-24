

#!/bin/bash

source /home/ubuntu/scripts/base.sh
#see @dockerInstall.yaml
#will use ubuntu jammy jellyfish
#type yes to intall WITH docker
#the second argument is for the flavor
#see openstack flavor list to see the flavors

if [ "$1"="yes" ]; then
	openstack server create   --image db1bc18e-81e3-477e-9067-eecaa459ec33   --flavor "$2"   --key-name my-key   --security-group default   --network imt3003   --user-data /home/ubuntu/manager/dockerInstall.yaml   "$3"
else [ "$1"="no" ]
	openstack server create   --image db1bc18e-81e3-477e-9067-eecaa459ec33   --flavor "$2"   --key-name my-key   --security-group default   --network imt3003   "$3"
fi
