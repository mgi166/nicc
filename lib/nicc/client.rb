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
    end
  end
end
