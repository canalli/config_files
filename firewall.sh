#!/bin/bash
#-----------------DCUMENTACAO---------------
# Autor         : Rafael Canalli
# Contato       : rafael.canalli@underprotection.com.br
# Data          : 20/09/2021
# Uso           : Regras de exempro para Firewall para servidor web
# Requisito     : Conter o IPTABLES e desativar o Firewalld da redhat
# Atualizcoes   :
# Versao        : 1.0
#-------------------------------------------

#----VARIAVEIS----#

IPT="/sbin/iptables"
PUB_IF="enp0s3"
#ARQBADIPS=root/scripts/blocked.fw 

#----FUNCOES----#


#----MAIM----#

echo "Starting IPv4 Wall..."
$IPT -F
$IPT -X
$IPT -t nat -F
$IPT -t nat -X
$IPT -t mangle -F
$IPT -t mangle -X
modprobe ip_conntrack



#if [ -e '$ARQBADIPS' ]; then
#	BADIPS=$(egrep -v -E "^#|^$" /root/scripts/blocked.fw)
#fi

#unlimited 
$IPT -A INPUT -i lo -j ACCEPT
$IPT -A OUTPUT -o lo -j ACCEPT
 
# DROP all incomming traffic
$IPT -P INPUT DROP
$IPT -P OUTPUT DROP
$IPT -P FORWARD DROP
 
# block all bad ips
#if [ -e '$ARQBADIPS' ]; then
#	for ip in $BADIPS
#	do
#	    $IPT -A INPUT -s $ip -j DROP
#	    $IPT -A OUTPUT -d $ip -j DROP
#	done
#fi

# sync
$IPT -A INPUT -i ${PUB_IF} -p tcp ! --syn -m state --state NEW  -m limit --limit 5/m --limit-burst 7 # -j LOG --log-level 4 --log-prefix "Drop Syn"
$IPT -A INPUT -i ${PUB_IF} -p tcp ! --syn -m state --state NEW -j DROP
 
# Fragments
$IPT -A INPUT -i ${PUB_IF} -f  -m limit --limit 5/m --limit-burst 7 # -j LOG --log-level 4 --log-prefix "Fragments Packets"
$IPT -A INPUT -i ${PUB_IF} -f -j DROP
 
 
# block bad stuff
$IPT  -A INPUT -i ${PUB_IF} -p tcp --tcp-flags ALL FIN,URG,PSH -j DROP
$IPT  -A INPUT -i ${PUB_IF} -p tcp --tcp-flags ALL ALL -j DROP
 
$IPT  -A INPUT -i ${PUB_IF} -p tcp --tcp-flags ALL NONE -m limit --limit 5/m --limit-burst 7 # -j LOG --log-level 4 --log-prefix "NULL Packets"
$IPT  -A INPUT -i ${PUB_IF} -p tcp --tcp-flags ALL NONE -j DROP # NULL packets
 
$IPT  -A INPUT -i ${PUB_IF} -p tcp --tcp-flags SYN,RST SYN,RST -j DROP
 
$IPT  -A INPUT -i ${PUB_IF} -p tcp --tcp-flags SYN,FIN SYN,FIN -m limit --limit 5/m --limit-burst 7 # -j LOG --log-level 4 --log-prefix "XMAS Packets"
$IPT  -A INPUT -i ${PUB_IF} -p tcp --tcp-flags SYN,FIN SYN,FIN -j DROP #XMAS
 
$IPT  -A INPUT -i ${PUB_IF} -p tcp --tcp-flags FIN,ACK FIN -m limit --limit 5/m --limit-burst 7 # -j LOG --log-level 4 --log-prefix "Fin Packets Scan"
$IPT  -A INPUT -i ${PUB_IF} -p tcp --tcp-flags FIN,ACK FIN -j DROP # FIN packet scans
 
$IPT  -A INPUT -i ${PUB_IF} -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j DROP
 
 
# Allow full outgoing connection but no incomming stuff
$IPT -A INPUT -i ${PUB_IF} -m state --state ESTABLISHED,RELATED -j ACCEPT
$IPT -A OUTPUT -o ${PUB_IF} -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
 
# allow ssh
$IPT -A INPUT -p tcp --destination-port 22 -j ACCEPT
$IPT -A OUTPUT -p tcp --sport 22 -j ACCEPT

# allow HTTP
$IPT -A INPUT -p tcp --destination-port 80 -j ACCEPT
$IPT -A OUTPUT -p tcp --sport 80 -j ACCEPT

# allow HTTPS
$IPT -A INPUT -p tcp --destination-port 80 -j ACCEPT
$IPT -A OUTPUT -p tcp --sport 80 -j ACCEPT

# allow incoming ICMP ping pong stuff
$IPT -A INPUT -p icmp --icmp-type 8 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
$IPT -A OUTPUT -p icmp --icmp-type 0 -m state --state ESTABLISHED,RELATED -j ACCEPT
 
# No smb/windows sharing packets - too much logging
$IPT -A INPUT -p tcp -i ${PUB_IF} --dport 137:139 -j REJECT
$IPT -A INPUT -p udp -i ${PUB_IF} --dport 137:139 -j REJECT
 
# Log everything else
# *** Required for psad ****
#$IPT -A INPUT -j LOG 
#$IPT -A FORWARD -j LOG 
#$IPT -A INPUT -j DROP
 
# Start ipv6 firewall
# echo "Starting IPv6 Wall..."
#/root/scripts/start6.fw
 
exit 0
