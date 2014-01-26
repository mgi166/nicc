require 'nokogiri'
require 'tapp'

module Nicc
  class XML
    def initialize(xml)
      @xml = xml
    end

    def parse
      doc = Nokogiri::XML(@xml)
      {}.tap do |hash|
        doc.xpath('nicovideo_thumb_response/thumb').children.each do |ch|
          next if ch.class.to_s == "Nokogiri::XML::Text"
          if ch.children.size > 1
            {}.tap do |hash|
              ch.children.each do |c|
                next if c.class.to_s == "Nokogiri::XML::Text"
                hash[c.name] ||= []
                hash[c.name] << c.text
              end
            end
          else
            hash[ch.name] = ch.text
          end
        end
      end
    end

    def parse_children(element)
      {}.tap do |hash|
        element.children.each do |e|
          next if e.class == Nokogiri::XML::Text
          if e.children.size > 1
            hash[e.name] = parse_children(e)
          else
            hash[e.name] ||= []
            hash[e.name] << e.text
          end
        end
      end
    end

    def parse_element(element)
      if element.children.size > 1
        {}.tap do |hash|
        end
      else
        hash[element.name] = element.text
      end
    end
  end
end
