# -*- coding: utf-8 -*-
require 'spec_helper'

describe Nicc::XML do
  let(:nicc) { described_class.new(xml) }

  describe 'parse' do
    subject { nicc.parse }
    let(:nicc) { described_class.new(xml) }

    describe 'Actual data(from ext. api)' do
      let(:xml)  { File.read(File.join('spec', 'data', 'xml', 'sample01.xml')) }

      describe 'basic infomation' do
        it { should be_instance_of Hash }
        its(:keys) { should == ['nicovideo_thumb_response'] }

        context 'the value in "nicovideo_thumb_response"' do
          subject { nicc.parse['nicovideo_thumb_response'] }
          it { should be_instance_of Hash }
          its(:keys) { should == ['status', 'thumb'] }
        end
      end

      describe 'the value "thumb" in the hash of "nicovideo_thumb_response"' do
        subject { nicc.parse['nicovideo_thumb_response']['thumb'] }

        it { should include 'video_id'       => 'sm3393520' }
        it { should include 'title'          => '【アイドルマスター＋麻雀】im@s 雀姫伝　第一話 前編' }
        it { should include 'description'    => '「何故プレイ動画にしなかったのか」と何度も...' }
        it { should include 'thumbnail_url'  => 'http://tn-skr1.smilevideo.jp/smile?i=3393520' }
        it { should include 'first_retrieve' => '2008-05-22T07:23:27+09:00' }
        it { should include 'length'         => '11:07' }
        it { should include 'movie_type'     => 'mp4' }
        it { should include 'size_high'      => '39289914' }
        it { should include 'size_low'       => '33276193' }
        it { should include 'view_counter'   => '424401' }
        it { should include 'comment_num'    => '7948' }
        it { should include 'mylist_counter' => '10124' }
        it { should include 'last_res_body'  => '赤木はるかwwww 今の...' }
        it { should include 'watch_url'      => 'http://www.nicovideo.jp/watch/sm3393520' }
        it { should include 'thumb_type'     => 'video' }
        it { should include 'embeddable'     => '1' }
        it { should include 'no_live_play'   => '0' }
        it { should include 'tags'           => {'domain'=>'jp', 'tag'=>['アイドルマスター', 'アイマス雀荘リンク', 'im@s架空戦記シリーズ', 'iM@s雀姫伝', 'RAP_']} }
        it { should include 'user_id'        => '43787' }
        it { should include 'user_nickname'  => 'RAP' }
        it { should include 'user_icon_url'  => 'http://usericon.nimg.jp/usericon/s/4/43787.jpg?1389728124' }
      end
    end

    describe 'Actial data(from i. api)' do
      let(:xml)  { File.read(File.join('spec', 'data', 'xml', 'sample02.xml')) }

      describe 'basic information' do
        it { should be_instance_of Hash }
        its(:keys) { should == ['nicovideo_video_response'] }

        context 'the value of "nicovideo_video_response"' do
          subject { nicc.parse['nicovideo_video_response'] }
          it { should be_instance_of Hash }
          its(:keys) { should == ["status", "count", "video_info"] }
        end

        context 'the value of key "video_info" in the hash "nicovideo_video_response"' do
          subject { nicc.parse['nicovideo_video_response']['video_info'] }
          it { should be_instance_of Hash }
          its(:keys) { should == ['video', 'thread', 'tags'] }
        end
      end

      describe 'some values of key "video_info"' do
        describe 'in "video"' do
          subject { nicc.parse['nicovideo_video_response']['video_info']["video"] }
          it { should be_instance_of Hash }

          it { should include "id"                          => "sm3393520" }
          it { should include "deleted"                     => "0" }
          it { should include "title"                       => "【アイドルマスター＋麻雀】im@s 雀姫伝　第一話 前編" }
          it { should include "description"                 => "「何故プレイ動画にしなかったのか」と何度も...<br />技術的に未熟な...<br /><br />" }
          it { should include "length_in_seconds"           => "667" }
          it { should include "size_low"                    => "33276193" }
          it { should include "movie_type"                  => "mp4" }
          it { should include "thumbnail_url"               => "http://tn-skr1.smilevideo.jp/smile?i=3393520" }
          it { should include "upload_time"                 => nil }
          it { should include "first_retrieve"              => "2008-05-22T07:23:27+09:00" }
          it { should include "default_thread"              => "1211408607" }
          it { should include "view_counter"                => "424445" }
          it { should include "mylist_counter"              => "10128" }
          it { should include "option_flag_ichiba"          => "0" }
          it { should include "option_flag_community"       => "0" }
          it { should include "option_flag_domestic"        => "0" }
          it { should include "option_flag_comment_type"    => "0" }
          it { should include "option_flag_adult"           => "0" }
          it { should include "option_flag_mobile"          => "0" }
          it { should include "option_flag_economy_mp4"     => "1" }
          it { should include "option_flag_middle_video"    => "0" }
          it { should include "option_flag_mobile_ng_apple" => "0" }
        end
      end
    end
  end
end
