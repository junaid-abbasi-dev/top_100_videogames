class Cli
    attr_accessor :count
    attr_reader :games, :pastel, :font
    def initialize
        @games = Game.all
        @pastel = Pastel.new
        @font = TTY::Font.new(:starwars)
        loading
    end

    def loading
        spinner = TTY::Spinner.new("[:spinner] #{pastel.yellow("Loading...")}", format: :pulse_2)
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
        greeting_message
        user_choice_message
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
            wrong_input
            user_choice_message
            ask_user
        end
    end

    def list_games
        # List all the games and ask for input to see additional list or exit program
        @count ||= 0
        games[count..count+19].each.with_index(1) do |game, i|
            puts "#{pastel.yellow(count+i)}. #{game.title}"
        end

        if count.between?(0, 18)
            next_msg
        elsif count.between?(19, 80)
            previous_msg
        elsif count.between?(19, 100)
            next_or_previous
        else
            wrong_input
            puts "Please type an integer between #{pastel.yellow(1)} and #{pastel.yellow(games.length)}"
        end
        user_selection
    end

    def user_selection
        puts "Type the number of list you'd like to know more about, or type '#{pastel.red("exit")}' to leave"
        input = gets.strip.downcase
        converted_input = input.to_i
        if input == "exit"
            exit_message
        end

        while input != "exit"
            if converted_input.between?(1, games.count)
                game = Game.all[converted_input - 1]
                display_game_info(game)
                user_choice_message
                ask_user
                break
            elsif input == "next"
                self.count += 19
                list_games
                break
            elsif input == "previous"
                self.count -= 19
                list_games
                break
            elsif input == "exit"
                exit_message
            else
                wrong_input
                puts "Please type an integer between #{pastel.yellow(1)} and #{pastel.yellow(games.length)}"
                user_selection
                break
            end    
        end
    end

    def display_game_info(game)
        puts pastel.cyan(font.write("//")) 
        puts "#{pastel.yellow("Title:")} #{game.title}"
        puts "#{pastel.yellow("Rank:")} #{game.ranking}"
        puts "#{pastel.yellow("Release year:")} #{game.released}"
        puts "#{pastel.yellow("Description:")} #{game.description}"
        puts "#{pastel.yellow("Fact:")} #{game.fact}"
        puts pastel.cyan(font.write("//")) 
    end

    # User Messages --

    def greeting_message
        puts pastel.yellow(font.write("top 100"))
        puts pastel.yellow(font.write("video games"))
        puts pastel.yellow(font.write("of all time"))
    end
    
    def user_choice_message
        puts "Press '#{pastel.yellow("enter/return")}' key to see the list or type '#{pastel.red("exit")}' to exit"
    end

    def wrong_input
        puts "#{pastel.red("Wrong Input!")}"
    end

    def next_msg
        puts "Type '#{pastel.yellow("Next")}' to see more list of games"  
    end

    def previous_msg
        puts "Type '#{pastel.yellow("Previous")}' to see previous list or '#{pastel.yellow("Next")}' to see more list"
    end

    def next_or_previous
        puts "Type '#{pastel.yellow("Previous")}' to see previous list of games "
    end

    def exit_message
        puts pastel.yellow(font.write("Good-bye :)"))
    end
end
