webserver:
  website: 'test.vn'
  package: 'nginx'
  config_file: '/etc/nginx/conf.d/file.conf'
  service: 'nginx'
  source: 'salt://conf/nginx.conf'
  direct: '/var/www/'
  log: '/var/log/nginx/'
  file_default: 'salt://conf/index.php'
