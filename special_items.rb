require 'nokogiri'
require 'open-uri'
require_relative 'parse'
require_relative 'strings'

href = ''
items = doc.css('.block-ibtmedia-special-item')

puts 'Special count : ' + items.count.to_s
puts '----------------------------------------------'
items.each do |feature|
  # category = feature.css('.category')
  # print category.text + " : "
  block_title = feature.css('h3')
  a = block_title.css('a')
  title = extract_title(a.inner_html.strip, a)
  title = title.uni_flat
  puts title
  href = extract_href(a.to_s)
  puts '    ' + href
end

# system("open #{href}")
