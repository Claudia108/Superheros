require 'rails_helper'

describe Character do
  it "sorts characters by number of comics they appear in" do
    VCR.use_cassette("models/sort_characters") do
      characters = Character.new
      sorted = characters.sort_characters({})

      expect(sorted.count).to eq(100)
      expect(sorted.first[:comics][:available]).to eq(1258)
      expect(sorted.last[:comics][:available]).to eq(0)
    end
  end
end
