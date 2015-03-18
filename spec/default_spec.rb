describe 'serverdensity-inviqa::default' do

  context 'basic setup' do
    let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

    it 'should include the serverdensity base recipe' do
      expect(chef_run).to include_recipe('serverdensity::default')
    end

    it 'should declare the base installation directory' do
      expect(chef_run.node['serverdensity-inviqa']['installation']['directory']).to eq('/usr/bin/sd-agent/')
    end
  end

  context 'no tags supplied' do
    let(:chef_run) { ChefSpec::SoloRunner.new do |node|
      node.name 'noddy'
      node.set['serverdensity-inviqa']['tags'] = []
    end.converge(described_recipe) }

    it 'should not add any tags' do
      expect(chef_run).to_not update_serverdensity('noddy').with(metadata: {:tags => '["tag1","tag2"]'})
    end
  end

  context 'tags are configured' do

    let(:chef_run) { ChefSpec::SoloRunner.new do |node|
      node.name 'noddy'
      node.set['serverdensity-inviqa']['tags'] = ['tag1', 'tag2']
    end.converge(described_recipe) }

    it 'should set the tags' do
      expect(chef_run).to update_serverdensity('noddy').with(metadata: {:tags => '["tag1","tag2"]'})
    end
  end

end