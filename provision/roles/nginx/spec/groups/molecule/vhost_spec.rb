require 'spec_helper'

describe file('/etc/nginx/sites-available/test_1') do
  it { should contain '# extra setting test 1 code' }
end

describe file('/etc/nginx/sites-available/test_4') do
  it { should contain 'server_name localhost;' }
  it { should contain 'stub_status on;' }
  it { should contain 'access_log off;' }
  it { should contain 'allow 127.0.0.1;' }
  it { should contain 'deny all;' }
end
