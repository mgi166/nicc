require 'httparty'

module Nicc
  class Info
    include ::HTTParty

    EXT_URL = 'http://ext.nicovideo.jp/api/getthumbinfo/'

    def initialize(id)
      @id = id
    end

    def get
      response = ::HTTParty.get(EXT_URL)
    end
  end
end
