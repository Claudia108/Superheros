require 'rails_helper'

describe MarvelService do
  attr_reader :service

  before(:each) do
    @service = MarvelService.new
  end


  describe "#characters" do
    it "finds a character and it's comics" do
      VCR.use_cassette("services/return_characters") do
        characters = service.characters({limit: 30})
        character  = characters.first

        expect(characters.count).to eq(30)
        expect(character[:name]).to eq('3-D Man')
        expect(character[:comics][:available]).to eq(11)
      end
    end
  end
end
