{% from 'map.jinja' import nginx with context %}
{% include "install_php.jinja" %}

copy config file:
  file.managed:
    - name: {{ nginx.config_file }}
    - source: {{ nginx.source}}
    - require:
      - pkg: nginx.packages
create forder web:
  file.directory:
    - user:  {{ nginx.webuser }}
    - name:  {{ nginx.direct}}
    - group:  {{ nginx.webuser }}
    - mode:  755
    - require: 
      - pkg: nginx.packages
create forder log:
  file.directory:
    - user: {{ nginx.webuser }}
    - name: {{ nginx.log }}
    - group: {{ nginx.webuser }}
    - mode:  755
    - require:
      - pkg: nginx.packages
nginx:
  service.running:
    - name: {{ nginx.service }}
    - reload: True
    - require:
      - pkg: nginx.packages
copy file index:
  file.managed:
    - name: {{ nginx.direct }}/index.php
    - source: {{ nginx.file_default }}
