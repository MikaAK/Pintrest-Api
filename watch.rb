#!/usr/bin/env ruby

require './lib/pintrest_api.rb'
require 'pry'
require 'rb-fsevent'

puts 'Starting watch for Pintrest Api'
fsevent = FSEvent.new

def test_files
  test_files = `git ls-files`.split($RS).grep(/test/)
  test_files.each do |f|
    `ruby #{f}`
  end
end

def test_result
  if (test_files)
    puts `terminal-notifier -title 'Auto Watch' -message 'Pintrest Api Test' -subtitle 'Success!'`
  else
    puts `terminal-notifier -title 'Auto Watch' -message 'Pintrest Api Test' -subtitle 'Failure'`
  end
end

fsevent.watch [Dir.pwd + '/lib', Dir.pwd + '/test'] do |directories|
  puts "\nChange detected running tests....."
  puts `rubocop lib/`
  test_result
  puts "Finshed running specs"
end

fsevent.run
