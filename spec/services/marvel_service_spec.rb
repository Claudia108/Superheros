require 'rails_helper'

describe MarvelService do
  attr_reader :service

  before(:each) do
    @service = MarvelService.new
  end


  describe "#characters" do
    it "finds a character and it's comics" do
      VCR.use_cassette("services/return_characters") do
        characters = service.characters({ limit: 100, offset: 0 })
        character  = characters.first

        expect(characters.count).to eq(100)
        expect(character[:name]).to eq('3-D Man')
        expect(character[:comics][:available]).to eq(11)
      end
    end
  end

  describe "#total" do
    it "shows total of all characters" do
      VCR.use_cassette("services/return_total") do
        total = service.total({ limit: 100, offset: 0 })

        expect(total).to eq(1485)
      end
    end
  end

  describe "#all_characters" do
    it "returns all available characters" do
      VCR.use_cassette("services/return_all_characters") do
        all_characters = service.all_characters({ limit: 100, offset: 0 })

        expect(all_characters.count).to eq(1485)
      end
    end
  end
end
