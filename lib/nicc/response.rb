require 'tapp'
require 'active_support/core_ext'

module Nicc
  class Response

    # "merge" is the tentative name
    attr_accessor :ext_hash, :i_hash, :merge
    def initialize(ext_hash, i_hash, options)
      @ext_hash = ext_hash
      @i_hash   = i_hash
      @merge    = {}
      @options  = {:thread_type => 'flat'}.merge(options)
    end

    def default_merge
      case @options[:thread_type]
      when 'flat'
        @merge = i_hash['nicovideo_video_response']['video_info']['video']
          .reverse_merge(ext_hash['nicovideo_thumb_response']['thumb'])
          .merge(i_hash['nicovideo_video_response']['video_info']['thread'])
          .tap do |merge|
          # key 'id' is commonly used, so change key name 'thread_id'
          merge['thread_id'] = merge.delete('id')
        end
      when 'layer'
        @merge = {}.tap do |merge|
          merge[:info] = i_hash['nicovideo_video_response']['video_info']['video']
            .reverse_merge(ext_hash['nicovideo_thumb_response']['thumb'])
          merge[:thread] = i_hash['nicovideo_video_response']['video_info']['thread']
        end
      end
    end

    def reverse_merge_info
      case @options[:thread_type]
      when 'layer'
        @merge.tap do |merge|
          merge[:info] = i_hash['nicovideo_video_response']['video_info']['video']
            .deep_merge(ext_hash['nicovideo_thumb_response']['thumb'])
        end
      when 'flat'
        @merge.tap do |merge|
          merge[:info] = ext_hash['nicovideo_thumb_response']['thumb']
            .reverse_merge(i_hash['nicovideo_video_response']['video_info']['video'])
            .merge(i_hash['nicovideo_video_response']['video_info']['thread'])
        end
      end
    end
  end
end
