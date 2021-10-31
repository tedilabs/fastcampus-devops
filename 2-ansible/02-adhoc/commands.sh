#!/usr/bin/env sh

ansible -i vars.inv all -m ping
ansible -i vars.inv amazon -m command -a "uptime"
ansible localhost -m setup
ansible localhost -m setup -a "filter=ansible_dist*"
ansible -i vars.inv -m apt -a "name=git state=latest update_cache=yes" ubuntu
ansible -i vars.inv -m apt -a "name=git state=latest update_cache=yes" ubuntu --become
ansible -i vars.inv -m apt -a "name=git state=absent update_cache=yes" ubuntu --become
