#!/usr/bin/env ruby
#
#

Rating = Struct.new(:rating, :rating_deviation, :volatility)

games = Game.where('year= ? OR year= ?', 2013, 2014)

def create_first_entries
    Team.all.each do |team|
        rating = Rating.new(1500, rand(340..360), 0.06)
        stat = StatEntry.new(week: 0, year: 2013, team_id: team.id, stat_id: 1, rating: rating[:rating], rating_deviation: rating[:rating_deviation], volatility: rating[:volatility])
        stat.save
    end
end

def process()
    #games = Game.where('year= ? OR year= ?', 2013, 2015)
    #
    # StatEntry.where('week != 0').map{|s| s.delete}

    games = Game.where('home_score != nil')
    games.each do |game|
        if game.home_score > game.away_score
            winner = Team.where(short_name: game.home_team)[0]
            loser = Team.where(short_name: game.away_team)[0]
        else
            winner = Team.where(short_name: game.away_team)[0]
            loser = Team.where(short_name: game.home_team)[0]
        end

        winner_stat = StatEntry.where(stat_id: 1, team_id: winner.id).last
        loser_stat = StatEntry.where(stat_id: 1, team_id: loser.id).last

        winner_rating = Rating.new(winner_stat.rating, winner_stat.rating_deviation, winner_stat.volatility)
        loser_rating = Rating.new(loser_stat.rating, loser_stat.rating_deviation, loser_stat.volatility)

        period = Glicko2::RatingPeriod.from_objs([winner_rating, loser_rating])
        period.game([winner_rating, loser_rating], [1, 2])
        next_period = period.generate_next
        next_period.players.each { |p| p.update_obj }

        new_winner_stat = StatEntry.new(week: game.week, year: game.year, team_id: winner.id, stat_id: 1, 
                                        rating: next_period.players[0].obj[:rating], rating_deviation: next_period.players[0].obj[:rating_deviation], 
                                        volatility: next_period.players[0].obj[:volatility])
        new_loser_stat = StatEntry.new(week: game.week, year: game.year, team_id: loser.id, stat_id: 1, 
                                       rating: next_period.players[1].obj[:rating], rating_deviation: next_period.players[1].obj[:rating_deviation], 
                                       volatility: next_period.players[1].obj[:volatility])

        new_winner_stat.save
        new_loser_stat.save
    end
end
