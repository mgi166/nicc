require 'spec_helper'

describe Nicc::IInfo do
  describe '#get' do
    let(:i_info) { described_class.new(id) }
    let(:id) { 'sm123' }

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
