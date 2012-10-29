require 'rubygems'
require 'highline/import'
require 'net/http'
require 'net/https'

module Github
  class Connection
    def initialize 
      print "Username: "
      @user = gets.chomp
      @pass = ask("Password: ") {|q| q.echo = "*"}
    end

    def makeRequest(path, username = @user, password = @pass, server = "api.github.com")
      http = Net::HTTP.new(server,443)
      req = Net::HTTP::Get.new(path)
      http.use_ssl = true
      req.basic_auth username, password
      response = http.request(req)
      return response.body
    end
  end

  class Repos
    def initialize(connection)
      @connection = connection
    end

    def view
      @connection.makeRequest("/user/repos")  
    end
  end
end
