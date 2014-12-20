require './lib/config'
require 'rb-fsevent'

fsevent = FSEvent.new

puts 'Starting watch for Pintrest Api'

def test_result
  binding.pry
  puts result[0]

  if (result[1] == 'true')
    puts `terminal-notifier -title 'Auto Watch' -message 'Symlinker Test Ran!!' -subtitle 'Success!'`
  else
    puts `terminal-notifier -title 'Auto Watch' -message 'Symlinker Test Ran!!' -subtitle 'Failure'`
  end
end

fsevent.watch Dir.pwd + '/lib' do |directories|
  puts "\nChange detected running tests....."
  puts `rubocop lib/symlinker.rb`
  test_result
  puts "Finshed running specs"
end

fsevent.run
