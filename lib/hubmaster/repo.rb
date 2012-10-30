module Github
  class Repos
    def self.list(user = nil)
      if user.nil?
        request = Github.makeGetRequest("/user/repos?sort=pushed")  
      else
        request = Github.makeGetRequest("/users/#{user}/repos?sort=pushed")  
      end
      
      if !request.nil? 
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
          puts " - Owner: #{repo['owner']['name']} (#{repo['owner']['login']})"
        end
      else
        puts "No repositories found."
      end
      puts ""
    end

    def self.create(name, description)
      if name.nil?
        print "Name of repository: "
        name = STDIN.gets.chomp
      end

      if description.nil?
        print "Description of repository: "
        description = STDIN.gets.chomp
      end

      jsonHash = {"name" => name, "description" => description}.to_json
      request = Github.makePostRequest("/user/repos", jsonHash)
      response = JSON.parse(request)

      if response["errors"].nil?
        puts "Create command sent for repository \"#{name}\"! Hosted at: #{JSON.parse(request)["url"]}"
      else
        puts "ERROR: #{response['errors'][0]['message']}"
      end
      puts ""
    end

    def self.delete(name)
      if name.nil?
        print "Name of repository: "
        name = STDIN.gets.chomp
      end

      request = Github.makeGetRequest("/user/repos")

      JSON.parse(request).each do |repo|
        if repo["name"] == name
          @owner = repo["owner"]["login"]
        end
      end 

      request = Github.makeDeleteRequest("/repos/#{@owner}/#{name}")
      
      puts "Delete command sent for repository #{name}!"
      puts ""
    end
  end
end
