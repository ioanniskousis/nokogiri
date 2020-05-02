require 'nokogiri'
require 'open-uri'

require_relative 'source'
require_relative 'section'
require_relative 'article'

PADDING = '    '.freeze
PROGRAM_STATUS_SOURCES = 1
PROGRAM_STATUS_SECTIONS = 2
PROGRAM_STATUS_ARTICLES = 3
PROGRAM_STATUS_ART_INFO = 4
@program_status = 1

require_relative 'newsweek'
require_relative 'nytimes'
@sources = []
@sources << Source.new($source_hash1)
@sources << Source.new($source_hash2)

@current_source = nil
@current_section = nil
@current_article = nil

def fprint(str)
  print PADDING + str
end

def fputs(str)
  puts PADDING + str
end

def show_sources
  puts
  sources_count = 0
  @sources.each do |source|
    sources_count += 1
    fputs "#{sources_count}. #{source.caption}"
    source.errors.each { |error| fputs '* ' + error }
  end
  puts
  fputs 'Select Source'
end

def show_sections
  puts
  fputs @current_source.caption
  fputs 'SECTIONS'
  puts
  @current_source.sections.each_with_index do |section, i|
    fputs((' ' + (i + 1).to_s)[-2..-1] + '. ' + section.title.upcase)
  end
  puts
  fputs 'Select Section' + ' | ' + 'Press Enter Key to return to Sources'
end

def show_articles
  puts
  fputs @current_source.caption
  fputs @current_section.title.upcase
  puts
  @current_section.articles.each_with_index do |article, i|
    header = (' ' + (i + 1).to_s)[-2..-1] + '. ' + article.header
    desc_lines = text_lines(header, PADDING.size)
    desc_lines.each { |line| fputs line }
  end
  puts
  fputs 'Select Article' + ' | ' + 'Press Enter Key to return to Sections'
end

def show_article_info
  puts
  fputs @current_source.caption
  fputs @current_section.title.upcase
  puts
  fputs 'ARTICLE INFO'
  fputs '- ' + @current_article.header
  desc_lines = text_lines(@current_article.description, PADDING.size)
  desc_lines.each { |line| fputs line }
  puts
  fputs 'Press Enter Key to return to Articles'
end

def handle_source_input(inp)
  # puts 'handle_source_input ' + @sources.count.to_s + imp.to_s
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

def handle_return
  @program_status = PROGRAM_STATUS_SOURCES if @program_status == PROGRAM_STATUS_SECTIONS

  @program_status = PROGRAM_STATUS_SECTIONS if @program_status == PROGRAM_STATUS_ARTICLES

  @program_status = PROGRAM_STATUS_ARTICLES if @program_status == PROGRAM_STATUS_ART_INFO
end

loop do
  system('clear') || system('cls')
  show_sources if @program_status == PROGRAM_STATUS_SOURCES

  show_sections if @program_status == PROGRAM_STATUS_SECTIONS

  show_articles if @program_status == PROGRAM_STATUS_ARTICLES

  show_article_info if @program_status == PROGRAM_STATUS_ART_INFO

  fprint ''
  inp = gets.chomp
  handle_return if inp.size.zero? || (@program_status == PROGRAM_STATUS_ART_INFO)
  handle_articles_input(inp.to_i) if @program_status == PROGRAM_STATUS_ARTICLES
  handle_sections_input(inp.to_i) if @program_status == PROGRAM_STATUS_SECTIONS
  handle_source_input(inp.to_i) if @program_status == PROGRAM_STATUS_SOURCES

  break if inp.downcase == 'z'
end

system('clear') || system('cls')
fputs 'SCRAPER PROGRAM ENDED'
