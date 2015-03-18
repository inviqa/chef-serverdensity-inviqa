describe 'serverdensity-inviqa::plugin_install' do
  context 'default run' do
    let(:chef_run) {
      ChefSpec::SoloRunner.new do |node|
        node.set['serverdensity-inviqa']['plugins'] = {
          'memcached' => {
            'key' => '123'
          },
          'foo' => {
            'key' => '456'
          }
        }
      end.converge(described_recipe)
    }

    it 'should include the default recipe' do
      expect(chef_run).to include_recipe('serverdensity-inviqa::default')
    end

    it 'should download the memcached plugin via the plugin downloader' do
      expect(chef_run).to run_execute('download plugin memcached').with(cwd: '/usr/bin/sd-agent/')
    end

    it 'should install the memcached plugin for serverdensity' do
      expect(chef_run).to enable_serverdensity_plugin('memcached')
    end

    it 'should download the foo plugin via the plugin downloader' do
      expect(chef_run).to run_execute('download plugin foo').with(cwd: '/usr/bin/sd-agent/')
    end

    it 'should install the foo plugin for serverdensity' do
      expect(chef_run).to enable_serverdensity_plugin('foo')
    end
  end

  context 'error run' do
    let(:chef_run) {
      ChefSpec::SoloRunner.new do |node|
        node.set['serverdensity-inviqa']['plugins'] = {
          'foo' => {
          }
        }
      end.converge(described_recipe)
    }

    it 'should fatal error if no key is provided for a plugin' do
      expect(Chef::Formatters::ErrorMapper).to_not receive(:file_load_failed)
      expect { chef_run }.to raise_error(ArgumentError)
    end
  end
end