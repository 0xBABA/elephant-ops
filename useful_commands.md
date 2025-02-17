# Useful commands
- create an SSH tunnel to a consul machine that holds the UI:</br>
`ssh -F ansible.ssh.config -N -f -L 8500:localhost:8500 ubuntu@<consul server private ip>` 
</br>then go to http://localhost:8500/ui

- once service account has iam role for Ec2FullAccess we can test it via:
`kubectl -n opsschool-mid-project-k8s-ns run --command=true --serviceaccount='k8s-sa' --rm -i --tty awscli --image=amazon/aws-cli --restart=Never aws ec2 describe-instances`

- ssh to prometheus server and run:
`curl http://10.0.11.109:8500/v1/agent/metrics?format=prometheus | less`
=> see consul metrics

jenkins
42221020727f445d9770b532236cd836

curl http://169.254.169.254/latest/meta-data/tags/instance/Name

## to copy and backup grafana.db 
on monitoring host:
  sudo cp /var/lib/grafana/grafana.db ./
  sudo chown ubuntu ./grafana.db
on bastion:
  rsync -avz ubuntu@10.0.11.33:~/./grafana.db ./
on local machine:
  rsync -avzh ubuntu@<bastion public ip>:/home/ubuntu/grafana.db ./

