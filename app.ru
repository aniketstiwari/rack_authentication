require 'byebug'
require './main'

class Greeter
  def call(env)
    req = Rack::Request.new(env)
    case req.path_info
    when /users/
      create_users
      [200, {"Content-Type" => "application/json"},  [User.all.to_json]]
    else
      [404, {"Content-Type" => "text/html"}, ["Invalid Request"]]
    end
  end

  def create_users
    user1 = User.create(name: "aniket")
    user2 = User.create(name: "shivam")
    user3 = User.create(name: "tiwari")
  end
end


app = Rack::Builder.new do
  use Rack::Auth::Basic do |username, password|
    username == 'aniket' && password == 'password'
  end

  map '/' do
    run Greeter.new
  end
end

run app
