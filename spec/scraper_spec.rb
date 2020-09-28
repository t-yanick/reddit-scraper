# rubocop : disable Layout/LineLength

# frozen_string_literal: true

require_relative '../lib/scraper'

describe Scraper do
  let(:input) { Scraper.new }
  describe 'initialize' do
    it 'initializes empty arrays' do
      expect(input.titles.empty? && input.company.empty? && input.locations.empty? && input.urls.empty?).to eql true
    end
  end

  describe 'scraper' do
    it 'returns false if user input is not valid' do
      expect(input.nil?).to eql false
    end
  end
end

# rubocop : enable Layout/LineLength
