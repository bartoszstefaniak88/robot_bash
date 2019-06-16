#/usr/bin/python

import paramiko

zdalny_serwer=paramiko.SSHClient()

zdalny_serwer.set_missing_host_key_policy(paramiko.AutoAddPolicy())
zdalny_serwer.connect("localhost",username='tester',password="tester")
a,b,c=zdalny_serwer.exec_command("uname -a")
#print b.read()
tresc_b=b.read()
if "UTC 2019 x86_64 x86_64 x86_64 GNU/Linuxx" in tresc_b :
    print("jest ok")
else:
    print("nie jest ok")
