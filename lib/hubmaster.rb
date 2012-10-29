require 'rubygems'
require 'highline/import'
require 'json'
require 'net/http'
require 'net/https'
require 'stringio'

module Github
  def self.connect
    if File.exists? "#{Dir.home}/.hubmaster"
      file = File.open("#{Dir.home}/.hubmaster", "rb")
      @user = file.read
    else
      print "Username: "
      @user = STDIN.gets.chomp
      File.open("#{Dir.home}/.hubmaster", "w") {|f| f.write("#{@user}")}
    end

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
      request = Github.makeRequest("/user/repos")  
      JSON.parse(request).each do |repo|
        puts "#{repo['name']} (#{repo['url']})"  
        puts " - Language: #{repo['language']}"
        created_at = repo['created_at'].split("T")
        created_at_date = created_at[0].split("-")
        created_at_date = "#{created_at_date[1]}/#{created_at_date[2]}/#{created_at_date[0]}" 
        puts " - Created At: #{created_at[1]} on #{created_at_date}"
        updated_at = repo['updated_at'].split("T")
        updated_at_date = updated_at[0].split("-")
        updated_at_date = "#{updated_at_date[1]}/#{updated_at_date[2]}/#{updated_at_date[0]}" 
        puts " - Last Updated: #{updated_at[1]} on #{updated_at_date}"
        puts ""
      end
    end
  end
end
