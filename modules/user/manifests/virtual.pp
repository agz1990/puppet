class user::virtual {
	@user { 'nirmala': ensure => absent }
	@user { 'sarah': ensure => absent }
	@user { 'jeff': ensure => absent }
	@user { 'ayomide': ensure => absent }
	
	define user_dotfile($user) {
			$source = regsubst($name, "^/home/${user}/.(.*)$", "puppet:///modules/user/${user}-\\1")
			file { $name:
			source => $source,
			owner => $user,
			group => $user,
		}
	}
	
	define ssh_user($key, $dotfile='') {
	
		user { $name:
			ensure => present,
			managehome => true,
		}
		file { "/home/${name}/.ssh":
			ensure => directory,
			mode => '0700',
			owner => $name,
		}
		
		ssh_authorized_key { "${name}_key":
			key => $key,
			type => 'ssh-rsa',
			user => $name,
			require => File["/home/${name}/.ssh"],
		}
		
		if $dotfile {
			$filepath = regsubst($dotfile,'^(.*)$',"/home/${name}/.\\0",'G')
			user_dotfile { $filepath:
			user => $name,
			}
		}
	}
	
	

	@ssh_user { 'aliza':
		key => 'AAAAB3NzaC1yc2EAAAABIwAAAIEA3ATqENg+GWACa2BzeqTdGnJhNoBer8x6pfWkzNzeM8Zx7/2Tf2pl7kHdbsiTXEUawqzXZQtZzt/j3Oya+PZjcRpWNRzprSmd2UxEEPTqDw9LqY5S2B8og/NyzWaIYPsKoatcgC7VgYHplcTbzEhGu8BsoEVBGYu3IRy5RkAcZik=',
	}
	
	@ssh_user { 'jamil':
		key => 'xyz',
		dotfile => ['bashrc','vimrc'],
	}
	
	@ssh_user { 'scarlet':
		key => 'abc',
		dotfile => ['rvmrc','emacs'],
	}

}

