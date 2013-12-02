require 'spec_helper'
require 'support/with_env_macro'

module Commitsu
  describe Environment do
    include ::Support::WithEnvMacro
    subject { described_class.new(options) }
    let(:options) { {} }
    before do
      @env = subject
    end
    describe "#setup!" do
      context "when no env or option set" do
        it 'its home is set to default' do
          @env.setup!
          @env.home.should == Environment.default_home
        end
      end
      context "when ENV[COMMITSU_HOME]=/commitsu_home" do
        with_env 'COMMITSU_HOME' => '/commitsu_home'
        it 'its home is set to /commitsu_home' do
          @env.setup!
          @env.home.to_s.should == '/commitsu_home'
        end
      end
      context "when --home=/commitsu_home2" do
        with_env 'COMMITSU_HOME' => '/commitsu_home'
        let(:options) { {:home => '/commitsu_home2' } }
        it 'its home is set to /commitsu_home2' do
          @env.setup!
          @env.home.to_s.should == '/commitsu_home2'
        end
      end
    end
  end
end