class Cli
    attr_accessor :count
    attr_reader :games, :pastel, :font
    def initialize
        @games = Game.all
        @pastel = Pastel.new
        @font = TTY::Font.new(:starwars)
        loading
    end

    def run
        Scraper.scrape_games
        menu
    end

    def menu
        greeting_message
        user_choice_message
        ask_user
    end

    def ask_user
        user_input = gets.downcase
        if user_input == "\n"
            list_games(games)
        elsif user_input == "exit\n"
            exit_message
        elsif user_input.to_i.between?(1990, 2020)
            game_list = Game.find_all_games_by_year(user_input.to_i)
            list_games(game_list)
        else
            wrong_input
            user_choice_message
            ask_user
        end
    end

    def list_games(game_list)
        @game_list = game_list
        @count ||= 0
        game_list[count..count+19].each.with_index(1) do |game, i|
            puts "#{pastel.yellow(count+i)}. #{game.title}"
        end

        if count.between?(0, 18) && game_list.size > 20
            next_msg
        elsif count.between?(19, 80) && game_list.size > 20
            previous_msg
        elsif count.between?(19, 100) && game_list.size > 20
            next_or_previous
        elsif game_list.size < 20
            puts 
        else
            wrong_input
            puts "Please type an integer between #{pastel.yellow(1)} and #{pastel.yellow(game_list.length)}"
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
            if converted_input.between?(1, @game_list.count)
                game = @game_list[converted_input - 1]
                display_game_info(game)
                user_choice_message
                ask_user
                break
            elsif input == "next" && @game_list.size > 20
                self.count += 19
                list_games(@game_list)
                break
            elsif input == "previous" && @game_list.size > 20
                self.count -= 19
                list_games(@game_list)
                break
            elsif input == "exit"
                exit_message
            else
                wrong_input
                puts "Please type an integer between #{pastel.yellow(1)} and #{pastel.yellow(@game_list.length)}"
                user_selection
                break
            end    
        end
    end
        
    # User Messages Methods --

    def display_game_info(game)
        puts pastel.cyan(font.write("//")) 
        puts "#{pastel.yellow("Title:")} #{game.title}"
        puts "#{pastel.yellow("Rank:")} #{game.ranking}"
        puts "#{pastel.yellow("Release year:")} #{game.released}"
        puts "#{pastel.yellow("Description:")} #{game.description}"
        puts "#{pastel.yellow("Fact:")} #{game.fact}"
        puts pastel.cyan(font.write("//")) 
    end

    def loading
        spinner = TTY::Spinner.new("[:spinner] #{pastel.yellow("Loading...")}", format: :pulse_2)
        spinner.auto_spin
        sleep(2)
        spinner.stop()
    end

    def greeting_message
        puts pastel.yellow(font.write("top 100"))
        puts pastel.yellow(font.write("video games"))
        puts pastel.yellow(font.write("of all time"))
    end
    
    def user_choice_message
        puts "Press '#{pastel.yellow("enter/return")}' key to see the full list, or type number of '#{pastel.yellow("year")}' that you're interested into or type '#{pastel.red("exit")}' to exit"
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
