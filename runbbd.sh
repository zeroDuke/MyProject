#!/bin/bash

filename=''
netmask=''
gateway=''
prefix='CUC-SD-DZ1'
ip=''
getInfo(){
  pass=$(sudo ssh -p23432 -t root@$ip "hostname"|awk -F- '{ print $3 }')
  serial=$(sudo ssh -p23432 -t root@$ip "dmidecode|grep -m 1 'Serial Number:'"|awk -F '{ print $3 }')
  #pass=$(sudo ssh -p23432 -t $ip "hostname"|awk -F- '{ print $3 }')
  #serial=$(sudo ssh -p23432 -t $ip "dmidecode|grep -m 1 'Serial Number:'")
  #serial="91732240312345"
  echo -e $ip    $serial    $pass
}

upLoad(){
  sudo scp -P 23432 ./software/bbd.bin $ip:/tmp
}

runInit(){
  newname=${prefix,,}-${ip//./-}
  echo $newname
  sudo ssh -p23432 -t root@$ip "sh /tmp/bbd.bin --HOSTNAME=$newname | tee -a /tmp/$ip.log ;sh /tmp/bbd.bin --basic sh | tee -a /tmp/$ip.log ;sh /tmp/bbd.bin --basic sh | tee -a /tmp/$ip.log "
}

downLoadlog(){
  mkdir -p remotelog
  sudo scp -p 23432 $ip:/tmp/$ip.log ./logs/remote/$prefix/
}

mkdir -p locallog
for ip in `cat iplist.txt` do
  getInfo $ip | tee -a $ip.log
  #upLoad
  #runInit | tee -a .logs/local/$ip.log
  #downLoadlog
done
