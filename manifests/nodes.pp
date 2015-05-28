

file { '/tmp/puppetConrtroll.flag':
	content => 'Under Controll',
}

node 'base' {
	include myhosts
	# include admin::basics
	# include admin::ssh
	  include admin::ntp
	# include puppet::client
	# include backup::client
}


node 'node00', /pcmk0[0-9]/  inherits 'base' {
	include puppet
	include puppet::standalone
}

node 'node01', 'node02'  inherits 'base' {
	include puppet
}



node 's222' inherits 'base' {
  # include cookbook::stages
  
	include puppet::master
	# include haproxy
	# include httpd
	# httpd::snippet { 'site-specific.conf': }
	# httpd::vhost { 'cat-pictures.com': }
	
	# include mysql::server
	# mysql::db { 'myapp':
		# user => 'myapp_user',
		# password => 'xyzzy',
	# }
	
	
	# firewall::role { 'webserver': }
	
	# NFS Server
	nfs::share { 'nfs_share':
		path => '/nfs_share',
		allowed => '*',
		options => 'rw,async,no_root_squash',
	}
	
	nfs::share { 'puppet':
		path => '/home/puppet',
		allowed => '*',
		options => 'rw,async,no_root_squash',
	}
  
	cron { 'change-puppet-own-for-nobody]':
		ensure  => 'present',
		user    => 'root',
		command => 'chown -R nobody:nobody /home/puppet',
		minute  => '*/1',
		hour    => '*',
	}
  
	# append_if_no_such_line { 'edit-hosts-file':
		# file => '/etc/hosts',
		# line => '# test puppet append_if_no_such_line.',
	# }
	
	# augeas { 'enable-ip-forwarding':
		# context => '/files/etc/sysctl.conf',
		# changes => ['set net.ipv4.ip_forward 1'],
	# }
	
	
	# include cookbook::rsyncdconf
	# file { '/etc/rsyncd.d/myapp.conf':
		# ensure => present,
		# source => 'puppet:///modules/cookbook/myapp.rsync',
		# require => File['/etc/rsyncd.d'],
		# notify => Exec['update-rsyncd.conf'],
	# }
	
	
	# exec { 'install-httperf':
		# cwd => '/root',
		# command => '/usr/bin/wget https://httperf.googlecode.com/files/httperf-0.9.0.tar.gz && /bin/tar xvzf httperf-0.9.0.tar.gz && cd httperf-0.9.0 && ./configure && make all && make install',
		# creates => '/usr/local/bin/httperf',
		# timeout => 0,
	# }
	
	
	
	# $app_version = '2.2.2'
	# $min_version = '1.2.10'
	# if versioncmp($app_version, $min_version) >= 0 {
		# notify { 'Version OK': }
	# } else {
		# notify { 'Upgrade needed': }
	# }
	
	
	# include user::virtual
	# include user::sysadmins
	# include user::developers
}




node 'cookbooknode01' {
	class { 'heartbeat::vip':
	ip1 => '10.96.247.132',
	ip2 => '10.96.247.133',
	node1 => 'cookbooknode01',
	node2 => 'cookbooknode02',
	vip => '10.96.247.134/24',
	}
}
node 'cookbooknode02' {
	class { 'heartbeat::vip':
	ip1 => '10.96.247.132',
	ip2 => '10.96.247.133',
	node1 => 'cookbooknode01',
	node2 => 'cookbooknode02',
	vip => '10.96.247.134/24',
	}
}
