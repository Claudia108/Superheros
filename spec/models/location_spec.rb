require 'rails_helper'

describe Location do
  it "sorts characters by number of comics they appear in" do
    location = Location.new
    cities = location.cities

    expect(cities.count).to eq(15)
    expect(cities.class).to eq(Hash)
    expect(cities["NYC"]).to eq([40.73061, -73.935242])
    expect(cities[cities.keys.first]).to eq([40.73061, -73.935242])
    expect(cities["Boston"]).to eq([42.364506, -71.038887])
    expect(cities["Boston"].class).to eq(Array)
    expect(cities["Cleveland"]).to eq([41.505493, -81.68129])
    expect(cities[cities.keys.last]).to eq([41.505493, -81.68129])
  end
end
