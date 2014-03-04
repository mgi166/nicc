require 'httparty'

module Nicc
  class Client

    attr_reader :id
    def initialize(id, options)
      if id =~ /^sm(\d+)/ or id =~ /\A(\d+)\Z/
        @id = "sm" + $1
      else
        raise ArgumentError, "`#{id}' is wrong format. Argument must convert to integer other than 0"
      end
      @options = options
    end

    def get(options, &block)
      e = Nicc::ExtInfo.new(@id, options)
      i = Nicc::IInfo.new(@id, options)

      begin
        e_response = e.get
        i_response = i.get

        e_hash = XML.new(e_response).parse
        i_hash = XML.new(i_response).parse

        response = Response.new(e_hash, i_hash, @options).merge

        block_given? ? (yield response) : response
      rescue => e
        puts e.message
      end
    end
  end
end
