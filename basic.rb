require "github_api"

repos = Github.repos.list user: 'tommyschaefer'

repos.each do |per|
  puts per.name
  puts ""
end
