require 'byebug'
require 'httparty'
require 'nokogiri'
require_relative '../lib/scraper'
require_relative '../lib/results'

puts ' '
puts 'Enter job position :'
keyword = gets.chomp
while keyword.empty?
  puts ' '
  puts 'Enter a valid position:'
  keyword = gets.chomp
end
puts ' '
puts '--------------------------------------'
puts 'Indeed.com is a very big site with thousands of remote  jobs'
puts ' '
puts ' '
puts 'Please be patient ......  Searching ...'
puts '--------------------------------------'
@array = keyword.split(' ')
scraping = Scraper.new
scraping.scraper(@array)

save = Results.new(@array)
# save = Results.new(scraping.scraper(@array))
save.begin_html
save.store(scraping.titles, scraping.company, scraping.locations, scraping.urls)
save.end_html
save.close_file

# puts "Jobs found for the position #{@array.join(' ')} are #{scraping.titles.count}"
puts "#{scraping.titles.count} remote jobs have been found for the position of #{@array.join(' ')}"
puts 'Find a file of your search results in :'
puts "remote_jobs/job_listing_for_#{@array.join('_')}"
