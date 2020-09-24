require 'byebug'
require 'httparty'
require 'nokogiri'

def scraper
    url = 'https://www.indeed.com/jobs?q=software+developer&l=Remote'
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page)
    jobs = Array.new
    job_listings = parsed_page.css('div.jobsearch-SerpJobCard') #15 jobs on first page
    page = 1
    per_page = job_listings.count #15
    total = parsed_page.css('div.searchCountContainer').text.split(' ')[3].gsub(',','').to_i #6484
    last_page = (total.to_f / per_page.to_f ).round #432
    while page <= last_page
        pagination_url = "https://www.indeed.com/jobs?q=software+developer&l=Remote&start=#{page}"
        pagination_unparsed_page = HTTParty.get(pagination_url)
        pagination_parsed_page = Nokogiri::HTML(pagination_unparsed_page)
        pagination_job_listings = pagination_parsed_page.css('div.jobsearch-SerpJobCard')
        pagination_job_listings.each do |job_listing|
            job = {
                title: job_listing.css('a.jobtitle').text,
                company: job_listing.css('span.company').text,
                location: job_listing.css('span.location').text,
                url: "https://indeed.com" + job_listing.css('a')[0].attributes["href"].value
            }
            jobs << job
        end
        page +=
    end
    byebug
end

scraper

