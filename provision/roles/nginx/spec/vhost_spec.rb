require 'spec_helper'

property['nginx_vhosts'].each do |vhosts_cfg|
  describe file('/etc/nginx/sites-available/' + vhosts_cfg['name']) do
    it { should exist }
    it { should be_file }
    default_server = vhosts_cfg.key?('default') && vhosts_cfg['default'] ? ' default_server' : ''
    if vhosts_cfg.key?('ssl')
      its(:content) { should match(/^\s*listen 443 ssl http2#{default_server};$/) }
      its(:content) { should match(/^\s*listen \[::\]:443 ssl http2#{default_server};$/) }
    else
      vhost_port = vhosts_cfg['listen'] || 80
      its(:content) { should match(/^\s*listen #{vhost_port}#{default_server};$/) }
      its(:content) { should match(/^\s*listen \[::\]:#{vhost_port}#{default_server};$/) }
    end
    if vhosts_cfg.key?('variables')
      vhosts_cfg['variables'].each do |name, value|
        its(:content) { should match(/^\s*set \$#{e(name)} "#{e(value)}";$/) }
      end
    end
    if vhosts_cfg.key?('includes')
      vhosts_cfg['includes'].each do |file_name|
        its(:content) { should match(/^\s*include #{e(file_name)};$/) }
      end
    end
    if vhosts_cfg.key?('client_max_body_size')
      its(:content) { should match(/^\s*client_max_body_size #{e(vhosts_cfg['client_max_body_size'])};$/) }
    end
    if vhosts_cfg.key?('server_name')
      server_name = vhosts_cfg['server_name']
      server_name = vhosts_cfg['server_name'].join(' ') if vhosts_cfg['server_name'].is_a?(Array)
      its(:content) { should match(/^\s*server_name #{e(server_name)};$/) }
    end
    its(:content) { should match(/^\s*access_log #{e(vhosts_cfg['access_log'])};$/) } if vhosts_cfg.key?('access_log')
    its(:content) { should match(/^\s*error_log #{e(vhosts_cfg['error_log'])};$/) } if vhosts_cfg.key?('error_log')
    its(:content) { should match(/^\s*root #{e(vhosts_cfg['document_root'])};$/) } if vhosts_cfg.key?('document_root')
    if vhosts_cfg.key?('index')
      index_file = vhosts_cfg['index']
      index_file = vhosts_cfg['index'].join(' ') if vhosts_cfg['index'].is_a?(Array)
      its(:content) { should match(/^\s*index #{e(index_file)};$/) }
    end
    if vhosts_cfg.key?('add_headers')
      vhosts_cfg['add_headers'].each do |add_header|
        its(:content) { should match(/^\s*add_header #{e(add_header['name'])} #{e(add_header['value'])};$/) }
      end
    end
    if vhosts_cfg.key?('locations')
      vhosts_cfg['locations'].each do |location|
        match_type = location['match_type'] || ''
        pattern = location['pattern']
        its(:content) { should match(/^\s*location #{e(match_type)} #{e(pattern)} \{$/) }
      end
    end
    if vhosts_cfg.key?('ssl')
      vhosts_ssl_cfg = vhosts_cfg['ssl']
      its(:content) { should match(/^\s*ssl on;$/) }
      its(:content) { should match(/^\s*ssl_certificate #{e(vhosts_ssl_cfg['certificate'])};$/) }
      its(:content) { should match(/^\s*ssl_certificate_key #{e(vhosts_ssl_cfg['certificate_key'])};$/) }
      if vhosts_ssl_cfg.key?('trusted_certificate')
        its(:content) { should match(/^\s*ssl_trusted_certificate #{e(vhosts_ssl_cfg['trusted_certificate'])};$/) }
      end
      if vhosts_ssl_cfg.key?('protocols')
        protocols = vhosts_ssl_cfg['protocols'].join(' ')
        its(:content) { should match(/^\s*ssl_protocols #{e(protocols)};$/) }
      end
      if vhosts_ssl_cfg.key?('ciphers')
        ciphers = vhosts_ssl_cfg['ciphers'].join(':')
        its(:content) { should match(/^\s*ssl_ciphers "#{e(ciphers)}";$/) }
      end
      if vhosts_ssl_cfg.key?('prefer_server_ciphers')
        prefer_server_ciphers = vhosts_ssl_cfg['prefer_server_ciphers'] ? 'on' : 'off'
        its(:content) { should match(/^\s*ssl_prefer_server_ciphers #{e(prefer_server_ciphers)};$/) }
      end
      if vhosts_ssl_cfg.key?('session_timeout')
        its(:content) { should match(/^\s*ssl_session_timeout #{e(vhosts_ssl_cfg['session_timeout'])};$/) }
      end
      if vhosts_ssl_cfg.key?('session_cache')
        its(:content) { should match(/^\s*ssl_session_cache #{e(vhosts_ssl_cfg['session_cache'])};$/) }
      end
      if vhosts_ssl_cfg.key?('session_tickets')
        session_tickets = vhosts_ssl_cfg['session_tickets'] ? 'on' : 'off'
        its(:content) { should match(/^\s*ssl_session_tickets #{e(session_tickets)};$/) }
      end
      if vhosts_ssl_cfg.key?('dhparam')
        its(:content) { should match(/^\s*ssl_dhparam #{e(vhosts_ssl_cfg['dhparam'])};$/) }
      end
      if vhosts_ssl_cfg.key?('hsts')
        its(:content) { should match(/^\s*add_header Strict-Transport-Security "#{e(vhosts_ssl_cfg['hsts'])}";$/) }
      end
      if vhosts_ssl_cfg.key?('stapling')
        stapling = vhosts_ssl_cfg['stapling'] ? 'on' : 'off'
        its(:content) { should match(/^\s*ssl_stapling #{e(stapling)};$/) }
      end
      if vhosts_ssl_cfg.key?('stapling_verify')
        stapling_verify = vhosts_ssl_cfg['stapling_verify'] ? 'on' : 'off'
        its(:content) { should match(/^\s*ssl_stapling_verify #{e(stapling_verify)};$/) }
      end
    end
  end
  describe file('/etc/nginx/sites-enabled/' + vhosts_cfg['name']) do
    vhost_status = true
    vhost_status = false if vhosts_cfg.key?('state') && !vhosts_cfg['state']
    if vhost_status
      it { should exist }
      it { should be_symlink }
      it { should be_linked_to '/etc/nginx/sites-available/' + vhosts_cfg['name'] }
    else
      it { should_not exist }
    end
  end
end
