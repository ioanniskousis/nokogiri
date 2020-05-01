# import nokogiri to parse and open-uri to scrape
require 'nokogiri'
require 'open-uri'

def extract_title(block_title, element)
  ancor_start = block_title.index('<a ')
  unless ancor_start == nil
    puts "** " + element.to_s #.get_attribute('href')
    a = element.css('a')
    puts 'a = ' + a.to_s
    # puts "** " + a.get_attribute('href')
    # puts '-----------------------------'
    ancor_end = block_title.index('>')
    block_title = block_title[ancor_end+1..-1]
    closing = block_title.index('</a>')
    block_title = block_title[0..closing-1]
  end
  block_title
end
# set the URL to scape
# url = 'http://127.0.0.1:5500/index.html'
url = 'https://www.newsweek.com'
# url = 'https://www.nytimes.com'
# url = 'https://www.sudokun.com'
# url = 'https://www.plaisio.gr/pc-perifereiaka/laptops/business-laptops/windows-10-pro-64-bit/sortby-price'
# url = 'https://www.amazon.co.uk/b/?node=1340509031&ref_=Oct_s9_apbd_odnav_hd_bw_b2Lt8_2&pf_rd_r=T8VCQMVHXRVAA851KB42&pf_rd_p=9fcaa2d5-b1f2-556b-a30a-2137dcb9bdf3&pf_rd_s=merchandised-search-11&pf_rd_t=BROWSE&pf_rd_i=560798'
# url = 'https://www.udacity.com'


# create a new Nokogiri HTML object from the scraped URL
doc = Nokogiri::HTML(open(url, 'User-Agent' => 'mozilla'))

# loop through an array of objects matching a CSS selector
# links = doc.css('a.fd-card')
# 'block-title'
# puts "links count : " + links.count.to_s
# links.each do |link|
#   # print the link text
#   # card = link.css('a.fd-card')
#   title = link.css('div.fd-card__body')
#   puts title.inner_html
#   et = link.css('.fd-card__footer__body')
#   puts 'ESTIMATED TIME : ' + et.inner_html
#   dif = link.css('.difficulty__details')
#   puts "Difficulty : " + dif.inner_html

#   puts
#   # puts link.content
# end

# data.each_line { |line|  p line }

# contents = doc.css('.content')

# puts "Content sections : " + contents.count.to_s
# contents.each do |content|
#   block_title = content.css('.block-title')
#   if block_title
#     # a = block_title.css('a')
#     # if a
#     #   puts a.inner_html
#     # els
#     if block_title.inner_html.strip.size.positive?
#       # a = block_title.inner_html.strip.css('a')
#       # if a
#       #   puts a.inner_html
#       # else
#         puts block_title.inner_html.strip
#       # end
    
#     end
#   end
#   # puts link.content
# end


features = doc.css('.feature2')

puts 'Features count : ' + features.count.to_s
puts '----------------------------------------------'
features.each do |feature|
  block_title = feature.css('.block-title')
  if block_title
    if block_title.inner_html.strip.size.positive?
      title = extract_title(block_title.inner_html.strip, block_title)
      puts title
    end
  end
end

