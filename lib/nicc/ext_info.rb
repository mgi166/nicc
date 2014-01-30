require 'httparty'

module Nicc
  class ExtInfo
    include ::HTTParty

    def initialize(id)
      @id = id
    end

    def ext_url
      'http://ext.nicovideo.jp'
    end

    def get(options={}, &block)
      self.class.get("#{ext_url}/api/getthumbinfo/#{@id}", options, &block)
    end
  end
end
