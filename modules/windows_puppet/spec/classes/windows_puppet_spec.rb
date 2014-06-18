require 'spec_helper'

describe 'windows_puppet' do
  shared_context 'puppet' do |version|
    let(:facts){{:puppetversion => version,:operatingsystem => 'windows'}}
  end

  describe 'ensure installed on new version' do
    include_context 'puppet','3.3.1'
    let(:params){{:version => '3.4.1'}}
    it {
      should contain_pget('DownloadPuppet').with({
          'source' => 'http://downloads.puppetlabs.com/windows/puppet-3.4.1.msi',
          'target' => 'C:\\software'
                                                 })
      should contain_package('UpgradePuppet').with({
          'name' => 'Puppet',
          'source'      => 'C:\\software\\puppet-3.4.1.msi',
          'install_options' => '/qn'
                                                   })
    }
  end
  describe 'ensure no opp for same version' do
    include_context 'puppet','3.4.1'
    let(:params){{:version => '3.4.1'}}
    it {
      should_not contain_pget('DownloadPuppet')
      should_not contain_package('UpgradePuppet')
    }
  end
end
