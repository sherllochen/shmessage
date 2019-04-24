require "shmessage/engine"
require "shmessage/configuration"

module Shmessage
  class << self
    attr_reader :config

    def configure
      @config = Configuration.new
      yield config
    end
  end
end
