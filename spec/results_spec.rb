
require_relative '../lib/results.rb'

describe Results do
  let(:input) { Results.new('d') }
  describe 'initialize' do
    it 'Calls input and creates a file with input name' do
      expect(input.file.class).to eql(File)
    end
  end
end
