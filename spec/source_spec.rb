require_relative '../source'
require_relative '../newsweek'

RSpec.describe Source do
  newsweek_hash = {}
  newsweek_hash.extend(NewsWeek)

  describe '#initialize' do
    it 'returns true newsweek_hash responds to method "setup" ' do
      expect(newsweek_hash.respond_to?(:setup)).to be true
    end
  end

  # newsweek_hash.setup
  # let(:source) { Source.new() }

  # describe '#new instance' do
  #   it 'returns true if \"FEATURED STORIES\" is found in the page\'s sections' do

  #   end
  # end
end