module Tidepool
  class JSONParser < HTTParty::Parser
    #override parser initalizer to check for bad empty array before parsing
    #this is a known bug in the Tidepool API
    def initialize(body, format)
      @body = (body == "]") ? "[]" : body
      @format = format
    end
  end
end
