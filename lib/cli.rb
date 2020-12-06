class Cli
    attr_reader :games
    def initialize
        @games = Game.all
    end

    def run
        # Run the program by calling Scraper class to get the remote data from the site, and greet user
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
        # Get user input and call method according to it
        user_input = gets.downcase
        if user_input == "\n"
            list_games
        elsif user_input == "exit\n"
            puts "----------"
            puts "Good-bye. Hope to see you again! :)"
        else
            puts "Wrong input!"
            ask_user
        end
    end

    def list_games
        # List all the games and ask for input to see additional list or exit program
        count = 101
        games.each_with_index do |game, i|
            puts "#{i+1}. #{game.title}"
        end
        user_selection
    end

    def user_selection
        puts "Type the number of list you'd like to know more about, or type 'exit' to leave"
        input = gets.strip
        converted_input = input.to_i
        while converted_input != "exit"
            if converted_input.between?(1, 100)
                game = Game.all[converted_input - 1]
                display_game_info(game)
                break
            elsif converted_input == "exit"
                ask_user
            else
                puts "Wrong input! Please type an integer between 1 and #{games.length}"
                puts "--"
                user_selection
            end
        end
        puts "---------------"
        puts "Press 'enter/return' key to see the list again or type 'exit' key to exit"
        ask_user
    end

    def display_game_info(game)
        puts "----------------"
        puts "#{game.title}"
        puts "Rank: #{game.ranking}"
        puts "Release year: #{game.released}"
        puts "Description: #{game.description}"
    end
end
