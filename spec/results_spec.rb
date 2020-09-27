require_relative '../lib/results'

describe Results do
    let(:input) {Results.new('engineer')}
    describe 'initialize' do
        it 'Calls input and creates a file with input name' do
            expect (input.file.class).to eql(File)
        end
    end
end