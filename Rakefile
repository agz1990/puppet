SSH = 'ssh -t -A '
REPO = 'https://github.com/agz1990/puppet.git' 

desc "Run Puppet on ENV['CLIENT']"
task :apply do
	client = ENV['CLIENT']
	sh "#{SSH} #{client} pull-updates"
end


desc "Bootstrap Puppet on ENV['CLIENT'] whih CentOS "

task :bootstrap do
	client = ENV['CLIENT']
# Enterprise Linux 7
# sudo rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm \
# Enterprise Linux 6
# sudo rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm \
# Enterprise Linux 5
# sudo rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-5.noarch.rpm
	commands = <<BOOTSTRAP
rm /home/puppet -rf && \
rpm -qa | grep puppet | xargs rpm -e 2>/dev/null; \
rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm && \
yum install -y puppet git && \
cd /home/ && git clone #{REPO} puppet && \
puppet apply --modulepath=/home/puppet/modules /home/puppet/manifests/site.pp
BOOTSTRAP
sh "#{SSH} #{client} '#{commands}'"
end



desc "Add syntax check hook to your git repo"
task :add_check do
	here = File.dirname(__FILE__)
	sh "ln -s #{here}/hooks/check_syntax.sh #{here}/.git/hooks/pre-commit"
	puts "Puppet syntax check hook added"
end
