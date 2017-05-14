class Location

  def city_coordinates
    cities = {
              "NYC" => [40.730610, -73.935242],
              "Boston" => [42.364506, -71.038887],
              "DC" => [38.894207, -77.035507],
              "Chicago" => [41.881832, -87.623177],
              "Indianapolis" => [39.832081, -86.145454],
              "LA" => [34.052235, -118.243683],
              "SF" => [37.733795, -122.446747],
              "Dallas" => [32.897480, -97.040443],
              "Denver" => [39.742043, -104.991531],
              "Seattle" => [47.608013, -122.335167],
              "New Orleans" => [29.951065, -90.071533],
              "Orlando" => [28.538336, -81.379234],
              "Baltimore" => [39.299236, -76.609383],
              "Minneapolis" => [44.986656, -93.258133],
              "Cleveland" => [41.505493, -81.681290]
    }
    store_cities(cities)
    cities
  end

  def store_cities(cities)
    # note: given city coordinates display lat, long - switched for GEOADD
    cities.map do |city|
      $redis.GEOADD("cities", city[1][1], city[1][0], city[0])
    end
  end

  def calculate_radius(long, lat, radius)
    $redis.GEORADIUS("cities", long, lat, radius, "mi", "WITHDIST", "ASC")
  end

  def five_hundred_miles_from_Boston
    calculate_radius(city_coordinates["Boston"][0], city_coordinates["Boston"][0], 500)
  end

  def show_sorted_cities
    five_hundred_miles_from_Boston.map do |city|
      city[0]
    end
  end

  def show_distance
    five_hundred_miles_from_Boston.map do |city|
      city[1].to_f.round(0)
    end
  end

  def close_to_user_locations(params)
    calculate_radius(params[:long], params[:lat], 15000)
  end

  def show_sorted_cities_by_user(params)
    close_to_user_locations(params).map do |city|
      city[0]
    end
  end

  def show_distance_to_user(params)
    locations = close_to_user_locations(params).map do |city|
      city[1].to_f.round(0)
    end
    locations[0..4]
  end
end
