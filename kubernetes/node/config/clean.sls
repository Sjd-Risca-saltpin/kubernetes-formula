# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import data as d with context %}

{%- set sls_archive_clean = tplroot ~ '.node.archive.clean' %}
{%- set sls_package_clean = tplroot ~ '.node.package.clean' %}

include:
  - {{ sls_archive_clean }}
  - {{ sls_package_clean }}

kubernetes-node-config-clean:
  file.absent:
    - names:
      - {{ d.node.config_file }}
    - require:
      - sls: {{ sls_archive_clean if d.node.pkg.use_upstream == 'archive' else sls_package_clean }}
