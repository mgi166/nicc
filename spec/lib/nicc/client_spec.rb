require 'spec_helper'

describe Nicc::Client do
  describe '#new' do
    let(:client)  { described_class.new(id, options) }
    let(:options) { {} }

    describe 'the case that argument is given "Integer"' do
      subject  { client }
      let(:id) { '12345' }

      its(:id) { should == 'sm12345' }
    end

    describe 'the case that argument is given niconico ID format(ex. sm12345)' do
      subject  { client }
      let(:id) { 'sm12345' }

      its(:id) { should == 'sm12345' }
    end

    context 'wrong an argument' do
      subject  { client }
      let(:id) { 'abcd' }

      it 'should raise ArgumentError' do
        expect {
          subject
        }.to raise_error ArgumentError, "`abcd' is wrong format. Argument must convert to integer other than 0"
      end
    end
  end

  describe '#get' do
    subject { client.get }

    let(:client) { described_class.new(id, options) }
    let(:id) { '12345' }
    let(:options) { {} }
    let(:response01) { File.read(File.join('spec', 'data', 'xml', 'sample01.xml')) }
    let(:response02) { File.read(File.join('spec', 'data', 'xml', 'sample02.xml')) }

    before do
      stub_request(:get, 'http://ext.nicovideo.jp/api/getthumbinfo/sm12345').to_return(body: response01)
      stub_request(:get, 'http://i.nicovideo.jp/v3/video.array?v=sm12345').to_return(body: response02)
    end

    it { should be_instance_of Hash }
  end
end
