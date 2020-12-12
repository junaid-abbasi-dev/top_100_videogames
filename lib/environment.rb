require "nokogiri"
require "open-uri"
require "pry"
require "tty-box"
require "tty-color"
require "tty-font"
require "pastel"
require "tty-progressbar"
require "tty-spinner"


require_relative "./top_100_videogames/version"
require_relative './scraper'
require_relative './cli'
require_relative './models/game'
# require_relative './models/developer'


module Top100Videogames
  class Error < StandardError; end
  # Your code goes here...
end
