require 'nokogiri'
require 'open-uri'
require_relative 'utils'
require_relative 'source'
require_relative 'section'
require_relative 'article'

PADDING = 4
PROGRAM_STATUS_SOURCES = 1
PROGRAM_STATUS_SECTIONS = 2
PROGRAM_STATUS_ARTICLES = 3
PROGRAM_STATUS_ART_INFO = 4
@program_status = PROGRAM_STATUS_SOURCES

SEARCH_STATUS_NONE = 0
SEARCH_STATUS_SEARCH = 1
SEARCH_STATUS_RESULTS = 2
@search_status = SEARCH_STATUS_NONE

# source_modules = [{file: 'newsweek', module: Object.const_get('NewsWeek')},
#                   {file: 'nytimes', module: Object.const_get('NewYorkTimes')}]
# source_modules.each do |configuration|
#   require_relative configuration[:file]
#   hash = {}
#   hash.extend(configuration[:module])
#   hash.setup
# end

require_relative 'newsweek'
require_relative 'nytimes'

newsweek_hash = {}
newsweek_hash.extend(NewsWeek)
newsweek_hash.setup

nytime_hash = {}
nytime_hash.extend(NewYorkTimes)
nytime_hash.setup

@sources = []
@sources << Source.new(newsweek_hash)
@sources << Source.new(nytime_hash)

@current_source = nil
@current_section = nil
@current_article = nil

def fprint(str)
  print String.new(' ' * PADDING) + str
end

def fputs(str)
  puts String.new(' ' * PADDING) + str
end

def show_sources
  @current_source = nil
  puts
  sources_count = 0
  @sources.each do |source|
    sources_count += 1
    fputs "#{sources_count}. #{source.caption}"
    source.errors.each { |error| fputs '* ' + error }
  end
  puts
  puts horz_line(PADDING)
  fputs 'Select Source Number'
end

def show_sections
  puts
  fputs @current_source.caption
  puts top_line('SECTIONS', PADDING)
  puts
  @current_source.sections.each_with_index do |section, i|
    fputs((' ' + (i + 1).to_s)[-2..-1] + '. ' + section.title.upcase)
  end
  puts
  puts horz_line(PADDING)
  show_text_lines('Select Section Number' + ' | ' + 'Press Enter Key to return to Sources')
end

def show_articles
  puts
  fputs @current_source.caption
  puts top_line(@current_section.title.upcase, PADDING)
  puts
  @current_section.articles.each_with_index { |article, i| show_article_header_lines(article.header, i) }
  puts
  puts horz_line(PADDING)
  show_text_lines('Select Article Number' + ' | ' + 'Press Enter Key to return to Sections')
end

def show_article_info
  puts
  fputs @current_source.caption
  puts top_line(@current_section.title.upcase, PADDING)
  puts
  fputs 'ARTICLE INFO'
  show_text_lines('- ' + @current_article.header)
  puts horz_line(PADDING)
  show_text_lines(@current_article.description)
  puts
  puts horz_line(PADDING)
  show_text_lines('Press Enter Key to return to Articles')
end

def show_search_request
  if @current_source.nil?
    
end

def show_search_results
  if @current_source.nil?
    @sources.each do |source| 
      source.search_results.each do |result|
        show_text_lines(result[:article].header)
        puts horz_line(PADDING)
      end
    end
  else
    @current_source.search_results.each do |result|
      show_text_lines(result[:article].header)
      puts horz_line(PADDING)
    end
end
end

def show_article_header_lines(article_header, article_index)
  header = (' ' + (article_index + 1).to_s)[-2..-1] + '. ' + article_header
  lines = header_lines(header, PADDING)
  lines.each { |line| fputs line }
end

def show_text_lines(text)
  lines = text_lines(text, PADDING)
  lines.each { |line| fputs line }
end

def handle_program_input(input)
  handle_return if input.size.zero?
  handle_navigation(input)
  @search_status = SEARCH_STATUS_SEARCH if input.downcase == 's'
  return false if input.downcase == 'x'

  true
end

def handle_navigation(input)
  handle_article_input(input.to_i) if @program_status == PROGRAM_STATUS_ART_INFO
  handle_articles_input(input.to_i) if @program_status == PROGRAM_STATUS_ARTICLES
  handle_sections_input(input.to_i) if @program_status == PROGRAM_STATUS_SECTIONS
  handle_source_input(input.to_i) if @program_status == PROGRAM_STATUS_SOURCES
end

def handle_source_input(inp)
  return if (1..@sources.count).none?(inp)

  return unless @sources[inp - 1].open

  @current_source = @sources[inp - 1]
  @program_status = PROGRAM_STATUS_SECTIONS
end

def handle_sections_input(inp)
  return if (1..@current_source.sections.count).none?(inp)

  @current_section = @current_source.sections[inp - 1]
  @program_status = PROGRAM_STATUS_ARTICLES
end

def handle_articles_input(inp)
  return if (1..@current_section.articles.count).none?(inp)

  @current_article = @current_section.articles[inp - 1]
  @program_status = PROGRAM_STATUS_ART_INFO
end

def handle_article_input(inp)
  return if (1..@current_section.articles.count).none?(inp)

  @current_article = @current_section.articles[inp - 1]
  @program_status = PROGRAM_STATUS_ART_INFO
end

def handle_search_request(input)
  handle_search_return if input.size.zero?
  handle_search(input) if input.size.positive?
end

def handle_search_return
  @search_status = SEARCH_STATUS_NONE if @search_status == SEARCH_STATUS_SEARCH

  @search_status = SEARCH_STATUS_SEARCH if @search_status == SEARCH_STATUS_RESULTS
end

def handle_search(input)
  @search_status = SEARCH_STATUS_RESULTS
  if @current_source.nil?
    @sources.each { |source| source.search(input)}
  else
    @current_source.search(input)
  end
end

def clear_screen
  system('clear') || system('cls')
end

def user_input
  show_text_lines('Enter "s" to search content | Enter "x" to end the program')
  puts horz_line(PADDING)
  fprint ''
  gets.chomp
end

def search_request
  puts horz_line(PADDING)
  src = @current_source.nil? ? 'All Sources' : @current_source.caption
  show_text_lines("Enter text to be searched in #{src}")
  puts horz_line(PADDING)
  fprint ''
  gets.chomp
end

def handle_return
  @program_status = PROGRAM_STATUS_SOURCES if @program_status == PROGRAM_STATUS_SECTIONS

  @program_status = PROGRAM_STATUS_SECTIONS if @program_status == PROGRAM_STATUS_ARTICLES

  @program_status = PROGRAM_STATUS_ARTICLES if @program_status == PROGRAM_STATUS_ART_INFO
end

loop do
  clear_screen
  if @search_status == SEARCH_STATUS_NONE
    show_sources if @program_status == PROGRAM_STATUS_SOURCES

    show_sections if @program_status == PROGRAM_STATUS_SECTIONS

    show_articles if @program_status == PROGRAM_STATUS_ARTICLES

    show_article_info if @program_status == PROGRAM_STATUS_ART_INFO

    break unless handle_program_input(user_input)
  else
    show_search_request if @search_status == SEARCH_STATUS_SEARCH
    show_search_results if @search_status == SEARCH_STATUS_RESULTS

    handle_search_request(search_request)
  end
end

system('clear') || system('cls')
fputs 'SCRAPER PROGRAM ENDED'
