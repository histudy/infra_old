require 'spec_helper'

describe file('/etc/nginx/nginx.conf') do
  it { should exist }
  it { should be_file }
  nginx_cfg = property['nginx_cfg']
  its(:content) { should match(/^user #{e(nginx_cfg['user'])};$/) }
  its(:content) { should match(/^worker_processes #{e(nginx_cfg['worker_processes'])};$/) }
  its(:content) { should match(/^pid #{e(nginx_cfg['pid'])};$/) }

  nginx_cfg['events'].each do |key, value|
    its(:content) { should match(/^\s*#{e(key)} #{e(value)};$/) }
  end

  nginx_http_cfg = nginx_cfg['http']
  sendfile_value = nginx_http_cfg['sendfile'] ? 'on' : 'off'
  its(:content) { should match(/^\s*sendfile #{sendfile_value};$/) }
  tcp_nopush_value = nginx_http_cfg['tcp_nopush'] ? 'on' : 'off'
  its(:content) { should match(/^\s*tcp_nopush #{tcp_nopush_value};$/) }
  tcp_nodelay_value = nginx_http_cfg['tcp_nodelay'] ? 'on' : 'off'
  its(:content) { should match(/^\s*tcp_nodelay #{tcp_nodelay_value};$/) }
  its(:content) { should match(/^\s*keepalive_timeout #{e(nginx_http_cfg['keepalive_timeout'])};$/) }
  its(:content) { should match(/^\s*types_hash_max_size #{e(nginx_http_cfg['types_hash_max_size'])};$/) }

  if nginx_http_cfg.key?('server_tokens')
    server_tokens_value = nginx_http_cfg['server_tokens'] ? 'on' : 'off'
    its(:content) { should match(/^\s*server_tokens #{server_tokens_value};$/) }
  end
  if nginx_http_cfg.key?('server_names_hash_bucket_size')
    server_names_hash_bucket_size_value = e(nginx_http_cfg['server_names_hash_bucket_size'])
    its(:content) { should match(/^\s*server_names_hash_bucket_size #{server_names_hash_bucket_size_value};$/) }
  end
  if nginx_http_cfg.key?('server_name_in_redirect')
    server_name_in_redirect_value = nginx_http_cfg['server_name_in_redirect'] ? 'on' : 'off'
    its(:content) { should match(/^\s*server_name_in_redirect #{server_name_in_redirect_value};$/) }
  end
  its(:content) { should match(/^\s*default_type #{e(nginx_http_cfg['default_type'])};$/) }

  if nginx_http_cfg.key?('client_max_body_size')
    its(:content) { should match(/^\s*client_max_body_size #{e(nginx_http_cfg['client_max_body_size'])};$/) }
  end

  # Logging Settings
  its(:content) { should match(/^\s*access_log #{e(nginx_http_cfg['access_log'])};$/) }
  its(:content) { should match(/^\s*error_log #{e(nginx_http_cfg['error_log'])};$/) }

  # SSL Settings
  nginx_ssl_cfg = nginx_http_cfg['ssl']
  its(:content) { should match(/^\s*ssl_protocols #{e(nginx_ssl_cfg['protocols'].join(' '))};$/) }
  its(:content) { should match(/^\s*ssl_ciphers "#{e(nginx_ssl_cfg['ciphers'].join(':'))}";$/) }
  ssl_prefer_server_ciphers_value = nginx_ssl_cfg['prefer_server_ciphers'] ? 'on' : 'off'
  its(:content) { should match(/^\s*ssl_prefer_server_ciphers #{ssl_prefer_server_ciphers_value};$/) }
  its(:content) { should match(/^\s*ssl_session_timeout #{e(nginx_ssl_cfg['session_timeout'])};$/) }
  its(:content) { should match(/^\s*ssl_session_cache #{e(nginx_ssl_cfg['session_cache'])};$/) }
  ssl_session_tickets_value = nginx_ssl_cfg['session_tickets'] ? 'on' : 'off'
  its(:content) { should match(/^\s*ssl_session_tickets #{ssl_session_tickets_value};$/) }
  ssl_stapling_value = nginx_ssl_cfg['stapling'] ? 'on' : 'off'
  its(:content) { should match(/^\s*ssl_stapling #{ssl_stapling_value};$/) }
  ssl_stapling_verify_value = nginx_ssl_cfg['stapling_verify'] ? 'on' : 'off'
  its(:content) { should match(/^\s*ssl_stapling_verify #{ssl_stapling_verify_value};$/) }
  its(:content) { should match(/^\s*ssl_dhparam #{e(nginx_ssl_cfg['dhparam'])};$/) } if nginx_ssl_cfg.key?('dhparam')
  if nginx_ssl_cfg.key?('hsts')
    its(:content) { should match(/^\s*add_header Strict-Transport-Security "#{e(nginx_ssl_cfg['hsts'])}";$/) }
  end

  # Gzip Settings
  gzip_value = nginx_http_cfg['gzip'] ? 'on' : 'off'
  its(:content) { should match(/^\s*gzip #{gzip_value};$/) }
  gzip_vary_value = nginx_http_cfg['gzip_vary'] ? 'on' : 'off'
  its(:content) { should match(/^\s*gzip_vary #{gzip_vary_value};$/) }
  its(:content) { should match(/^\s*gzip_proxied #{e(nginx_http_cfg['gzip_proxied'])};$/) }
  its(:content) { should match(/^\s*gzip_comp_level #{e(nginx_http_cfg['gzip_comp_level'])};$/) }
  its(:content) { should match(/^\s*gzip_buffers #{e(nginx_http_cfg['gzip_buffers'])};$/) }
  its(:content) { should match(/^\s*gzip_http_version #{e(nginx_http_cfg['gzip_http_version'])};$/) }
  its(:content) { should match(/^\s*gzip_types #{e(nginx_http_cfg['gzip_types'].join(' '))};$/) }
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
