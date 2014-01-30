require 'httparty'

module Nicc
  class IInfo
    include ::HTTParty

    def initialize(id)
      @id = id
    end

    def i_url
      'http://i.nicovideo.jp'
    end

    def default_option
      {:query => { :v => @id }}
    end

    def get(options={}, &block)
      o = default_option.merge(options)
      self.class.get("#{i_url}/v3/video.array", o, &block)
    end
  end
end
