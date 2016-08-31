require "spec_helper"

describe Tidepool::Client do
  describe ".login" do
    context "with valid credentials" do
      it "logs in using username and password arguments" do
        user = "test01@tidepool.org"
        pass = "test_pass"
        stub_valid_login(user, pass)

        response = Tidepool::Client.login(username: user, password: pass)

        expect(response["userid"]).to eq(1234)
        expect(response.headers["x-tidepool-session-token"]).to eq("12455ada")
      end
    end

    context "with invalid credentials" do
      it "raises an error" do
        user = "invalid"
        pass = "junk"
        stub_invalid_login(user, pass)

        expected = expect do
          Tidepool::Client.login(username: user, password: pass)
        end
        expected.to raise_error(Tidepool::HTTPError).
          with_message("Error 401 No user matched the given details")
      end
    end
  end

  describe "#users" do
    it "fetches the users from api" do
      tp = Tidepool::Client.new(session_token: "abc123")
      metadata = stub_users_metadata

      tp.users(user_id: "1234")

      expect(metadata).to have_been_requested
    end
  end

  describe "#data" do
    context "with no options" do
      it "requests all data for user_id" do
        tp = Tidepool::Client.new(session_token: "abc123")
        data = stub_data

        tp.data(user_id: "1234")

        expect(data).to have_been_requested
      end
    end

    context "with query options" do
      it "requests data based on passed options for user_id" do
        tp = Tidepool::Client.new(session_token: "abc123")
        data = stub_data(type: "basal")

        tp.data(user_id: "1234", options: { query: { type: "basal" } } )

        expect(data).to have_been_requested
      end
    end

    describe "#notes" do
      it "requestes notes for user_id" do
        tp = Tidepool::Client.new(session_token: "abc123")
        notes = stub_notes

        tp.notes(user_id: "1234")

        expect(notes).to have_been_requested
      end
    end
  end

  def stub_notes
    stub_request(:get, "https://api.tidepool.org/message/notes/1234").
         with(headers: {"Content-Type": "application/json",
                        "X-Tidepool-Session-Token": "abc123"}).
                        to_return(status: 200, body: fixture("notes.json"),
                                  headers: {})
  end

  def stub_users_metadata
    stub_request(:get, "https://api.tidepool.org/metadata/users/1234/users").
      with(headers: {"Content-Type": "application/json",
                     "X-Tidepool-Session-Token":"abc123"}).
         to_return(status: 200, body: fixture("user_meta.json"),
                   headers: {"content-type": "application/json"})
  end

  def stub_data(type: "all")
    if type == "all"
      url = "https://api.tidepool.org/data/1234"
    else
      url = "https://api.tidepool.org/data/1234?type=#{type}"
    end
    stub_request(:get, url).
      with(headers: {"Content-Type": "application/json",
                     "X-Tidepool-Session-Token":"abc123"}).
         to_return(status: 200, body: fixture("data_#{type}.json"),
                   headers: {"content-type": "application/json"})
  end

  def stub_valid_login(user, pass)
    stub_request(:post, "https://api.tidepool.org/auth/login").
      with(basic_auth: [user, pass]).
      to_return(body: { userid: 1234 }.to_json, status: 200,
                headers: { "content-type": "application/json",
                           "x-tidepool-session-token": "12455ada" })
  end

  def stub_invalid_login(user, pass)
    stub_request(:post, "https://api.tidepool.org/auth/login").
      with(basic_auth: [user, pass]).
      to_return(status: 401, body: {
                              "code": 401,
                              "reason": "No user matched the given details"
                             }.to_json,
                headers: { "content-type": "application/json" })
  end
end
