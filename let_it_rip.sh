#! /bin/sh

inventory_filename=hosts.yml

terraform apply -auto-approve
terraform output -json | python generate_inventory.py > $inventory_filename

# let's wait for all instances to allow us to ssh into
echo "Waiting to give all instances a chance to initialize completely"
sleep 15

# assumes that cp-ansible roles are in the same directory:
# TODO: clean this up
ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i $inventory_filename all.yml
