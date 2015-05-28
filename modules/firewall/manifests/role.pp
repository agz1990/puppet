# Manage a specific firewall role
define firewall::role() {
	include firewall
	file { "/etc/firewall/roles/${name}":
		source => "puppet:///modules/firewall/${name}.role",
		require => File['/etc/firewall/roles'],
		notify => Exec['run-iptables'],
	}
	append_if_no_such_line { "${name} role":
		file => "/etc/firewall/hosts/${::hostname}",
		line => ". `dirname \$0`/roles/${name}",
		require => File["/etc/firewall/hosts/${::hostname}"],
		notify => Exec['run-iptables'],
	}
}