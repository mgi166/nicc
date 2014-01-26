require 'httparty'

module Nicc
  class IInfo
    include ::HTTParty

    attr_reader :id
    def initialize(id)
      unless id =~ /\A(\d+)\Z/
        raise ArgumentError, "`#{id}' is wrong format. Argument must convert to integer other than 0"
      end
      @id = "sm" + $1.to_s
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
