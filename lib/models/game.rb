class Game
    @@all = []

    def initialize(hash)
        hash.each do |key, value|
            self.class.attr_accessor key
            self.send("#{key}=", value)
        end
        save
    end

    def save
        self.class.all << self
    end

    def self.all
        @@all
    end
    
    def self.find_all_games_by_year(year)
        #binding.pry
        all.select {|game| game.released.to_i == year} 
    end

end