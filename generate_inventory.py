# Copyright 2020 Confluent
# Contributors:
#   Sven Erik Knop sven@confluent.io
#   Christoph Schubert cschubert@confluent.io
#
# All rights reserved

# usage terraform output -json | python generate_inventory.py

import datetime
import json
import sys

from jinja2 import Template


def get_values(raw_data, field_name):
    return raw_data[field_name]['value']


def parse_cp_data(raw_data):
    return {
        'zookeeper_nodes':get_values(raw_data, 'zookeepers'),
        'kafka_broker_nodes': get_values(raw_data, 'brokers'),
        'schema_registry_nodes': get_values(raw_data, 'schema_registry'),
        'rest_proxy_nodes': get_values(raw_data, 'rest_proxy'),
        'ksql_nodes': get_values(raw_data, 'ksql'),
        'connect_nodes': get_values(raw_data, "connect"),
        'control_center_nodes': get_values(raw_data, "c3")
    }

if __name__ == '__main__':
    raw_data = json.load(sys.stdin)

    ansible_vars = {
        'user': raw_data['ssh_username']['value'],
        'keyfile': raw_data['ssh_key']['value']
    }

    with open("hosts.j2") as template_file:
        template = Template(template_file.read())

        print(template.render(
            cluster_data=parse_cp_data(raw_data),
            timestamp=datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
            ansible_vars=ansible_vars
        ))
