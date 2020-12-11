class Scraper
    BASE_URL= "https://www.ign.com/lists/top-100-games/"

    def self.scrape_games
        html = open(BASE_URL)
        parsed_html = Nokogiri::HTML(html)
        game_articles = parsed_html.css("article")
        game_articles.map do |game|
            #binding.pry   
            hash = {
                fact: game.css("ul.ul li.item-highlight").first.text.strip,
                description: game.css("div.item-body p").first.text.strip,
                released: game.css("span.item-label-value").first.text.strip,
                ranking: game.css("div.badge-number").first.text.strip,
                title: game.css("div.item-heading a").first.text.strip
            }
            Game.new(hash)
        end
        #binding.pry
    end
end