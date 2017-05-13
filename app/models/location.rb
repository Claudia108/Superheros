class Location

  def cities
    {
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
  end

  def store_cities
    # finally, this works in redis-cli:
    # geoadd Cities -73.935242 40.730610 "NYC" -71.038887 42.364506 "Boston" -77.035507 38.894207 "DC"
    # georadius Cities -71.038887 42.364506 800 km withdist desc

    # implement:
    #
    # map over cities.length with index to do something like this:
    # $redis.GEOADD("Cities", cities[cities.keys[i]][1], cities[cities.keys[i]][0], cities.keys[i])

    # note: coordinates need to be switched (first long, then lat)
  end

  def close_by_cities
    # set variable for city: cities[cities.keys[n]][1]
    # georadius Cities -71.038887 42.364506 800 km withdist asc
  end
end
