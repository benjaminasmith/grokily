# encoding: UTF-8
require_relative 'spec_helper'

describe "Grokily" do

  it "redirects to Github on root" do
    get '/'
    last_response.should be_redirect
    follow_redirect!
    last_request.url.should == "https://github.com/benjaminasmith/grokily"
  end

  it "exposes a list of languages on request" do
    get '/languages'
    last_response.should be_ok
    last_response.header['Content-Type'].should include 'application/json'
    JSON.parse(last_response.body).has_key "languages"
  end

  it "exposes a list of Norwegian verbs on request" do
    get '/norsk/verbs'
    last_response.should be_ok
    last_response.header['Content-Type'].should include 'application/json'
    JSON.parse(last_response.body).has_key "regular_verbs"
    JSON.parse(last_response.body).has_key "irregular_verbs"
  end

end
