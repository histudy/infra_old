require 'spec_helper'

describe file('/etc/nginx/nginx.conf') do
  it { should exist }
  it { should be_file }

  its(:content) { should match(/^user #{e(property['nginx_cfg']['user'])};$/) }

  worker_processes_value = e(property['nginx_cfg']['worker_processes'])
  its(:content) { should match(/^worker_processes #{worker_processes_value};$/) }

  pid_value = e(property['nginx_cfg']['pid'])
  its(:content) { should match(/^pid #{pid_value};$/) }

  property['nginx_cfg']['events'].each do |key, value|
    its(:content) { should match(/^\s*#{e(key)} #{e(value)};$/) }
  end

  sendfile_value = property['nginx_cfg']['http']['sendfile'] ? 'on' : 'off'
  its(:content) { should match(/^\s*sendfile #{sendfile_value};$/) }

  tcp_nopush_value = property['nginx_cfg']['http']['tcp_nopush'] ? 'on' : 'off'
  its(:content) { should match(/^\s*tcp_nopush #{tcp_nopush_value};$/) }

  tcp_nodelay_value = property['nginx_cfg']['http']['tcp_nodelay'] ? 'on' : 'off'
  its(:content) { should match(/^\s*tcp_nodelay #{tcp_nodelay_value};$/) }

  keepalive_timeout_value = e(property['nginx_cfg']['http']['keepalive_timeout'])
  its(:content) { should match(/^\s*keepalive_timeout #{keepalive_timeout_value};$/) }
  types_hash_max_size = e(property['nginx_cfg']['http']['types_hash_max_size'])
  its(:content) { should match(/^\s*types_hash_max_size #{types_hash_max_size};$/) }

  if property['nginx_cfg']['http'].key?('server_tokens')
    server_tokens_value = property['nginx_cfg']['http']['server_tokens'] ? 'on' : 'off'
    its(:content) { should match(/^\s*server_tokens #{server_tokens_value};$/) }
  end
  if property['nginx_cfg']['http'].key?('server_names_hash_bucket_size')
    server_names_hash_bucket_size_value = e(property['nginx_cfg']['http']['server_names_hash_bucket_size'])
    its(:content) { should match(/^\s*server_names_hash_bucket_size #{server_names_hash_bucket_size_value};$/) }
  end
  if property['nginx_cfg']['http'].key?('server_name_in_redirect')
    server_name_in_redirect_value = property['nginx_cfg']['http']['server_name_in_redirect'] ? 'on' : 'off'
    its(:content) { should match(/^\s*server_name_in_redirect #{server_name_in_redirect_value};$/) }
  end

  default_type_value = e(property['nginx_cfg']['http']['default_type'])
  its(:content) { should match(/^\s*default_type #{default_type_value};$/) }

  if property['nginx_cfg']['http'].key?('client_max_body_size')
    client_max_body_size_value = e(property['nginx_cfg']['http']['client_max_body_size'])
    its(:content) { should match(/^\s*client_max_body_size #{client_max_body_size_value};$/) }
  end
  # Logging Settings
  access_log_value = e(property['nginx_cfg']['http']['access_log'])
  its(:content) { should match(/^\s*access_log #{access_log_value};$/) }

  error_log_value = e(property['nginx_cfg']['http']['error_log'])
  its(:content) { should match(/^\s*error_log #{error_log_value};$/) }

  # SSL Settings
  ssl_protocols_value = e(property['nginx_cfg']['http']['ssl']['protocols'].join(' '))
  its(:content) { should match(/^\s*ssl_protocols #{ssl_protocols_value};$/) }

  ssl_ciphers_value = e(property['nginx_cfg']['http']['ssl']['ciphers'].join(':'))
  its(:content) { should match(/^\s*ssl_ciphers "#{ssl_ciphers_value}";$/) }

  ssl_prefer_server_ciphers_value = property['nginx_cfg']['http']['ssl']['prefer_server_ciphers'] ? 'on' : 'off'
  its(:content) { should match(/^\s*ssl_prefer_server_ciphers #{ssl_prefer_server_ciphers_value};$/) }

  session_timeout_value = e(property['nginx_cfg']['http']['ssl']['session_timeout'])
  its(:content) { should match(/^\s*ssl_session_timeout #{session_timeout_value};$/) }

  ssl_session_cache_value = e(property['nginx_cfg']['http']['ssl']['session_cache'])
  its(:content) { should match(/^\s*ssl_session_cache #{ssl_session_cache_value};$/) }

  ssl_session_tickets_value = property['nginx_cfg']['http']['ssl']['session_tickets'] ? 'on' : 'off'
  its(:content) { should match(/^\s*ssl_session_tickets #{ssl_session_tickets_value};$/) }

  ssl_stapling_value = property['nginx_cfg']['http']['ssl']['stapling'] ? 'on' : 'off'
  its(:content) { should match(/^\s*ssl_stapling #{ssl_stapling_value};$/) }

  ssl_stapling_verify_value = property['nginx_cfg']['http']['ssl']['stapling_verify'] ? 'on' : 'off'
  its(:content) { should match(/^\s*ssl_stapling_verify #{ssl_stapling_verify_value};$/) }

  if property['nginx_cfg']['http']['ssl'].key?('dhparam')
    ssl_dhparam_value = e(property['nginx_cfg']['http']['ssl']['dhparam'])
    its(:content) { should match(/^\s*ssl_dhparam #{ssl_dhparam_value};$/) }
  end

  if property['nginx_cfg']['http']['ssl'].key?('hsts')
    hsts_value = e(property['nginx_cfg']['http']['ssl']['hsts'])
    its(:content) { should match(/^\s*add_header Strict-Transport-Security "#{hsts_value}";$/) }
  end

  # Gzip Settings
  gzip_value = property['nginx_cfg']['http']['gzip'] ? 'on' : 'off'
  its(:content) { should match(/^\s*gzip #{gzip_value};$/) }

  gzip_vary_value = property['nginx_cfg']['http']['gzip_vary'] ? 'on' : 'off'
  its(:content) { should match(/^\s*gzip_vary #{gzip_vary_value};$/) }

  gzip_proxied_value = e(property['nginx_cfg']['http']['gzip_proxied'])
  its(:content) { should match(/^\s*gzip_proxied #{gzip_proxied_value};$/) }

  gzip_comp_level = e(property['nginx_cfg']['http']['gzip_comp_level'])
  its(:content) { should match(/^\s*gzip_comp_level #{gzip_comp_level};$/) }

  gzip_buffers_value = e(property['nginx_cfg']['http']['gzip_buffers'])
  its(:content) { should match(/^\s*gzip_buffers #{gzip_buffers_value};$/) }

  gzip_http_version_value = e(property['nginx_cfg']['http']['gzip_http_version'])
  its(:content) { should match(/^\s*gzip_http_version #{gzip_http_version_value};$/) }

  gzip_types_value = e(property['nginx_cfg']['http']['gzip_types'].join(' '))
  its(:content) { should match(/^\s*gzip_types #{gzip_types_value};$/) }

end

%w[redirect_https.conf redirect_www.conf wordpress.conf].each do |snippet|
  describe file('/etc/nginx/snippets/' + snippet) do
    it { should exist }
    it { should be_file }
  end
end

if property['nginx_generate_dh_key']
  describe file(property['nginx_dh_key_path']) do
    it { should exist }
    it { should be_file }
  end
end
