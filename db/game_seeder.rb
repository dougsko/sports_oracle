# https://fantasysupercontest.com/nfl-export?year=2015&format=json

file = File.open('db/nfl_2013.json')
data = JSON.parse(file.read)

data.each do |game|
    g = Game.new(game)
    g.save
end
