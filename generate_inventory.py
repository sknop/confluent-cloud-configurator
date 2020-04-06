# Copyright 2020 Confluent
# Contributors:
#   Sven Erik Knop sven@confluent.io
#   Christoph Schubert cschubert@confluent.io
#
# All rights reserved

# usage terraform output -json | python generate_inventory.py

import datetime
import json
import os
import sys

from jinja2 import Template

# TODO: test how we deal with empty data fields (e.g. no control center nodes configured in terraform)
def dictlist_to_listdic(dict_list):
    """
    converts a dictionary of lists to a list of dictionaries
    """
    return [dict(zip(dict_list,t)) for t in zip(*dict_list.values())]

def get_values(raw_data, field_name):
    return raw_data[field_name]['value']

def parse_cp_data(raw_data):
    return {
        'zookeeper_nodes': dictlist_to_listdic({
            'host': get_values(raw_data, 'zookeeper_public_dns'),
            #'az': get_values(raw_data, 'broker_az'),
            'tags': get_values(raw_data, 'zookeeper_tags')
        }),
        'kafka_broker_nodes': dictlist_to_listdic({
            'host': get_values(raw_data, 'broker_public_dns'),
            'az': get_values(raw_data, 'broker_az'),
            'tags': get_values(raw_data, 'broker_tags')
        }),
        'control_center_nodes': get_values(raw_data, "c3_public_dns"),
        'connect_nodes': get_values(raw_data, "connect_public_dns")
    }


raw_data = json.load(sys.stdin)

# TODO: move hard coded settings to terraform output variables
ansible_vars = {
  'user': 'ubuntu',
  'keyfile': "~/.ssh/terraform"
}


with open("hosts.j2") as template_file:
    template = Template(template_file.read())

    print(template.render(
        cluster_data = parse_cp_data(raw_data),
        timestamp = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
        ansible_vars = ansible_vars
    ))
