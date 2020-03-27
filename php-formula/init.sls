{% set config = pillar.get('webserver',{}) %}
{% from 'map.jinja' import nginx with context %}
{% include "install_php.jinja" %}

copy config file:
  file.managed:
    - name: {{ config['config_file'] }}
    - source: {{ config['source'] }}
    - template: jinja
    - require:
      - pkg: nginx.packages
create forder web:
  file.directory:
    - user:  {{ nginx.webuser }}
    - name:  {{ config['direct'] }}{{ config['website'] }}
    - group:  {{ nginx.webuser }}
    - mode:  755
    - require: 
      - pkg: nginx.packages
create forder log:
  file.directory:
    - user: {{ nginx.webuser }}
    - name: {{ config['log'] }}{{ config['website'] }}
    - group: {{ nginx.webuser }}
    - mode:  755
    - require:
      - pkg: nginx.packages
nginx:
  cmd.run:
    - name: service nginx restart
copy file index:
  file.managed:
    - name: {{ config['direct'] }}{{ config['website'] }}/index.php
    - source: {{ config['file_default'] }}
    - template: jinja
