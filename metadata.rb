name             'serverdensity-inviqa'
maintainer       'Inviqa'
maintainer_email 'support@inviqa.com'
license          'Apache'
description      'Provides additional ServerDensity configuration'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.1.0'

depends 'serverdensity', '~> 2.1.3'
depends 'apache2'
