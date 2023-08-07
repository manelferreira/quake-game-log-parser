require_relative 'game_parser'
require 'json'

filename = ARGV[0]

log = File.readlines(filename)

game_parser = GameParser.new
report = game_parser.parse(log)

print "------------------------------\n"
print "Games: #{report.length}"

report.each do |game|
  print "\n------------------------------\n"
  print JSON.pretty_generate(game.to_hash)
end

print "\n"