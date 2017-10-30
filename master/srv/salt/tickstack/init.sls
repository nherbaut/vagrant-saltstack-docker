python-pip:
  pkg.installed

docker-py:
  pip.installed:
    - require:
      - pkg: python-pip


chronograf:latest:
  cmd.run:
    - name: docker pull chronograf:latest


influxdb:latest:
   cmd.run:
     - name docker pull influxdb:latest



chronograf:
  docker_container.running:
    - image: chronograf:latest
    - port_bindings:
      - {{ salt['mine.get']('vm1', 'network.ip_addrs')['vm1'][0] }}:8888:8888
    - link: influxdb
    - environment:
      - INFLUXDB_URL=http://{{ salt['mine.get']('vm1', 'network.ip_addrs')['vm1'][0] }}:8086
    - require:
      - docker_image: chronograf:latest
      - docker_container: influxdb

influxdb:
  docker_container.running:
      - image: influxdb:latest
      - detach: True
      - port_bindings:
        - {{ salt['mine.get']('vm1', 'network.ip_addrs')['vm1'][0] }}:8086:8086
      - require:
        - influxdb:latest

