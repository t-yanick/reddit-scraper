require 'byebug'
require 'httparty'
require 'nokogiri'

def scraper
    url = 'https://www.indeed.com/jobs?q=software+developer&l=Remote'
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)
    job_listings = parsed_page.css('div.jobsearch-SerpJobCard') #15 jobs on first page
    job_listings.each do |job_listing|
        job = {
            title: job_listing.css('a.jobtitle').text,
            company: job_listing.css('span.company').text,
            location: job_listing.css('span.location').text,
            url: "https://indeed.com" + job_listing.css('a')[0].attributes["href"].value
        }
        byebug
    end
end

scraper
