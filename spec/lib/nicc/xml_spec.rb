# -*- coding: utf-8 -*-
require 'spec_helper'

describe Nicc::XML do
  let(:nicc) { described_class.new(xml) }

  describe 'parse' do
    subject { nicc.parse }
    let(:nicc) { described_class.new(xml) }

    describe 'Actual data(from ext api)' do
      let(:xml)  { File.read(File.join('spec', 'data', 'xml', 'sample01.xml')) }
      its(:keys) { should == ['nicovideo_thumb_response'] }

      describe 'in "nicovideo_thumb_response"' do
        subject { nicc.parse['nicovideo_thumb_response'] }

        its(['thumb']) { should include 'video_id'       => 'sm3393520' }
        its(['thumb']) { should include 'title'          => '【アイドルマスター＋麻雀】im@s 雀姫伝　第一話 前編' }
        its(['thumb']) { should include 'description'    => '「何故プレイ動画にしなかったのか」と何度も...' }
        its(['thumb']) { should include 'thumbnail_url'  => 'http://tn-skr1.smilevideo.jp/smile?i=3393520' }
        its(['thumb']) { should include 'first_retrieve' => '2008-05-22T07:23:27+09:00' }
        its(['thumb']) { should include 'length'         => '11:07' }
        its(['thumb']) { should include 'movie_type'     => 'mp4' }
        its(['thumb']) { should include 'size_high'      => '39289914' }
        its(['thumb']) { should include 'size_low'       => '33276193' }
        its(['thumb']) { should include 'view_counter'   => '424401' }
        its(['thumb']) { should include 'comment_num'    => '7948' }
        its(['thumb']) { should include 'mylist_counter' => '10124' }
        its(['thumb']) { should include 'last_res_body'  => '赤木はるかwwww 今の...' }
        its(['thumb']) { should include 'watch_url'      => 'http://www.nicovideo.jp/watch/sm3393520' }
        its(['thumb']) { should include 'thumb_type'     => 'video' }
        its(['thumb']) { should include 'embeddable'     => '1' }
        its(['thumb']) { should include 'no_live_play'   => '0' }
        its(['thumb']) { should include 'tags'           => {'domain'=>'jp', 'tag'=>['アイドルマスター', 'アイマス雀荘リンク', 'im@s架空戦記シリーズ', 'iM@s雀姫伝', 'RAP_']} }
        its(['thumb']) { should include 'user_id'        => '43787' }
        its(['thumb']) { should include 'user_nickname'  => 'RAP' }
        its(['thumb']) { should include 'user_icon_url'  => 'http://usericon.nimg.jp/usericon/s/4/43787.jpg?1389728124' }
      end
    end
  end
end
