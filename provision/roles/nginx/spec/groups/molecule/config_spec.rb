require 'spec_helper'

describe file('/etc/nginx/nginx.conf') do
  it { should contain '# nginx.conf extra setting' }
end
