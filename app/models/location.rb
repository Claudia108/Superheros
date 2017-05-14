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
    # note: coordinates need to be switched to first enter long, then lat
    cities.map do |city|
      $redis.GEOADD("cities", city[1][1], city[1][0], city[0])
    end
  end

  def close_to_user_locations(params)
    longest_distance = 15000
    units = "mi"
    $redis.GEORADIUS("cities", params[:long], params[:lat], longest_distance, units, "WITHDIST", "ASC")
  end

  def five_hundred_miles_from_Boston
    long = city_coordinates["Boston"][1]
    lat = city_coordinates["Boston"][0]
    radius = 500
    units = "mi"
    $redis.GEORADIUS("cities", long, lat, radius, units, "WITHDIST", "ASC")
  end


  def show_distance
    five_hundred_miles_from_Boston.map do |city|
      city[1].to_f.round(0)
    end
  end

  def show_sorted_cities
    five_hundred_miles_from_Boston.map do |city|
      city[0]
    end
  end

  def show_sorted_cities_by_user(params)
    close_to_user_locations(params).map do |city|
      city[0]
    end
  end

end
