#!/bin/bash
sudo apt update -y
sudo apt install -y ansible

#Change /etc/hosts
hostname -I | sed "s/$/$(hostname)/" | tee /etc/hosts
# echo "${WORKER_IP} worker1" | tee -a /etc/hosts

#Edit ansible config
mkdir -p /etc/ansible/
txt="[defaults]\nhost_key_checking=False\npipelining=True\nforks=100"
echo -e $txt > /etc/ansible/ansible.cfg

cd /home/ubuntu
#Edit host file
cat <<EOF > /home/ubuntu/hosts
[all:vars]
ansible_become=true
ansible_ssh_private_key_file=/home/ubuntu/windows.pem
ansible_user=ubuntu

[all]
$(hostname) kubernetes_role="control_plane"
EOF
for WORKER_IP_SHELL in ${WORKER_IP}; do
cat <<EOF >> /home/ubuntu/hosts
$WORKER_IP_SHELL kubernetes_role="node"
EOF
done

#Edit key file
cat << EOF > /home/ubuntu/windows.pem
${PEM_KEYPAIR_CONTENT}
EOF
#change permission
chmod 0400 /home/ubuntu/windows.pem

#Edit playbook

cat <<EOF > /home/ubuntu/playbook.yaml
- hosts: all
  become: true
  become_method: sudo
  become_user: root

  pre_tasks:
    - name: Create containerd config file
      file:
        path: "/etc/modules-load.d/containerd.conf"
        state: "touch"

    - name: Add conf for containerd
      blockinfile:
        path: "/etc/modules-load.d/containerd.conf"
        block: |
              overlay
              br_netfilter

    - name: modprobe
      shell: |
              sudo modprobe overlay
              sudo modprobe br_netfilter


    - name: Set system configurations for Kubernetes networking
      file:
        path: "/etc/sysctl.d/99-kubernetes-cri.conf"
        state: "touch"

    - name: Add conf for containerd
      blockinfile:
        path: "/etc/sysctl.d/99-kubernetes-cri.conf"
        block: |
               net.bridge.bridge-nf-call-iptables = 1
               net.ipv4.ip_forward = 1
               net.bridge.bridge-nf-call-ip6tables = 1

    - name: Apply new settings
      command: sudo sysctl --system
    - name: Swap off
      shell: |
              sudo swapoff -a
              sudo sed -i '/swap/ s/^\(.*\)$/#\1/g' /etc/fstab
    - name: Update and upgrade apt packages
      shell: |
              apt update
  roles:
    - geerlingguy.containerd
    - ansible-role-kubernetes
EOF
#Install ansible-role
sudo -H -u ubuntu bash -c 'ansible-galaxy install geerlingguy.containerd'
cd /home/ubuntu/.ansible/roles/
sudo -H -u ubuntu bash -c 'git clone https://github.com/geerlingguy/ansible-role-kubernetes.git'


#change permission
chown ubuntu:ubuntu /home/ubuntu/hosts
chown ubuntu:ubuntu /home/ubuntu/playbook.yaml
chown ubuntu:ubuntu /home/ubuntu/windows.pem
#Run playbook
sudo -H -u ubuntu bash -c 'ansible-playbook -i /home/ubuntu/hosts /home/ubuntu/playbook.yaml'

# #Copy config file 
mkdir -p /home/ubuntu/.kube
cp /etc/kubernetes/admin.conf /home/ubuntu/.kube
mv /home/ubuntu/.kube/admin.conf  /home/ubuntu/.kube/config
sudo chown -R ubuntu:ubuntu /home/ubuntu/.kube