require 'spec_helper'

describe Nicc::ExtInfo do
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
    let(:ext_info) { described_class.new(id) }
    let(:id) { '123' }

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
