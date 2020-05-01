def extract_title(block_title, element)
  ancor_start = block_title.index('<a ')
  unless ancor_start == nil
    # puts "** " + element.to_s #.get_attribute('href')
    a = element.css('a')
    # puts 'a = ' + a.to_s
    # puts "** " + a.get_attribute('href')
    # puts '-----------------------------'
    ancor_end = block_title.index('>')
    block_title = block_title[ancor_end+1..-1]
    closing = block_title.index('</a>')
    block_title = block_title[0..closing-1]
  end
  block_title
end

def extract_href(a)
  href_start = a.index("href")
  a = a[href_start+1..-1]
  href_quot = a.index("\"")
  a = a[href_quot+1..-1]
  href_end =  a.index("\"")
  a = a[0..href_end-1]
  a
end

# def uni_flat(str)
#   str = str.gsub('&#x2019;', '\'')
#   str
# end

url = 'https://www.newsweek.com'
$doc = Nokogiri::XML(open(url, 'User-Agent' => 'mozilla'))
