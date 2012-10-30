module Github
  class Repos
    def self.list(user = nil)
      if user.nil?
        request = Github.makeGetRequest("/user/repos")  
      else
        request = Github.makeGetRequest("/users/#{user}/repos")  
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
        end
      else
        puts "No repositories found."
      end
      puts ""
    end

    def self.create(name, description)
      if name.nil?
        puts "Name of repository: "
        name = STDIN.gets.chomp
      end

      if description.nil?
        puts "Description of repository: "
        description = STDIN.gets.chomp
      end

      jsonHash = {"name" => name, "description" => description}.to_json
      if request = Github.makePostRequest("/user/repos", jsonHash)
        puts "Repository \"#{name}\" succesfully created! Hosted at: #{JSON.parse(request)["url"]}"
      else
        puts "ERROR: An error occured while creating repository. Please try again!"
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

      if request = Github.makeDeleteRequest("/repos/#{@owner}/#{name}")
        puts "Repository \"#{name}\" succesfully deleted!"
      else
        puts "ERROR: An error occured while deleting the repository. Please try again!"
      end
      puts ""
    end
  end
end
