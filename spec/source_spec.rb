require_relative '../source'
require_relative '../newsweek'

RSpec.describe Source do
  newsweek_hash = {}
  newsweek_hash.extend(NewsWeek)

  describe '#NewsWeek' do
    it 'returns true newsweek_hash responds to method "setup" ' do
      expect(newsweek_hash.respond_to?(:setup)).to be true
    end
  end

  newsweek_hash.setup
  source = Source.new(newsweek_hash)
  source.open
  
  describe '#Source' do
    it 'returns true if FEATURED STORIES is found in the page sections' do
      expect(source.sections.any? { |section| 
      puts section.title
      section.title.upcase == 'FEATURED STORIES' 
      }).to be true
    end
  end
end