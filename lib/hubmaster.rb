require 'rubygems'
require 'highline/import'
require 'json'
require 'net/http'
require 'net/https'
require 'stringio'
require 'uri'

require File.expand_path(File.join(File.dirname(__FILE__), "hubmaster", "base.rb"))
require File.expand_path(File.join(File.dirname(__FILE__), "hubmaster", "repo.rb"))
require File.expand_path(File.join(File.dirname(__FILE__), "hubmaster", "cipher.rb"))

def run_pager
  return if RUBY_PLATFORM =~ /win32/
  return unless STDOUT.tty?
  
  read, write = IO.pipe
  
  unless Kernel.fork # Child process
    STDOUT.reopen(write)
    STDERR.reopen(write) if STDERR.tty?
    read.close
    write.close
    return
  end
  
  STDIN.reopen(read)
  read.close
  write.close

  ENV['LESS'] = 'FSRX' # Don't page if the input is short enough

  Kernel.select [STDIN] # Wait until we have input before we start the pager
  pager = ENV['PAGER'] || 'less'
  exec pager rescue exec "/bin/sh", "-c", pager
end

