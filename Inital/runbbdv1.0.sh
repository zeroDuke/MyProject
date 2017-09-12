#!/bin/bash
node=$1
node="CUC-SD-DZ1"
prefix=$(echo $node | tr '[A-Z]' '[a-z]')
ipmi_mask=$2
ipmi_gw=$3
getPass(){
  for i in `cat hostlist.txt`;do
    pass=`sudo ssh -p23432 $i "hostname"`
    echo $pass,$i | tee -a pass.txt
  done
}

upload(){
  for i in `cat t1.txt`;do
    sudo scp -P 23432 ~/software/bbd.bin $i:/tmp
}

ipmi(){
  ipmi_ip=$i
  echo $ip1 | awk '{sub(/[0-9]+/,"11",$1)}1'
  sudo ssh -p23432 $i
}

doInit(){
  for i in `cat t1.txt`;do
    fip=${i//\./-}
    hname=$prefix-$fip
    echo $hname
    sudo ssh -p23432 $i "cd /tmp;service iptables stop;chmod +x bbd.bin;sh bbd.bin --hostname=$hname | tee -a ./install.log 2>&1;sh bbd.bin --basic | tee -a ./install.log 2>&1;sh bbd.bin --basic | tee -a ./install.log 2>&1;sh bbd.bin --basic | tee -a ./install.log 2>&1" | tee -a $i.log
  done
}

getInfo(){
  info=`sudo ssh -p23432 $i "hostname;dmidecode|grep -m 1 'Serial Number'"`
  password=`sudo ssh -p23432 $i "hostname;exit"|awk -F- '{ print $3 }'`
  serial=`sudo ssh -p23432 $i "dmidecode|grep -m 1 'Serial Number:'"|awk '{ print $3 }'`
  echo $i,$serial,$passwd
}
upload(){
  sudo scp -p23432 ~/software/bbd.bin $i:/tmp
}
runbbd(){
  new_name=$(echo $node | tr '[A-Z]' '[a-z]')-${i//\./-}
  sudo ssh -p23432 $i "cd /tmp;service iptables stop;chmod +x bbd.bin;sh bbd.bin --hostname=$hname | tee -a ./install.log 2>&1;sh bbd.bin --basic | tee -a ./install.log 2>&1;sh bbd.bin --basic | tee -a ./install.log 2>&1;sh bbd.bin --basic | tee -a ./install.log 2>&1" | tee -a $i.log

}
