require 'spec_helper'

describe Nicc::IInfo do
  describe '#new' do
    subject { described_class.new(id) }

    context 'correct an argument' do
      let(:id) { '123' }
      its(:id) { should == 'sm123' }
    end

    context 'wrong an argument' do
      let(:id) { 'abcd' }

      it 'should raise ArgumentError' do
        expect {
          subject
        }.to raise_error ArgumentError, "`abcd' is wrong format. Argument must convert to integer other than 0"
      end
    end
  end

  describe '#get' do
    let(:i_info) { described_class.new(id) }
    let(:id) { '123' }

    context "the case that don't spcify options" do
      let(:options) { {:query => { :v => 'sm456', :spec => 'test' }} }
      it 'should be called any methods with options' do
        described_class.should_receive(:get).with('http://i.nicovideo.jp/v3/video.array', {:query=>{:v=>"sm456", :spec=>'test'}})
        i_info.get(options)
      end
    end

    context "the case that don't spcify options" do
      it 'should be called any methods with options' do
        described_class.should_receive(:get).with('http://i.nicovideo.jp/v3/video.array', {:query=>{:v=>"sm123"}})
        i_info.get
      end
    end
  end
end
