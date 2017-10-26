/usr/bin/telegraf:
  file.managed:
       - source: {{ pillar['telegraf_download_link'] }}
       - mode: 0775
       - skip_verify: True
       - required_in:
         -  /etc/telegraf/telegraf.conf

/etc/telegraf/telegraf.conf:
  file.managed:
    - source: salt://telegraf/telegraf.conf
    - template: jinja


telegraf_systemd_unit:
  file.managed:
    - name: /etc/systemd/system/telegraf.service
    - source: salt://telegraf/telegraf.service
    - template: jinja
  module.run:
    - name: service.systemctl_reload
    - onchanges:
      - file: /usr/bin/telegraf
      - file: /etc/telegraf/telegraf.conf

telegraf:
  service.running:
    - watch:
      - module: telegraf_systemd_unit
    - require:
       - module:
          telegraf_systemd_unit
       
