# -*- coding: utf-8 -*-
require 'spec_helper'

describe Nicc::XML do
  let(:nicc) { described_class.new(xml) }

  describe 'parse' do
    subject { nicc.parse }
    let(:nicc) { described_class.new(xml) }

    describe '' do
      let(:xml)  { File.read(File.join('spec', 'data', 'xml', 'sample01.xml')) }
      it { subject }
    end
  end

  describe '#parse_children' do
    subject { nicc.parse_children(element) }
    let(:element) { Nokogiri::XML::DocumentFragment.parse(xml) }

    describe 'the case that xml has children' do
      let(:xml) {
        <<-XML
          <tags domain="jp">
            <tag category="1" lock="1">アイドルマスター</tag>
            <tag lock="1">アイマス雀荘リンク</tag>
            <tag lock="1">RAP_</tag>
          </tags>
        XML
      }

      its(['tags']) { should include('tag' => ['アイドルマスター', 'アイマス雀荘リンク', 'RAP_']) }
    end

    describe 'the case that xml has no children' do
      let(:xml) {
        <<-XML
          <tag domain="jp">rspec</tag>
        XML
      }
      its(['tag']) { should == ['rspec'] }
    end

    describe 'the case that xml has nested chilren' do
      it { pending }
    end
  end

  describe 'parse_element' do
    it { pending }
  end
end
