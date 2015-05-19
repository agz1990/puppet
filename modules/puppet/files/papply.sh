#!/bin/sh
sudo puppet apply /home/puppet/manifests/site.pp --modulepath=/home/puppet/modules/ $*
