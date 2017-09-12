#!/usr/bin/env python
# -*- coding:utf-8 -*-

import subprocess
import re

class pc(object):
    def getip(self):
        obj = subprocess.Popen(['ip addr'],stdin=subprocess.PIPE,stdout=subprocess.PIPE,stderr=subprocess.PIPE,shell=True,universal_newlines=True)
        output = obj.communicate()[0]
        patt = re.compile(r'\d:\s(?P<nic>.+?):\s.+?inet\s(?P<ipadd>\d+\.\d+\.\d+\.\d+)',re.S)
        res = re.findall(patt,output)
        IPs = {}
        for i in res:
            IPs[i[0]] = i[1]
        #print(dict)
        return IPs

p = pc()
print(p.getip())

