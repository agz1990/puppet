# Manage puppetagent
class puppet::agent {
	include puppet

	service { 'puppet':
		ensure  => 'running',
		enable => true,
	}
	
	file { '/etc/puppet/puppet.conf':
		source => 'puppet:///modules/puppet/puppet.conf',
		mode   => '0755',
		notify => Service['puppet'],
	} 
  
}