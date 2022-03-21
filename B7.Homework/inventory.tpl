[master]
master_node ansible_host=${host1}

[node]
worker_node1 ansible_host=${host2}

[all:vars]
ansible_python_interpreter=/usr/bin/python3