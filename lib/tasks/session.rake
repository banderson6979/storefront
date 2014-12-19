require "rubygems"
require "httparty"

namespace :session do
  desc "TODO"
  task sign_in: :environment do
    response = HTTParty.post("http://localhost:3000/api/sign_in",
      body: { email: "raul@takeofflabs.com", password: "12345678"}.to_json,
      headers: { 'Content-Type' => 'application/json' } )
    puts response.body
  end

end
