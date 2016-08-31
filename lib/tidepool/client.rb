module Tidepool
  class Client
    include HTTParty

    def self.login(username:, password:)
      auth = { username: username, password: password }
      response = self.post("/auth/login", basic_auth: auth)
      if response.success?
        response
      else
        message = ErrorMessage.new(response).message
        raise HTTPError.new(response.code, message)
      end
    end

    def initialize(session_token:)
      @headers = {
        "Content-Type": "application/json",
        "x-tidepool-session-token": session_token
      }
    end

    def users(user_id:)
      get("/metadata/users/#{user_id}/users")
    end

    def data(user_id:, options: {})
      get("/data/#{user_id}", options)
    end

    def notes(user_id:, options: {})
      response = get("/message/notes/#{user_id}", options)
      response["messages"]
    end

    private

    attr_reader :headers

    base_uri "https://api.tidepool.org"
    format :json
    parser JSONParser

    def get(url, options = {})
      options.merge!(headers: headers)
      response = self.class.get(url, options)
      if response.success?
        response
      else
        message = ErrorMessage.new(response).message
        raise HTTPError.new(response.code, message)
      end
    end
  end
end
