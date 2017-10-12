# frozen_string_literal: true

module Api
  class Error < RuntimeError

    attr_reader :status
    attr_reader :addition

    def initialize(message, status, addition = false)
      super(message)
      @status = status
      @addition = addition
    end
  end
end
