[database]
vm1 ansible_host=${host1} ansible_user=${user1} ansible_python_interpreter=/usr/bin/python3

[web]
vm1 ansible_host=${host1} ansible_user=${user1} ansible_python_interpreter=/usr/bin/python3

[app]
vm2 ansible_host=${host2} ansible_user=${user1} ansible_python_interpreter=/usr/bin/python3
vm3 ansible_host=${host3} ansible_user=${user2} ansible_python_interpreter=/usr/bin/python2

[all:vars]
ansible_ssh_extra_args='-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
postgresql_version="12"
postgresql_data_directory="/var/lib/postgresql/{{ postgresql_version }}/ma"