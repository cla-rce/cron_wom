name             'cron_wom'
maintainer       'Peter Walz, University of Minnesota'
maintainer_email 'pnw@umn.edu'
license          'Apache 2.0'
description      'Provides the cron_wom resource, which adds a week_of_month attribute to the standard cron resource'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

depends 'compat_resource'

%w(amazon centos debian fedora redhat scientific ubuntu).each do |os|
  supports os
end

chef_version '>= 12.0' if respond_to?(:chef_version)

source_url 'https://github.com/cla-rce/cron_wom' if respond_to?(:source_url)
issues_url 'https://github.com/cla-rce/cron_wom/issues' if respond_to?(:issues_url)
