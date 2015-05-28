# Manage iptables firewall
class firewall {
	file { ['/etc/firewall',
		'/etc/firewall/hosts',
		'/etc/firewall/roles']:
		ensure => directory,
	}
	
	file { '/etc/firewall/names':
		source => 'puppet:///modules/firewall/names',
		notify => Exec['run-iptables'],
	}
	file { '/etc/firewall/roles/common':
		source => 'puppet:///modules/firewall/common.role',
		notify => Exec['run-iptables'],
	}
	file { '/etc/firewall/iptables.sh':
		source => 'puppet:///modules/firewall/iptables.sh',
		mode => '0755',
		notify => Exec['run-iptables'],
	}
	file { "/etc/firewall/hosts/${::hostname}":
	content => "export MAIN_IP=${::ipaddress}\n
export PRIVATE_IP=${::ipaddress_eth1}\n",
	require => File['/etc/firewall/hosts'],
	notify => Exec['run-iptables'],
	}
	
	exec { 'run-iptables':
		cwd => '/etc/firewall',
		command => "/usr/bin/test -f hosts/${::hostname} && /etc/firewall/iptables.sh && /sbin/iptables-save > /etc/iptables.rules",
		refreshonly => true,
	}
	
	# append_if_no_such_line { 'restore iptables rules':
		# file => '/etc/network/interfaces',
		# line => 'pre-up iptables-restore < /etc/iptables.rules',
	# }
}