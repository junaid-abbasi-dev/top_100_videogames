class Scraper
    BASE_URL= "https://www.ign.com/lists/top-100-games/"

    def self.scrape_games
        html = open(BASE_URL)
        parsed_html = Nokogiri::HTML(html)
        game_articles = parsed_html.css("section.items article.item")
        game_articles.each do |game|
            #binding.pry   
            hash = {
                title: game.css("div.item-heading a").text,
                rating: game.css("div.badge-number").text,
                release_year: game.css("span.item-label-value").text,
                #description: game.css("div.item-body p").text
            }
            Game.new(hash)
        end
        binding.pry
    end
end