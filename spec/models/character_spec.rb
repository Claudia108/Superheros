require 'rails_helper'

describe Character do
  it "sorts characters by number of comics they appear in" do
    VCR.use_cassette("models/sort_characters") do
      characters = Character.new
      sorted = characters.sort_characters

      expect(sorted.count).to eq(100)
      expect(sorted.first[:comics][:available]).to eq(1258)
      expect(sorted.first[:name]).to eq("Avengers")
      expect(sorted.last[:comics][:available]).to eq(0)
      expect(sorted.last[:name]).to eq("Aqueduct")
    end
  end

  it "picks top 15 characters by number of comics they appear in" do
    VCR.use_cassette("models/top_characters") do
      characters = Character.new
      top = characters.top_characters

      expect(top.count).to eq(15)
      expect(top.first[:comics][:available]).to eq(1258)
      expect(top.first[:name]).to eq("Avengers")
      expect(top.last[:comics][:available]).to eq(43)
      expect(top.last[:name]).to eq("Beast (Ultimate)")
    end
  end
end
