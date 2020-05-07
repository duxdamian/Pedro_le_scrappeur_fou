require 'pry'
require 'dotenv'
require 'rubygems'
require 'nokogiri'
require 'open-uri'

# def open_website(url)
# page = Nokogiri::HTML(open(url))
# page.class   # => Nokogiri::HTML::Document
# end
def open_website(url)
  page = Nokogiri::HTML(open(url))   
  # page.class   # => Nokogiri::HTML::Document
  page
end

def coinmarketcap_name
  currency_name_array = []
  page_html = "https://coinmarketcap.com/all/views/all/"
  coinmarketcap_page = Nokogiri::HTML(open(page_html))
  return currency_name_array = coinmarketcap_page.xpath("//tr/td/a[contains(@class, 'currency-name-container')]/text()").map {|x| x.to_s }
end

def coinmarketcap_price (price)
  currency_price_array = []
  for n in 0...price.length
    page_html = "https://coinmarketcap.com/all/views/all/"
    coinmarketcap_page_price = Nokogiri::HTML(open(page_html))
    begin
      currency_price_array << coinmarketcap_page_price.xpath("//tbody/tr/td[@class='cmc-table__cell cmc-table__cell--sortable cmc-table__cell--right cmc-table__cell--sort-by__price']").to_s
      currency_price_array << " "
    end 
  end
  return currency_price_array
end

puts currency_result = Hash[coinmarketcap_name.zip(coinmarketcap_price(coinmarketcap_name))]

# Victor
# crypto_name = site.xpath("//*[@class = 'cmc-tablecell cmc-tablecell--sortable cmc-tablecell--left cmc-tablecell--sort-by__symbol']/div")
# Billy 
#nokogiri_xpath_coin_name = page_html.xpath("//tbody/tr/td[@class='cmc-table__cell cmc-table__cell--sortable cmc-table__cell--right cmc-table__cell--sort-by__price']")
