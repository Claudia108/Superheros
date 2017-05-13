require 'rails_helper'

describe Character do
  it "sorts characters by number of comics they appear in" do
    VCR.use_cassette("models/sort_characters") do
      characters = Character.new
      sorted = characters.sort_characters({limit: 100, offset: 0 })

      expect(sorted.count).to eq(1485)
      expect(sorted.first[:comics][:available]).to eq(2939)
      expect(sorted.first[:name]).to eq("Spider-Man")
      expect(sorted.last[:comics][:available]).to eq(0)
      expect(sorted.last[:name]).to eq("Ajaxis")
    end
  end

  it "picks top 15 characters by number of comics they appear in" do
    VCR.use_cassette("models/top_characters") do
      characters = Character.new
      top = characters.top_characters({limit: 100, offset: 0 })

      expect(top.count).to eq(15)
      expect(top.first[:comics][:available]).to eq(2939)
      expect(top.first[:name]).to eq("Spider-Man")
      expect(top.last[:comics][:available]).to eq(588)
      expect(top.last[:name]).to eq("Colossus")
    end
  end

  it "adds location details to character" do
    VCR.use_cassette("models/character_add_location") do
      characters = Character.new
      combined = characters.character_add_location({limit: 100, offset: 0 })

      expect(combined.count).to eq(15)
      expect(combined.first[:name]).to eq("Spider-Man")
      expect(combined.first[:location]).to eq("NYC")

      expect(combined.last[:name]).to eq("Colossus")
      expect(combined.last[:location]).to eq("Cleveland")
    end
  end
end
