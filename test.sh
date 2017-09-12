#!/bin/bash
#echo $#
if [ $# -eq 0 ]
then
  echo "need arg iplist"
  exit -1
fi
getpassword(){
  #get1=`ssh  root@$ip "hostname;dmidecode|grep -m1 'Serial Number:'"`
  get1=`ssh  root@$ip "cat /etc/resolv.conf|grep nameserver"`
  echo $get1
  pass=`echo $get1 | awk -F- '{print $3}'`
  #echo $ip  $pass|tee -a pass.txt
}
upload(){
  scp sendfile.txt root@$ip:/tmp
}

runscript(){
  newname=$(echo $prefix | tr '[A-Z]' '[a-z]')-${ip//./-}

  ssh -t root@$ip "date;cd /root;ls -l;exit;sh /tmp/bbd.bin --HOSTNAME=$newname;" | tee $ip.log 2>&1
}

file=$1
prefix='CUC-SD-DZ1'
#echo $1
for ip in `cat $file`
do
  getpassword
  #upload
  #runscript
done
