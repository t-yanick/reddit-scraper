# rubocop : disable Metrics/AbcSize

# rubocop : disable Metrics/MethodLength

require 'byebug'
require 'httparty'
require 'nokogiri'

class Scraper
  attr_reader :job, :jobs, :total, :page, :titles, :company, :locations, :urls, :parsed_page, :pagination

  private

  def initialize
    @titles = []
    @company = []
    @locations = []
    @urls = []
  end

  public

  def scraper(arr)
    url = "https://www.indeed.com/jobs?q=#{arr}&l=Remote"
    unparsed_page = HTTParty.get(url)
    parsed_page = Nokogiri::HTML(unparsed_page.body)
    jobs = []
    job_listings = parsed_page.css('div.jobsearch-SerpJobCard')
    page = 0
    per_page = job_listings.count
    total = parsed_page.css('div.searchCountContainer').text.split(' ')[3].gsub(',', '').to_i
    last_page = (total / per_page.to_f).round
    while page <= last_page
      pagination_url = "https://www.indeed.com/jobs?q=#{arr}&l=Remote&start=#{page}"

      pagination_unparsed_page = HTTParty.get(pagination_url)
      pagination_parsed_page = Nokogiri::HTML(pagination_unparsed_page.body)
      pagination_job_listings = pagination_parsed_page.css('div.jobsearch-SerpJobCard')
      pagination_job_listings.each do |job_listing|
        job = {
          title: job_listing.css('a.jobtitle').text.strip.partition('/n')[0],
          company: job_listing.css('span.company').text,
          location: job_listing.css('span.location').text,
          url: 'https://indeed.com' + job_listing.css('a')[0].attributes['href'].value
        }
        if arr.all? { |x| job[:title].downcase.split.include?(x) }
          @titles << (job[:title])
          @company << (job[:company])
          @locations << (job[:location])
          @urls << (job[:url])
        end

        jobs << job
      end
      page += 10

    end
  end
end

# rubocop : enable Metrics/AbcSize

# rubocop : enable Metrics/MethodLength
