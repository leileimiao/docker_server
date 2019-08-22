#!/bin/sh
# allow the container to be start with username & password

while getopts 'u:p:' OPT; do
	case $OPT in
		u)
			username=$OPTARG;;
		p)
			password=$OPTARG;;
		?)
			echo "unknown argument"
			exit
			;;
	esac
done

shift $(($OPTIND - 1))

groupadd -r $username 
useradd -m -s /bin/bash -r -g $username $username
echo $username:$password | chpasswd
passwd -e $username # force user to change initial password
usermod -aG sudo $username 

/usr/sbin/sshd -D
