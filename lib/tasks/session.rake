require "rubygems"
require "httparty"

namespace :session do
  desc "TODO"
  task sign_in: :environment do
    response = HTTParty.post("http://localhost:3000/api/sign_in",
      body: { email: "raul@takeofflabs.com", password: "123456789" }.to_json,
      headers: { 'Content-Type' => 'application/json' } )
    puts response.body
  end

  task sign_up: :environment do
    response = HTTParty.post("http://localhost:3000/api/users",
      body: { user: { email: "raul@ex.com", password: "12345678", password_confirmation: "12345678" } }.to_json,
      headers: { 'Content-Type' => 'application/json' } )
    puts response.body
  end


  task update: :environment do
    response = HTTParty.put("http://localhost:3000/api/users/453",
      body: {user: {email: "raul@takeofflabs.com", password: "123456789", password_confirmation: "123456789" }},
      header: { 'Content-Type' => 'application/json'} )
    puts response.body
  end
end
