require 'spec_helper'

property['php_packages'].each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

if property['php_composer_install']
  describe package('composer') do
    it { should be_installed }
  end
end

if property['php_packages'].include?(property['php_fpm_package_name'])
  describe service(property['php_fpm_service_name']) do
    it { should be_enabled }
    it { should be_running }
  end
end
