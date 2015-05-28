class puppet {

  file { '/root/.ssh/id_rsa':
	source => 'puppet:///modules/puppet/id_rsa',
	owner  => 'root',
	mode   => '0600',
  }
  
  file { '/root/.ssh/authorized_keys':
	source => 'puppet:///modules/puppet/authorized_keys',
	owner  => 'root',
	mode   => '0600',
  }
  
  file { '/root/.ssh/id_rsa.pub':
	source => 'puppet:///modules/puppet/id_rsa.pub',
	owner  => 'root',
	mode   => '0644',
  }
  
}
