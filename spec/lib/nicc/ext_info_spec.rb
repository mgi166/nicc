require 'spec_helper'

describe Nicc::ExtInfo do
  describe '#get' do
    let(:ext_info) { described_class.new(id) }
    let(:id) { 'sm123' }

    context "the case that don't spcify options" do
      let(:options) { {:query => { :hoge => 123, :fuga => 456 }} }
      it 'should be called any methods with options' do
        described_class.should_receive(:get).with('http://ext.nicovideo.jp/api/getthumbinfo/sm123', options)
        ext_info.get(options)
      end
    end

    context "the case that don't spcify options" do
      it 'should be called any methods' do
        described_class.should_receive(:get).with('http://ext.nicovideo.jp/api/getthumbinfo/sm123', {})
        ext_info.get
      end
    end
  end
end
