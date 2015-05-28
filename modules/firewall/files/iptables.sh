. `dirname $0`/names

export EXT_INTERFACE=eth0

# Flush and remove all chains
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -F
iptables -X

HOST_RULES=`dirname $0`/hosts/`hostname -s`

[ -f ${HOST_RULES} ] && . ${HOST_RULES}

. `dirname $0`/roles/common

# Drop all non-matching packets
iptables -A INPUT -j LOG --log-prefix "INPUT: "
iptables -A INPUT -j DROP
iptables -A OUTPUT -j LOG --log-prefix "OUTPUT: "
iptables -A OUTPUT -j DROP