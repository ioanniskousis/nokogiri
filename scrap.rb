require 'nokogiri'
require 'open-uri'
require_relative 'parse'

features = $doc.css('.feature2')

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

