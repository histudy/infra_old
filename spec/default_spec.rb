require 'spec_helper'

describe package('dehydrated') do
  it { should be_installed }
end

describe file('/etc/dehydrated/conf.d/localhost.sh') do
  it { should exist }
  it { should be_file }
  it { should contain 'CA="https://acme-staging.api.letsencrypt.org/directory"' }
  it { should contain 'CHALLENGETYPE="dns-01"' }
  it { should contain 'DEHYDRATED_USER=root' }
  it { should contain 'DEHYDRATED_GROUP=adm' }
  it { should contain 'IP_VERSION=4' }
  it { should contain 'OLDCA=""' }
  it { should contain 'KEYSIZE="2048"' }
  it { should contain 'OPENSSL_CNF=' }
  it { should contain 'OPENSSL="/usr/bin/openssl"' }
  it { should contain 'CURL_OPTS=""' }
  it { should contain 'HOOK_CHAIN="yes"' }
  it { should contain 'RENEW_DAYS="31"' }
  it { should contain 'PRIVATE_KEY_RENEW="no"' }
  it { should contain 'PRIVATE_KEY_ROLLOVER="yes"' }
  it { should contain 'KEY_ALGO=prime256v1' }
  it { should contain 'CONTACT_EMAIL=pc.poisoning@gmail.com' }
  it { should contain 'OCSP_MUST_STAPLE="yes"' }
  it { should contain 'OCSP_FETCH="no"' }
  it { should contain 'AUTO_CLEANUP="yes"' }
  it { should contain 'API=1' }
end

describe file('/etc/dehydrated/domains.txt') do
  it { should exist }
  it { should be_file }
  its(:content) { should match(/^example.com$/) }
  its(:content) { should match(/^example.net www.example.net$/) }
end

describe file('/etc/cron.d/ansible_management_job') do
  it { should contain '/usr/bin/dehydrated --cron' }
end

describe file('/etc/dehydrated/hook.sh') do
  it { should exist }
  it { should be_file }
  it { should be_executable }
  it { should contain '# test hook initialize' }
  it { should contain '# test deploy_challenge hook' }
  it { should contain '# test clean_challenge hook' }
  it { should contain '# test deploy_cert hook' }
  it { should contain '# test unchanged_cert hook' }
  it { should contain '# test invalid_challenge hook' }
  it { should contain '# test request_failure hook' }
  it { should contain '# test generate_csr hook' }
  it { should contain '# test startup_hook hook' }
  it { should contain '# test exit_hook hook' }
end
