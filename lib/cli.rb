class Cli
    attr_reader :games
    def run
        puts "Top 100 video games of all time (IGN's report)"
        Scraper.scrape_games
        # binding.pry
        puts "Here is a list of top 100 video games:"
        list_games
    end

    def list_games
        @games = Game.all
        count = 101
        games.each do |game|
            puts "#{count-=1}. #{game.title}"
            # puts "Rank: #{game.ranking}"
            # puts "Release year: #{game.released}"
            # puts "Description: #{game.description}"
        end
    end
end