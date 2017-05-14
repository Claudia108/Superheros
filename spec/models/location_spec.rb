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

  it "shows only city names in array" do
    location = Location.new
    cities = location.show_sorted_cities

    expect(cities.count).to eq(4)
    expect(cities).to eq(["Boston", "NYC", "Baltimore", "DC"])
  end

  it "shows only formatted city distances in array" do
    location = Location.new
    cities = location.show_distance

    expect(cities.count).to eq(4)
    expect(cities).to eq([0, 188, 360, 395])
  end

  it "given user coordinates retrieves 5 closest cities in ascending order" do
    location = Location.new
    cities = location.close_to_user_locations({long: -73.935242, lat: 40.73061})

    expect(cities.count).to eq(5)
    expect(cities).to eq([["NYC", "0.0001"], ["Baltimore", "172.6775"], ["Boston", "187.5855"], ["DC", "207.8179"], ["Cleveland", "406.7096"]])
  end

  it "shows only city names in array for user's coordinates" do
    location = Location.new
    cities = location.show_sorted_cities_by_user({long: -73.935242, lat: 40.73061})

    expect(cities.count).to eq(5)
    expect(cities).to eq(["NYC", "Baltimore", "Boston", "DC", "Cleveland"])
  end

  it "shows only formatted city distances in array for user's coordinates" do
    location = Location.new
    cities = location.show_distance_to_user({long: -73.935242, lat: 40.73061})

    expect(cities.count).to eq(5)
    expect(cities).to eq([0, 173, 188, 208, 407])
  end
end
