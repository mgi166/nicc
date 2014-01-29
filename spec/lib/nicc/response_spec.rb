# -*- coding: utf-8 -*-
require 'spec_helper'

shared_context 'The test of common elements' do
  its(['video_id'])                    { should == 'sm3393520' }
  its(['title'])                       { should == '【アイドルマスター＋麻雀】im@s 雀姫伝　第一話 前編' }
  its(['thumbnail_url'])               { should == 'http://tn-skr1.smilevideo.jp/smile?i=3393520' }
  its(['first_retrieve'])              { should == '2008-05-22T07:23:27+09:00' }
  its(['length'])                      { should == '11:07' }
  its(['movie_type'])                  { should == 'mp4' }
  its(['size_high'])                   { should == '39289914' }
  its(['size_low'])                    { should == '33276193' }
  its(['comment_num'])                 { should == '7948' }
  its(['last_res_body'])               { should == '赤木はるかwwww 今の...' }
  its(['watch_url'])                   { should == 'http://www.nicovideo.jp/watch/sm3393520' }
  its(['thumb_type'])                  { should == 'video' }
  its(['embeddable'])                  { should == '1' }
  its(['no_live_play'])                { should == '0' }
  its(['tags'])                        { should == {'domain'=>'jp', 'tag'=>['アイドルマスター', 'アイマス雀荘リンク', 'im@s架空戦記シリーズ', 'iM@s雀姫伝', 'RAP_']} }
  its(['user_id'])                     { should == '43787' }
  its(['user_nickname'])               { should == 'RAP' }
  its(['user_icon_url'])               { should == 'http://usericon.nimg.jp/usericon/s/4/43787.jpg?1389728124' }
  its(['deleted'])                     { should == '0' }
  its(['length_in_seconds'])           { should == '667' }
  its(['upload_time'])                 { should == nil }
  its(['default_thread'])              { should == '1211408607' }
  its(['option_flag_ichiba'])          { should == '0' }
  its(['option_flag_community'])       { should == '0' }
  its(['option_flag_domestic'])        { should == '0' }
  its(['option_flag_comment_type'])    { should == '0' }
  its(['option_flag_adult'])           { should == '0' }
  its(['option_flag_mobile'])          { should == '0' }
  its(['option_flag_economy_mp4'])     { should == '1' }
  its(['option_flag_middle_video'])    { should == '0' }
  its(['option_flag_mobile_ng_apple']) { should == '0' }
end

shared_context 'The test of common thread elements' do
  its(['public'])       { should == '1' }
  its(['num_res'])      { should == '7948' }
  its(['community_id']) { should == nil }
  its(['thread_id'])    { should == '1211408607' }
end

describe Nicc::Response do
  let(:response) { described_class.new(ext_hash, i_hash, options) }

  let(:ext_xml)  { File.read(File.join('spec', 'data', 'xml', 'sample01.xml')) }
  let(:ext_hash) { Nicc::XML.new(ext_xml).parse }

  let(:i_xml)  { File.read(File.join('spec', 'data', 'xml', 'sample02.xml')) }
  let(:i_hash) { Nicc::XML.new(i_xml).parse }

  describe '#default_merge' do
    describe 'the default case that option has thread_type = "flat"' do
      subject { response.default_merge }
      let(:options)  { {} }

      describe 'hash should have key & value' do
        include_context 'The test of common elements'
        include_context 'The test of common thread elements'

        its(['description'])    { should == '「何故プレイ動画にしなかったのか」と何度も...<br />技術的に未熟な...<br /><br />' }
        its(['view_counter'])   { should == '424445' }
        its(['mylist_counter']) { should == '10128' }
      end
    end

    describe 'the case that option has thread_type = "layer"' do
      let(:options)  { {thread_type: 'layer'} }

      describe 'hash should have key & value' do
        subject { response.default_merge[:info] }

        include_context 'The test of common elements'

        its(['description'])    { should == '「何故プレイ動画にしなかったのか」と何度も...<br />技術的に未熟な...<br /><br />' }
        its(['view_counter'])   { should == '424445' }
        its(['mylist_counter']) { should == '10128' }
      end

      describe 'hash should have key & value' do
        subject { response.default_merge[:thread] }
        include_context 'The test of common thread elements'
      end
    end
  end

  describe '#reverse_merger' do
    describe 'the default case that option has thread_type = "flat"' do
      subject { response.reverse_merge }
      let(:options)  { {} }

      describe 'hash should have key & value' do
        include_context 'The test of common elements'
        include_context 'The test of common thread elements'

        its(['description'])    { should == '「何故プレイ動画にしなかったのか」と何度も...' }
        its(['view_counter'])   { should == '424401' }
        its(['mylist_counter']) { should == '10124' }
      end
    end

    describe 'the case that option has thread_type = "layer"' do
      let(:options)  { {thread_type: 'layer'} }

      describe 'hash should have key & value' do
        subject { response.reverse_merge[:info] }

        include_context 'The test of common elements'

        its(['description'])    { should == '「何故プレイ動画にしなかったのか」と何度も...' }
        its(['view_counter'])   { should == '424401' }
        its(['mylist_counter']) { should == '10124' }
      end

      describe 'hash should have key & value' do
        subject { response.default_merge[:thread] }
        include_context 'The test of common thread elements'
      end
    end
  end

  describe '#merge' do
    context 'the default case that options has :priority = "i"' do
      let(:options) { {:priority => 'i'} }

      it '#default_mergre should be called' do
        response.should_receive(:default_merge)
        response.merge
      end
    end

    context 'the case that options has :priority => "e"' do
      let(:options) { {:priority => 'e'} }

      it '#reverse_merge should be called' do
        response.should_receive(:reverse_merge)
        response.merge
      end
    end
  end
end

