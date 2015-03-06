describe 'serverdensity-inviqa::apache' do
  before {
    stub_command('/usr/sbin/httpd -t').and_return(true)
    stub_command('/usr/sbin/apache2 -t').and_return(true)
  }

  let(:chef_run) {
    ChefSpec::SoloRunner.new do |node|
      node.set['apache']['dir'] = '/etc/httpd'
    end.converge(described_recipe)
  }

  it 'should depend on the apache2 cookbook' do
    expect(chef_run).to include_recipe('apache2::default')
  end

  it 'should place the apache config file' do
    expect(chef_run).to create_template('/etc/httpd/conf-available/serverdensity.conf')
  end

  it 'should use the server ip in the config' do
    chef_run.node.automatic['ipaddress'] = '1.2.3.4'
    expect(chef_run).to render_file('/etc/httpd/conf-available/serverdensity.conf').with_content('Allow from 127.0.0.1 1.2.3.4')
  end

  it 'should restart the server density agent' do
    resource = chef_run.apache_conf('serverdensity')
    expect(resource).to notify('service[sd-agent]').to(:restart).delayed
  end

  context 'mod_status is disabled' do
    before {
      allow(File).to receive(:symlink?).and_call_original
      allow(File).to receive(:exist?).and_call_original
      allow(File).to receive(:symlink?).with('/etc/httpd/mods-enabled/status.conf').and_return(false)
      allow(File).to receive(:symlink?).with('/etc/httpd/mods-enabled/status.load').and_return(false)
      allow(File).to receive(:exist?).with('/etc/httpd/mods-available/status.conf').and_return(true)
    }

    it 'should enable mod_status' do
      expect(chef_run).to run_execute('a2enmod status')
    end
  end

end