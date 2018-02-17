#!/usr/bin/env python2

import os
from docker import Client

containerNamesToRestart = ['dovecot', 'postfix', 'haproxy']
cli = Client(base_url='unix://var/run/docker.sock')

container = [c for c in cli.containers() if c['Id'][:12] == os.environ.get("HOSTNAME")[:12]][0]
project_name = container['Labels'].get('com.docker.compose.project')

filters = [
  'com.docker.compose.project={}'.format(project_name),
]

containers = cli.containers(filters={'label': filters})

for c in containers:
  service_name = c['Labels'].get('com.docker.compose.service')
  if service_name in containerNamesToRestart:
    container_id = c['Id']
    container_number = c['Labels'].get('com.docker.compose.container-number')
    print "* restarting container " + project_name + "_" + service_name + "_" + str(container_number) + " (" + container_id + ")"

    try:
      cli.restart(c)
    except:
      e = sys.exc_info()[0]
      print "ERROR while trying to restart container: " + e

