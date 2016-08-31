module Tidepool
  class UnknownError < StandardError; end

  class HTTPError < StandardError
    def initialize(code, message)
      @code = code
      super(message)
    end

    attr_reader :code
  end
end
