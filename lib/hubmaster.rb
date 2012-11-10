require 'rubygems'
require "highline"
require 'highline/import'
require 'json'
require 'net/http'
require 'net/https'
require 'stringio'
require 'uri'

require File.expand_path(File.join(File.dirname(__FILE__), "hubmaster", "base.rb"))
require File.expand_path(File.join(File.dirname(__FILE__), "hubmaster", "repo.rb"))
require File.expand_path(File.join(File.dirname(__FILE__), "hubmaster", "cipher.rb"))

def putLess(array)
  return if RUBY_PLATFORM =~ /win32/
  
  string = array.join("\n")
  windowHeight = HighLine::SystemExtensions.terminal_size[1]
  
  if array.count >= windowHeight
    IO.popen("less", "w") { |f| f.puts string}
  else
    puts string
  end   
end
