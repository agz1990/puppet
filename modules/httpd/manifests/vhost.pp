# Manage an httpd virtual host
define httpd::vhost($domain='UNSET',$root='UNSET') {
	include httpd
	if $domain == 'UNSET' {
		$vhost_domain = $name
	} else {
		$vhost_domain = $domain
	}
	if $root == 'UNSET' {
		$vhost_root = "/var/www/${name}"
	} else {
		$vhost_root = $root
	}
	
	file { '/etc/httpd/sites-available':
		ensure => directory,
		mode => '0644',
	}
	
	file { "/etc/httpd/sites-available/${vhost_domain}.conf":
		content => template('httpd/vhost.erb'),
		require => Package['httpd'],
		
		# notify => Exec["enable-${vhost_domain}-vhost"],
	}
	
	# 不适用于 CentOS 洗头膏
	# exec { "enable-${vhost_domain}-vhost":
		# command => "/usr/sbin/a2ensite ${vhost_domain}.conf",
		# require => File["/etc/httpd/sites-available/${vhost_domain}.conf"],
		# refreshonly => true,
		# notify => Service['httpd'],
	# }
}