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
        all.select {|game| game.released.to_i == year} 
    end

    def self.sorted_years
        # binding.pry
        all.sort_by {|game| game.released}
    end

end