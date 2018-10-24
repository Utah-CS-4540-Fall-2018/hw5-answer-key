# == Schema Information
#
# Table name: listings_polls
#
#  id           :integer          not null, primary key
#  finished_at  :datetime
#  is_automated :boolean
#  notes        :text
#  started_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ListingsPoll < ApplicationRecord
  has_many :listings

  RESULTS_PER_PAGE = 96

  def self.run
    new_poll = self.create(started_at: Time.now)
    Search.all.each do |search|
      new_poll.get_listings_for(search)
    end

    new_poll.finished_at = Time.now
    new_poll.save
  end

  def get_listings_for(a_search)
    @search = a_search

    run_search
    collect_listings
  end

  def run_search
    params = {
      keyword: @search.keywords,
      city: '',
      miles: 25,
      sort: 0,
      priceFrom: '',
      priceTo: '',
      state: '',
      zip: '',
      perPage: RESULTS_PER_PAGE
    }

    # a valid GET request url from the browser
    # example url...
    # https://classifieds.ksl.com/search/?keyword=anvil&zip=&miles=25&priceFrom=&priceTo=&marketType[]=Sale&city=&state=&sort=0
    query_params = URI::QueryParams.dump(params)
    full_url = 'https://classifieds.ksl.com/search/?' + query_params
    log("About to GET: #{full_url}")

    options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
    @results_page = Selenium::WebDriver.for(:chrome, options: options)
    @results_page.get(full_url)
  end

  def collect_listings
    listings = @results_page.find_elements(:css, '.listing-item')
    log("Found #{listings.count} listings.")
    
    # For Impress Me Points
    # TODO:  drill into the @results_page for the listings and add
    # of them to the listings associated with the search.
    #
    # if your listings came out in JSON form, you could do something 
    # like this:
    #
    #   @search.listings << self.listings.create( 
    #     title:  raw_listing["title"],
    #     description: raw_listing["description"],
    #     pricing: raw_listing["price"],
    #     url: raw_listing["id"]
    #   )
    #   log("Captured: #{raw_listing['title']}")
    #
    # You may want to lookup the API for Selenium/Webdriver to see
    # how to interrogate the @results_page object. 
    # Some helpful links:
    #  https://seleniumhq.github.io/selenium/docs/api/rb/top-level-namespace.html
    #  https://gist.github.com/kenrett/7553278
  end


  def log(msg)
    self.update_attribute(:notes,  "#{notes}\n#{msg}")
  end

end
