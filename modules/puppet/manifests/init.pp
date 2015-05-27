class puppet {
  file { '/usr/local/bin/papply':
	source => 'puppet:///modules/puppet/papply.sh',
	mode   => '0755',
  }
  file { '/usr/local/bin/pull-updates':
	source => 'puppet:///modules/puppet/pull-updates.sh',
	mode   => '0755',
  }
  
  
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
  
  
  cron { 'run-puppet':
	ensure  => 'present',
	user    => 'root',
	command => '/usr/local/bin/pull-updates',
	minute  => '*/5',
	hour    => '*',
  }
  
   cron { 'core-test-puppet':
	ensure  => 'present',
	user    => 'root',
	command => '/bin/date >>  /tmp/puppet-corn-test.txt',
	minute  => '*/5',
	hour    => '*',
  }
}
