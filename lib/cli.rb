class Cli
    attr_reader :games
    def initialize
        @games = Game.all
    end

    def run
        Scraper.scrape_games
        menu
    end

    def menu
        # Greet user and and ask for input to continue or exit.
        puts "Hi! Welcome to Command Line Top 100 Video Games of all time."
        puts "Press 'enter/return' key to see the list or type 'exit' key to exit"
        ask_user
    end

    def ask_user
        user_input = gets
        if user_input == "\n"
            list_games
        elsif user_input == "exit\n"
            puts "See you again!"
        end
    end

    def list_games
        count = 101
        games.each do |game|
            puts "#{count-=1}. #{game.title}"
            # puts "Rank: #{game.ranking}"
            # puts "Release year: #{game.released}"
            # puts "Description: #{game.description}"
            #puts "Select any game from the list to get more information: (1 - 100)"
        end
    end
end