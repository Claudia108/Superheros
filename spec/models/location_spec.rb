require 'rails_helper'

describe Location do
  it "lists cities with their coordinates" do
    location = Location.new
    cities = location.city_coordinates

    expect(cities.count).to eq(15)
    expect(cities.class).to eq(Hash)
    expect(cities["NYC"]).to eq([40.73061, -73.935242])
    expect(cities[cities.keys.first]).to eq([40.73061, -73.935242])
    expect(cities["Boston"]).to eq([42.364506, -71.038887])
    expect(cities["Boston"].class).to eq(Array)
    expect(cities["Cleveland"]).to eq([41.505493, -81.68129])
    expect(cities[cities.keys.last]).to eq([41.505493, -81.68129])
  end

  it "retrieves cities within 500 miles from Boston ascending by distance" do
    location = Location.new
    cities = location.five_hundred_miles_from_Boston

    expect(cities.count).to eq(4)
    expect(cities).to eq([["Boston", "0.0001"], ["NYC", "187.5856"], ["Baltimore", "360.0570"], ["DC", "395.3770"]])
  end
end
