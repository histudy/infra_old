require 'spec_helper'

# # Test Case 1
#
# describe file('/etc/nginx/sites-available/test_1') do
#   it { should exist }
#   it { should be_file }
#   it { should contain 'listen 80 default_server;' }
#   it { should contain 'listen [::]:80 default_server;' }
#
#   it { should contain 'server_name test1.exampe.com test-1.exampe.com;' }
#
#   it { should contain 'root /var/www/html;' }
#   it { should contain 'index test1.html test1.htm;' }
#
#   it { should contain 'client_max_body_size 16M;' }
#
#   it { should contain 'access_log /var/log/nginx/access.log;' }
#   it { should contain 'error_log /var/log/nginx/error.log;' }
#
#   it { should contain 'set $var1_name "var1_value";' }
#   it { should contain 'set $var2_name "var2_value";' }
#
#   it { should contain 'include snippets/redirect_https.conf;' }
#
#   it { should contain 'location  /test_case_1_1 {' }
#   it { should contain '# test code 1_1' }
#   it { should contain 'location ~ /test_case_1_2 {' }
#   it { should contain '# test code 1_2' }
#
#   it { should contain '# extra setting test 1 code' }
# end
#
# describe file('/etc/nginx/sites-enabled/test_1') do
#   it { should exist }
#   it { should be_file }
#   it { should be_linked_to '/etc/nginx/sites-available/test_1' }
# end
#
# # test Case 2
#
# describe file('/etc/nginx/sites-available/test_2') do
#   it { should exist }
#   it { should be_file }
#   it { should contain 'listen 80;' }
#   it { should contain 'listen [::]:80;' }
#
#   it { should contain 'server_name test2.exampe.com test-2.exampe.com;' }
#
#   it { should contain 'root /var/www/html;' }
#   it { should contain 'index test2.html test2.htm;' }
#
#   it { should_not contain 'access_log ' }
#   it { should_not contain 'error_log ' }
#
#   it { should contain 'include snippets/redirect_www.conf;' }
#
#   it { should contain 'location  /test_case_2_1 {' }
#   it { should contain '# test code 2_1' }
#   it { should contain 'location ~ /test_case_2_2 {' }
#   it { should contain '# test code 2_2' }
#
#   it { should contain '# extra setting test 2 code' }
# end
#
# describe file('/etc/nginx/sites-enabled/test_2') do
#   it { should exist }
#   it { should be_file }
#   it { should be_linked_to '/etc/nginx/sites-available/test_2' }
# end
#
# # testCase 3
#
# describe file('/etc/nginx/sites-available/test_3') do
#   it { should exist }
#   it { should be_file }
#   it { should contain 'listen 443 ssl http2;' }
#   it { should contain 'listen [::]:443 ssl http2;' }
#
#   it { should contain 'server_name test3.exampe.com;' }
#
#   it { should_not contain 'root ' }
#   it { should_not contain 'index ' }
#
#   it { should_not contain 'client_max_body_size ' }
#
#   it { should_not contain 'access_log ' }
#   it { should_not contain 'error_log ' }
#
#   it { should contain 'ssl_certificate /path/to/cert.pem;' }
#   it { should contain 'ssl_certificate_key /path/to/privkey.pem;' }
#   it { should contain 'ssl_trusted_certificate /path/to/chain.pem;' }
#
#   it { should contain 'ssl_protocols TLSv1 TLSv1.1 TLSv1.2;' }
#
#   ssl_ciphers = [
#     'ECDHE-ECDSA-CHACHA20-POLY1305',
#     'ECDHE-RSA-CHACHA20-POLY1305',
#     'ECDHE-ECDSA-AES128-GCM-SHA256',
#     'ECDHE-RSA-AES128-GCM-SHA256',
#     'ECDHE-ECDSA-AES256-GCM-SHA384',
#     'ECDHE-RSA-AES256-GCM-SHA384',
#     'DHE-RSA-AES128-GCM-SHA256',
#     'DHE-RSA-AES256-GCM-SHA384',
#     'ECDHE-ECDSA-AES128-SHA256',
#     'ECDHE-RSA-AES128-SHA256',
#     'ECDHE-ECDSA-AES128-SHA',
#     'ECDHE-RSA-AES256-SHA384',
#     'ECDHE-RSA-AES128-SHA',
#     'ECDHE-ECDSA-AES256-SHA384',
#     'ECDHE-ECDSA-AES256-SHA',
#     'ECDHE-RSA-AES256-SHA',
#     'DHE-RSA-AES128-SHA256',
#     'DHE-RSA-AES128-SHA',
#     'DHE-RSA-AES256-SHA256',
#     'DHE-RSA-AES256-SHA',
#     'ECDHE-ECDSA-DES-CBC3-SHA',
#     'ECDHE-RSA-DES-CBC3-SHA',
#     'EDH-RSA-DES-CBC3-SHA',
#     'AES128-GCM-SHA256',
#     'AES256-GCM-SHA384',
#     'AES128-SHA256',
#     'AES256-SHA256',
#     'AES128-SHA',
#     'AES256-SHA',
#     'DES-CBC3-SHA',
#     '!DSS'
#   ]
#   ssl_ciphers_value = ssl_ciphers.join(':')
#   it { should contain "ssl_ciphers \"#{ssl_ciphers_value}\";" }
#   it { should contain 'ssl_prefer_server_ciphers off;' }
#
#   it { should contain 'ssl_session_timeout 1d;' }
#   it { should contain 'ssl_session_cache shared:SSL:50m;' }
#   it { should contain 'ssl_session_tickets off;' }
#   it { should contain 'ssl_dhparam /etc/nginx/dhparam.pem;' }
#
#   it { should contain 'add_header Strict-Transport-Security "max-age=15768000; includeSubDomains;";' }
#
#   it { should contain 'ssl_stapling on;' }
#   it { should contain 'ssl_stapling_verify on;' }
# end
#
# describe file('/etc/nginx/sites-enabled/test_3') do
#   it { should_not exist }
# end
