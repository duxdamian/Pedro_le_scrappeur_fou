require 'pry'
require 'dotenv'
require 'rubygems'
require 'nokogiri'
require 'open-uri'


# returns e-mail from one townhall url
#def get_townhall_email(url)
# page_html = open_website(url)
#mail = page_html.xpath("//body/div/main/section/div/table/tbody/tr/td/text()")[7].text()
#end
def open_website(url)
  page = Nokogiri::HTML(open(url))   
  # page.class   # => Nokogiri::HTML::Document
  page
end

def get_townhall_name
  ville_name_array = []
  page_url_region = "https://www.annuaire-des-mairies.com/val-d-oise.html"
  region_page = Nokogiri::HTML(open(page_url_region))
  return ville_name_array = region_page.xpath("//a[contains(@class, 'lientxt')]/text()").map {|x| x.to_s.downcase.gsub(" ", "-") }
end


def get_townhall_email (ville_names)
  # ville_names.length
  ville_email_array = []
  for n in 0...15
    page_url_ville = "https://www.annuaire-des-mairies.com/95/#{ville_names[n]}.html"
    ville_page = Nokogiri::HTML(open(page_url_ville))
    begin
      ville_email_array << ville_page.xpath("//html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]/text()").to_s
      ville_email_array << " "
    end
  end
  return ville_email_array
end

puts email_ville_result = Hash[get_townhall_name.zip(get_townhall_email(get_townhall_name))]

# Merge ville array with email array
# https://apidock.com/ruby/Array/zip  #.zip(*args). Converts any arguments to arrays
# a = [ 4, 5, 6 ]
# b = [ 7, 8, 9 ]
# [1, 2, 3].zip(a, b)   #=> [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
