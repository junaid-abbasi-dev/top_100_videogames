require 'pry'
class Cli
    #attr_accessor :count
    attr_reader :games
    def initialize
        @games = Game.all
        loading
    end

    def loading
        spinner = TTY::Spinner.new("[:spinner] Loading...", format: :pulse_2)
        spinner.auto_spin
        sleep(2)
        spinner.stop()
    end

    def run
        # Run the program by calling Scraper class to get the remote data from the site, and greet user
        Scraper.scrape_games
        menu
    end

    def menu
        font = TTY::Font.new(:starwars)
        pastel = Pastel.new
        puts pastel.cyan(font.write("top 100"))
        puts pastel.cyan(font.write("video games"))
        puts pastel.cyan(font.write("of all time"))
        puts "Press 'enter/return' key to see the list or type 'exit' key to exit"
        ask_user
    end

    def ask_user
        # Get user input and call method according to it
        user_input = gets.downcase
        if user_input == "\n"
            list_games
        elsif user_input == "exit\n"
            exit_message
        else
            puts "Wrong input! Press 'enter/return' key to see the list again or type 'exit' key to exit"
            ask_user
        end
    end

    def list_games
        # List all the games and ask for input to see additional list or exit program
        games.each_with_index do |game, i|
            puts "#{i+1}. #{game.title}"
        end
        user_selection
    end

    def user_selection
        puts "Type the number of list you'd like to know more about, or type 'exit' to leave"
        input = gets.strip.downcase
        converted_input = input.to_i
        # binding.pry
        if input == "exit"
            exit_message
        end

        while input != "exit"
            if converted_input.between?(1, games.count)
                game = Game.all[converted_input - 1]
                display_game_info(game)
                puts "Press 'enter/return' key to see the list again or type 'exit' key to exit"
                ask_user
                break
            else
                puts "Wrong input! Please type an integer between 1 and #{games.length}"
                user_selection
                break
            end    
        end
    end

    def display_game_info(game)
        #font = TTY::Font.new(:starwars)
        # pastel = Pastel.new
        # puts pastel.cyan(font.write("#{game.title.gsub(/[\r\n]+/, ' ')}"))
        puts "Title: #{game.title}"
        puts "Rank: #{game.ranking}"
        puts "Release year: #{game.released}"
        puts "Description: #{game.description}"
    end

    def exit_message
        font = TTY::Font.new(:starwars)
        pastel = Pastel.new
        puts pastel.cyan(font.write("Good-bye :)"))
    end
end
