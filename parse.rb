require 'io/console'

def extract_title(*args)
  block_title = args[0]
  ancor_start = block_title.index('<a ')
  unless ancor_start.nil?
    # puts "** " + element.to_s #.get_attribute('href')
    # a = element.css('a')
    # puts 'a = ' + a.to_s
    # puts "** " + a.get_attribute('href')
    # puts '-----------------------------'
    ancor_end = block_title.index('>')
    block_title = block_title[ancor_end + 1..-1]
    closing = block_title.index('</a>')
    block_title = block_title[0..closing - 1]
  end
  block_title
end

def extract_href(ancor)
  href_start = ancor.index('href')
  ancor = ancor[href_start + 1..-1]
  href_quot = ancor.index('\"')
  ancor = ancor[href_quot + 1..-1]
  href_end = ancor.index('\"')
  ancor = ancor[0..href_end - 1]
  ancor
end

def text_lines(text, padding)
  screen_size = IO.console.winsize
  screen_width = screen_size[1]
  line_size = screen_width - (padding * 2)
  r_text = text
  lines = []
  until r_text.nil?
    str_index = line_size - 1
    str_index = shift_index(r_text, str_index) if r_text.index(' ') && (r_text.size > line_size)
    line = r_text[0..str_index]
    lines << line
    r_text = r_text[(str_index + 1)..-1]
  end
  lines
end

def shift_index(r_text, str_index)
  str_index -= 1 while r_text[str_index] != ' '
  str_index
end
