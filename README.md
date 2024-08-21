# ForemanSupervisoryAuthority

This Foreman plug-in adds support for reporting data to the Elastic APM.

## Compatibility

| Foreman Version | Plugin Version |
| --------------- | -------------- |
| >= 1.20         | ~> 0.0.2       |
| >= 3.0          | ~> 0.1.0       |
| >= 3.10         | ~> 0.2.0       |

## Installation

See [How_to_Install_a_Plugin](http://projects.theforeman.org/projects/foreman/wiki/How_to_Install_a_Plugin)
for how to install Foreman plugins.

## Configuration

This plugin needs to be configured via a config file. On a production environment the config file
needs to be located at `/etc/foreman/plugins/foreman_supervisory_authority.yaml`. On a development environment,
the file is expected to be at `config/settings.plugins.d/foreman_supervisory_authority.yaml`.
Below you can find an example config file. All the possible parameters are documented
[on the Elastic site](https://www.elastic.co/guide/en/apm/agent/ruby/current/configuration.html#_options).

```yaml
:foreman_supervisory_authority:
  server_url: https://elastic-apm.example.com
  secret_token: "12345verysecret"
  service_name: "foreman"
  transaction_max_spans: 100
```

## Contributing

Fork and send a Pull Request. Thanks!

## Copyright

Copyright (c) 2019 Timo Goebel

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
