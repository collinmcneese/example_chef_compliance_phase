control 'os-release' do
  impact 0.7
  title 'os-release'
  desc 'os-release check'

  describe file('/etc/os-release') do
    it { should exist }
  end

  describe user(input('user_which_should_not_exist')) do
    it { should_not exist }
  end

  describe 'kernel_min_version' do
    subject { command('uname -r') }
    its('stdout.to_f') { should be >= input('kernel_minimum_version') }
  end
end

control 'crond-service' do
  impact 0.7
  title 'crond-service'
  desc 'crond service should be running'

  only_if { os.family == 'redhat' }

  describe service('crond') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end

control 'auditd-service' do
  impact 0.7
  title 'auditd-service'
  desc 'auditd service should be running'

  only_if { os.family == 'redhat' }

  describe service('auditd') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end
