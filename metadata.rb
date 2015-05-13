name             'met-nexus'
maintainer       'Espen Myrland'
maintainer_email 'met-api@met.no'
license          'All rights reserved'
description      'Installs/Configures met-nexus'
long_description 'Installs/Configures met-nexus'
version          '0.1.0'


depends 'met-server',   '>= 0.52.2'
depends 'simple-nexus', '~> 0.1.0'
depends 'java',         '~> 1.29'
depends 'apt',          '~> 2.6'
depends 'nginx',        '~> 2.7'

