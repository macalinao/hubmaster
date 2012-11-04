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

  def self.makeGetRequest(path, username = @user, password = @pass, server = "api.github.com")
      http = Net::HTTP.new(server,443)
      req = Net::HTTP::Get.new(path)
      http.use_ssl = true
      req.basic_auth username, password
      response = http.request(req)
      return response.body
  end

  def self.makePostRequest(path, body, username = @user, password = @pass, server = "api.github.com")
      http = Net::HTTP.new(server,443)
      req = Net::HTTP::Post.new(path)
      http.use_ssl = true
      req.basic_auth username, password
      req.body = body
      response = http.request(req)
      return response.body
  end

  def self.makeDeleteRequest(path, username = @user, password = @pass, server = "api.github.com")
      http = Net::HTTP.new(server,443)
      req = Net::HTTP::Delete.new(path)
      http.use_ssl = true
      req.basic_auth username, password
      response = http.request(req)
      return response.body
  end

  def self.help
    puts "Hubmaster Help: "
  end
end

