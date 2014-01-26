require 'nokogiri'
require 'active_support/core_ext'
require 'tapp'

module Nicc
  class XML
    def initialize(xml)
      @xml = xml
    end

    def parse
      Hash.from_xml(@xml)
    end
  end
end
