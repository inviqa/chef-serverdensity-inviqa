# serverdensity-inviqa

This cookbook provides additional Server Density configuration not handled by the official cookbook.

## Usage

In its most basic form, this cookbook provides a wrapper for the serverdensity cookbook's install method that includes by default an option to tag servers.

To install, include `serverdensity-inviqa` in the run list. You will need to supply the following config options:

- `node['serverdensity']['account']` - The serverdenisty.io account URL, usually this will be YOUR_COMPANY.serverdensity.io
- `node['serverdensity']['device_group']` - The name of the group the server belongs to
- `node['serverdensity']['token']` - Account API token, should be stored securely
- `node['serverdensity-inviqa']['tags']` - An array of tag IDs that servers should be added to

## License and Author

Author:: Shane Auckland (sauckland@inviqa.com)

Copyright 2015, Inviqa

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
