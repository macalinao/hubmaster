module Github
  class Repos
    def self.list(user = nil)

      toput = []
      if user.nil?
        request = Github.makeGetRequest("/user/repos?sort=pushed")  
      else
        request = Github.makeGetRequest("/users/#{user}/repos?sort=pushed")  
      end

      response = JSON.parse(request)

      if response.kind_of?(Array)
        response.each do |repo|
          toput << "#{repo['name']} (#{repo['ssh_url']})"  
          toput << " - Description: #{repo['description']}"
          toput << " - Owner: #{repo['owner']['login']}"
          toput << " - Language: #{repo['language']}"
          created_at = repo['created_at'].split("T")
          created_at_date = created_at[0].split("-")
          created_at_date = "#{created_at_date[1]}/#{created_at_date[2]}/#{created_at_date[0]}" 
          toput << " - Created At: #{created_at[1]} on #{created_at_date}"
          updated_at = repo['updated_at'].split("T")
          updated_at_date = updated_at[0].split("-")
          updated_at_date = "#{updated_at_date[1]}/#{updated_at_date[2]}/#{updated_at_date[0]}" 
          toput << " - Last Updated: #{updated_at[1]} on #{updated_at_date}"
          toput << ""
        end
      elsif !response["errors"].nil?
        puts "ERROR: #{response['errors'][0]['message']}"
      elsif !response["message"].nil?
        puts "ERROR: #{response["message"]}"
      end
      
      putLess toput unless toput == []
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

      if response["errors"].nil? && response["message"].nil?
        puts "Repository \"#{name}\" succesfully created! Hosted at: #{JSON.parse(request)["ssh_url"]}"
      elsif !response["errors"].nil?
        puts "ERROR: #{response['errors'][0]['message']}"
      elsif !response["message"].nil?
        puts "ERROR: #{response["message"]}"
      end
      puts ""
    end

    def self.edit(operation, name, op)
      if name.nil?
        print "Name of repository you wish to edit: "
        name = STDIN.gets.chomp
      end

      case operation
      when :description
        if op.nil?
          print "Intended description of repository: "
          op = STDIN.gets.chomp
        end

        jsonHash = {"name" => name, "description" => op}.to_json
        request = Github.makeEditRequest("/repos/#{Github.user}/#{name}", jsonHash)
      end
      
      response = JSON.parse(request)

      if response["errors"].nil? && response["message"].nil?
        puts "Repository \"#{name}\" succesfully edited! See updates at: #{JSON.parse(request)["html_url"]}"
      elsif !response["errors"].nil?
        puts "ERROR: #{response['errors'][0]['message']}"
      elsif !response["message"].nil?
        puts "ERROR: #{response["message"]}"
      end
      puts ""
    end

    def self.delete(name)
      if name.nil?
        print "Name of repository: "
        name = STDIN.gets.chomp
      end

      puts "This well permenantly delete the repository '#{name}' from your github account. Are you sure you want to do this?"
      print "If so, type the name of the repository (enter to cancle): "
      confirm = STDIN.gets.chomp

      if confirm == name
        request = Github.makeDeleteRequest("/repos/#{Github.user}/#{name}")
        if request.nil?
          response = nil
        else
          response = JSON.parse(request)
        end

        if response.nil?
          puts "Repository '#{name}' has been deleted!"
        elsif !response["errors"].nil?
          puts "ERROR: #{response['errors'][0]['message']}"
        elsif !response["message"].nil?
          puts "ERROR: #{response["message"]}"
        end
      else
        puts "Name entered was incorrect and request has been cancled."
      end
      puts ""
    end

    def self.get(owner, name, operator, branch = nil)
      owner = Github.user if owner == "self"

      toput = []

      if owner.nil?
        print "Name of owner: "
        owner = STDIN.gets.chomp
      end
      
      if name.nil? 
        print "Name of repository: "
        name = STDIN.gets.chomp
      end

      case operator
      when :contributors
        request = Github.makeGetRequest("/repos/#{owner}/#{name}/contributors")  
        response = JSON.parse(request)

        if response.kind_of?(Array)
          response.each do |contributer|
            toput << "User #{contributer["login"]}"
            toput << " - URL: #{contributer["url"]}"
            toput << " - Contributions #{contributer["contributions"]}"
            toput << ""
          end
        elsif !response["errors"].nil?
          puts "ERROR: #{response['errors'][0]['message']}"
          puts ""
        elsif !response["message"].nil?
          puts "ERROR: #{response["message"]}"
          puts ""
        end
      when :languages
        request = Github.makeGetRequest("/repos/#{owner}/#{name}/languages")  
        response = JSON.parse(request)

        if response["errors"].nil? && response["message"].nil?
          response.each do |language, bytes|
            toput << "#{bytes} bytes written in #{language}."
            toput << ""
          end
        elsif !response["errors"].nil?
          puts "ERROR: #{response['errors'][0]['message']}"
          puts ""
        elsif !response["message"].nil?
          puts "ERROR: #{response["message"]}"
          puts ""
        end
      when :teams #UNTESTED METHOD BECAUSE I DONT KNOW ANY EXAMPLES
        request = Github.makeGetRequest("/repos/#{owner}/#{name}/teams")  
        response = JSON.parse(request)

        if response.kind_of?(Array)
          response.each do |team|
            toput << "Team: #{team["name"]}"
            toput << " - URL: #{team["url"]}"
            puts ""
          end
        elsif !response["errors"].nil?
          puts "ERROR: #{response['errors'][0]['message']}"
          puts ""
        elsif !response["message"].nil?
          puts "ERROR: #{response["message"]}"
          puts ""
        end
      when :tags 
        request = Github.makeGetRequest("/repos/#{owner}/#{name}/tags")  
        response = JSON.parse(request)

        if response.kind_of?(Array)
          response.each do |tag|
            toput << "Tag Name: #{tag["name"]}"
            toput << " - Commit URL: #{tag["commit"]["url"]}"
            toput << " - Commit SHA: #{tag["commit"]["sha"]}"
            toput << ""
          end
        elsif !response["errors"].nil?
          puts "ERROR: #{response['errors'][0]['message']}"
          puts ""
        elsif !response["message"].nil?
          puts "ERROR: #{response["message"]}"
          puts ""
        end
      when :branches 
        request = Github.makeGetRequest("/repos/#{owner}/#{name}/branches")  
        response = JSON.parse(request)

        if response.kind_of?(Array)
          response.each do |branch|
            toput << "Branch Name: #{branch["name"]}"
            toput << " - Commit URL: #{branch["commit"]["url"]}"
            toput << " - Commit SHA: #{branch["commit"]["sha"]}"
            puts ""
          end
        elsif !response["errors"].nil?
          puts "ERROR: #{response['errors'][0]['message']}"
          puts ""
        elsif !response["message"].nil?
          puts "ERROR: #{response["message"]}"
          puts ""
        end
      when :branch
        if branch.nil?
          print "Branch to view: "
          branch = STDIN.gets.chomp
        end

        request = Github.makeGetRequest("/repos/#{owner}/#{name}/branches/#{branch}")  
        response = JSON.parse(request)
        
        if response["errors"].nil? && response["message"].nil?
          puts "Branch Name: #{response['name']}"  
          puts " - Commit SHA: #{response["commit"]["sha"]}"
          puts " - Message: #{response["commit"]["commit"]["message"]}"
          puts " - Author: #{response["commit"]["author"]["login"]}"
          puts "   - Author Name: #{response["commit"]["commit"]["author"]["name"]}"
          puts "   - Author Email: #{response["commit"]["commit"]["author"]["email"]}"
          
          if response["commit"]["committer"]["login"] != response["commit"]["author"]["login"]
            puts " - Commiter: #{response["commit"]["committer"]["login"]}"
            puts "   - Commiter Name: #{response["commit"]["commit"]["committer"]["name"]}"
            puts "   - Commiter Email: #{response["commit"]["commit"]["committer"]["email"]}"
          end

          puts " - Parents:"
          response["commit"]["parents"].each do |parent|
            puts "   - Parent SHA: #{parent["sha"]}"
          end
        elsif !response["errors"].nil?
          puts "ERROR: #{response['errors'][0]['message']}"
        elsif !response["message"].nil?
          puts "ERROR: #{response["message"]}"
        end
        puts ""
      when :repository
        request = Github.makeGetRequest("/repos/#{owner}/#{name}")  
        response = JSON.parse(request)
        
        if response["errors"].nil? && response["message"].nil?
          puts "#{response['name']} (#{response['ssh_url']})"  
          puts " - Owner: #{response['owner']['login']}"
          puts " - Description: #{response['description']}"
          puts " - Private: #{response['private']}"
          puts " - Fork: #{response['fork']}"
          puts " - Language: #{response['language']}"
          puts " - Forks: #{response['forks']}"
          puts " - Watchers: #{response['watchers']}"
          puts " - Master Branch: #{response['master_branch']}"
          puts " - Open Issues: #{response['open_issues']}"
          created_at = response['created_at'].split("T")
          created_at_date = created_at[0].split("-")
          created_at_date = "#{created_at_date[1]}/#{created_at_date[2]}/#{created_at_date[0]}" 
          puts " - Created At: #{created_at[1]} on #{created_at_date}"
          updated_at = response['updated_at'].split("T")
          updated_at_date = updated_at[0].split("-")
          updated_at_date = "#{updated_at_date[1]}/#{updated_at_date[2]}/#{updated_at_date[0]}" 
          puts " - Last Updated: #{updated_at[1]} on #{updated_at_date}"
        elsif !response["errors"].nil?
          puts "ERROR: #{response['errors'][0]['message']}"
        elsif !response["message"].nil?
          puts "ERROR: #{response["message"]}"
        end
        puts ""
      end 
      
      putLess toput unless toput == []   
    end
  end
end
