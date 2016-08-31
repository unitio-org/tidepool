module Tidepool
  class ErrorMessage
    def initialize(response)
      @response = response
      @base_message = "Error #{response.code}"
    end

    def message
      if tidepool_message
        "#{base_message} #{tidepool_message}"
      else
        base_message
      end
    end

    def tidepool_message
      response["reason"] || response["message"]
    end

    private

    attr_reader :response, :base_message
  end
end
