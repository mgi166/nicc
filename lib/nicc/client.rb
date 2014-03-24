require 'httparty'
require 'tapp'
require 'active_support/core_ext'

module Nicc
  class Client

    attr_reader :id
    def initialize(id, options={})
      if id =~ /^sm(\d+)/ or id =~ /\A(\d+)\Z/
        @id = "sm" + $1
      else
        raise ArgumentError, "`#{id}' is wrong format. Argument must convert to integer other than 0"
      end
      @options = options
    end

    def get(options={})
      option = options.blank? ? @options : options

      e = Nicc::ExtInfo.new(@id)
      i = Nicc::IInfo.new(@id)

      e_response = e.get
      i_response = i.get

      e_hash = XML.new(e_response.body).parse
      i_hash = XML.new(i_response.body).parse

      response = Response.new(e_hash, i_hash, option).merge

      block_given? ? (yield response) : response
    end
  end
end
