require 'spec_helper'

module Commitsu
  describe Template do
    subject { described_class.new(filename) }
    let(:filename) { '/dummy.erb' }
    before do
      File.stubs(:read).returns('<%= @result %>')
      @template = subject
    end

    class MockMessage
      def initialize
        @result = 'hello'
      end
      def get_binding
        binding
      end
    end

    describe '#render' do
      it { @template.render(MockMessage.new).should == 'hello' }
    end
  end
end