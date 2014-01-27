require 'tapp'
require 'active_support/core_ext'

module Nicc
  class Response

    # "merge" is the tentative name
    attr_accessor :ext_hash, :i_hash, :merge
    def initialize(ext_hash, i_hash, options)
      @ext_hash = ext_hash
      @i_hash   = i_hash
      @options  = {}.merge(options)
    end

    def default_merge
      @merge = i_hash['nicovideo_video_response']['video_info']['video'].
        reverse_merge(ext_hash['nicovideo_thumb_response']['thumb'])
    end
  end
end
