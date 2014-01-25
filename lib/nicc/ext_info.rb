require 'httparty'

module Nicc
  class ExtInfo
    include ::HTTParty

    attr_reader :id
    def initialize(id)
      unless id =~ /\A(\d+)\Z/
        raise ArgumentError, "`#{id}' is wrong format. Argument must convert to integer other than 0"
      end
      @id = "sm" + $1.to_s
    end

    def ext_url
      'http://ext.nicovideo.jp'
    end

    def get(options={})
      self.class.get("#{ext_url}/api/getthumbinfo/#{@id}", options)
    end
  end
end
