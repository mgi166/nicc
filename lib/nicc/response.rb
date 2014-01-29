require 'tapp'
require 'active_support/core_ext'

module Nicc
  class Response

    attr_accessor :ext_hash, :i_hash, :merge
    def initialize(ext_hash, i_hash, options)
      @ext_hash = ext_hash
      @i_hash   = i_hash
      @options  = { :thread_type => 'flat', :priority => 'i' }.merge(options)
    end

    def merge
      case @options[:priority]
      when 'i'
        default_merge
      when 'e'
        reverse_merge
      end
    end

    def default_merge
      case @options[:thread_type]
      when 'flat'
        @merge = i_hash['nicovideo_video_response']['video_info']['video']
          .reverse_merge(ext_hash['nicovideo_thumb_response']['thumb'])
          .merge(i_hash['nicovideo_video_response']['video_info']['thread'])
          .tap do |x|
          # key 'id' is commonly used, so change key name 'thread_id'
          x['thread_id'] = x.delete('id')
        end
      when 'layer'
        @merge = {}.tap do |merge|
          merge[:info] = i_hash['nicovideo_video_response']['video_info']['video']
            .reverse_merge(ext_hash['nicovideo_thumb_response']['thumb'])
            .delete_if {|key| key == 'id'}
          merge[:thread] = i_hash['nicovideo_video_response']['video_info']['thread']
            .tap do |x|
            x['thread_id'] = x.delete('id')
          end
        end
      end
    end

    def reverse_merge
      case @options[:thread_type]
      when 'flat'
        @merge = ext_hash['nicovideo_thumb_response']['thumb']
          .reverse_merge(i_hash['nicovideo_video_response']['video_info']['video'])
          .merge(i_hash['nicovideo_video_response']['video_info']['thread'])
          .tap do |x|
          # key 'id' is commonly used, so change key name 'thread_id'
          x['thread_id'] = x.delete('id')
        end
      when 'layer'
        @merge = {}.tap do |merge|
          merge[:info] = ext_hash['nicovideo_thumb_response']['thumb']
            .reverse_merge(i_hash['nicovideo_video_response']['video_info']['video'])
            .delete_if {|key| key == 'id'}
          merge[:thread] = i_hash['nicovideo_video_response']['video_info']['thread']
            .tap do |x|
            x['thread_id'] = x.delete('id')
          end
        end
      end
    end
  end
end
