require 'byebug'
require 'httparty'
require 'nokogiri'
require_relative '../lib/scraper'

puts 'Enter job position :'
keyword = gets.chomp
while keyword.empty?
    puts 'Enter a valid position:'
    keyword = gets.chomp
end
puts 'Indeed.com is a very big site with thousands of remote developer jobs'
puts 'Please be patient ......  Searching ...'
@array = keyword.split(' ')
scraping = Scraper.new
scraping.scraper(@array)