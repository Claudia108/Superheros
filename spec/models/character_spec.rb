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

  it "finds characters close to Boston sorted asc" do
    VCR.use_cassette("models/characters_close_to_boston") do
      characters = Character.new
      close_by_characters = characters.characters_close_to_boston({limit: 100, offset: 0 })

      expect(close_by_characters.count).to eq(4)
      expect(close_by_characters.first[:name]).to eq("X-Men")
      expect(close_by_characters.first[:location]).to eq("Boston")

      expect(close_by_characters.last[:name]).to eq("Iron Man")
      expect(close_by_characters.last[:location]).to eq("DC")
    end
  end

  it "sorts selected characters by distance of their location to given city" do
    VCR.use_cassette("models/sort_selected_characters_by_distance") do
      characters = Character.new
      selected_characters = [{
                    :name     =>  "Iron Man",
                    :comics   =>  {:available=>2228},
                    :location =>  "DC"
                  },
                  { :name     => "Wolverine",
                    :comics   =>  {:available=>1983},
                    :location =>  "Chicago"
                  },
                  { :name     =>  "Storm",
                    :comics   =>  {:available=>676},
                    :location =>  "Baltimore"
                  }]
      locations = [ "Baltimore", "DC", "Chicago" ]

      sorted_characters = characters.sort_selected_characters_by_distance(selected_characters, locations)

      expect(sorted_characters.count).to eq(3)
      expect(sorted_characters.first[:name]).to eq("Storm")
      expect(sorted_characters.first[:location]).to eq("Baltimore")

      expect(sorted_characters.last[:name]).to eq("Wolverine")
      expect(sorted_characters.last[:location]).to eq("Chicago")
    end
  end

  it "finds 5 characters closest to user's coordinates sorted asc" do
    VCR.use_cassette("models/characters_close_to_user_location") do
      characters = Character.new
      close_by_characters = characters.characters_close_to_user_location({long: -73.935242, lat: 40.73061})

      expect(close_by_characters.count).to eq(2)
      expect(close_by_characters[0][0][:name]).to eq("X-Men")
      expect(close_by_characters[0][0][:location]).to eq("NYC")

      expect(close_by_characters[0][4][:name]).to eq("Iron Man")
      expect(close_by_characters[0][4][:location]).to eq("DC")

      expect(close_by_characters[1][0]).to eq(0)
      expect(close_by_characters[1][4]).to eq(34)
    end
  end
end
