require 'spec_helper'

describe package('dehydrated') do
  it { should be_installed }
end

describe file('/etc/dehydrated/conf.d/local.sh') do
  it { should exist }
  it { should be_file }

  dehydrated_cfg = property['dehydrated_cfg']

  it { should contain 'CA="' + dehydrated_cfg['ca'] + '"' }
  it { should contain 'OLDCA="' + dehydrated_cfg['oldca'] + '"' }
  it { should contain 'DEHYDRATED_USER=' + dehydrated_cfg['user'] }
  it { should contain 'DEHYDRATED_GROUP=' + dehydrated_cfg['group'] }
  it { should contain 'CHALLENGETYPE="' + dehydrated_cfg['challengetype'] + '"' }
  it { should contain 'KEYSIZE="' + dehydrated_cfg['keysize'].to_s + '"' }
  it { should contain 'OPENSSL_CNF=' + dehydrated_cfg['openssl_cnf'] }
  it { should contain 'OPENSSL="' + dehydrated_cfg['openssl'] + '"' }
  it { should contain 'CURL_OPTS="' + dehydrated_cfg['curl_opts'] + '"' }
  hook_chain = dehydrated_cfg['hook_chain'] ? 'yes' : 'no'
  it { should contain 'HOOK_CHAIN="' + hook_chain + '"' }
  it { should contain 'RENEW_DAYS="' + dehydrated_cfg['renew_days'].to_s + '"' }
  private_key_renew = dehydrated_cfg['private_key_renew'] ? 'yes' : 'no'
  it { should contain 'PRIVATE_KEY_RENEW="' + private_key_renew + '"' }
  private_key_rollover = dehydrated_cfg['private_key_rollover'] ? 'yes' : 'no'
  it { should contain 'PRIVATE_KEY_ROLLOVER="' + private_key_rollover + '"' }
  it { should contain 'KEY_ALGO=' + dehydrated_cfg['key_algo'] }
  it { should contain 'CONTACT_EMAIL=' + dehydrated_cfg['contact_email'] }
  ocsp_must_staple = dehydrated_cfg['ocsp_must_staple'] ? 'yes' : 'no'
  it { should contain 'OCSP_MUST_STAPLE="' + ocsp_must_staple + '"' }
  ocsp_fetch = dehydrated_cfg['ocsp_fetch'] ? 'yes' : 'no'
  it { should contain 'OCSP_FETCH="' + ocsp_fetch + '"' }
  auto_cleanup = dehydrated_cfg['auto_cleanup'] ? 'yes' : 'no'
  it { should contain 'AUTO_CLEANUP="' + auto_cleanup + '"' }
  api = dehydrated_cfg['api'].is_a?(String) ? dehydrated_cfg['api'] : dehydrated_cfg['api'].to_s
  it { should contain 'API=' + api }
end

describe file('/etc/dehydrated/domains.txt') do
  it { should exist }
  it { should be_file }
  property['dehydrated_domains'].each do |domain|
    aliases = domain['name']
    domains = domain['domains'].is_a?(String) ? domain['domains'] : domain['domains'].join(' ')
    its(:content) { should match(/^#{e(domains)} > #{e(aliases)}$/) }
  end
end

describe file('/etc/cron.d/ansible_management_job') do
  it { should contain '/usr/bin/dehydrated --cron' }
end

describe file('/etc/dehydrated/hook.sh') do
  it { should exist }
  it { should be_file }
  it { should be_executable }
end
