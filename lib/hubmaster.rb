require 'rubygems'
require 'highline/import'
require 'net/http'
require 'net/https'
require 'stringio'

module Github
  def self.connect
      print "Username: "
      @user = STDIN.gets.chomp
      @pass = ask("Password: ") {|q| q.echo = "*"}

      return nil
  end

  def self.makeRequest(path, username = @user, password = @pass, server = "api.github.com")
      http = Net::HTTP.new(server,443)
      req = Net::HTTP::Get.new(path)
      http.use_ssl = true
      req.basic_auth username, password
      response = http.request(req)
      return response.body
  end

  class Repos
    def self.view
      Github.makeRequest("/user/repos")  
    end
  end
end
