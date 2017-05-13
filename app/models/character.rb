class Character < OpenStruct
  attr_reader :service

  def initialize
    @service = MarvelService.new
  end

  def sort_characters(params)
    @service.all_characters(params).sort_by { |character| character[:comics][:available] }.reverse
  end

  def top_characters(params)
    sort_characters(params)[0..14]
  end

  def character_add_location(params)
    cities = Location.new.city_coordinates.to_a
    total_combos = top_characters(params).each_with_index.map do |character, i|
      selected = character.slice(:name, :thumbnail, :comics)
      selected[:location] = cities[i][0]
      selected
    end
  end

  def cached_characters(params)
    characters =  $redis.get("characters")
    if characters.nil?
      characters = character_add_location(params).to_json
      $redis.set("characters", characters)
      # Expire the cache, every 3 hours
      $redis.expire("characters", 1.hour.to_i)
    end
    JSON.parse(characters, symbolize_names: true)
  end

  def characters_close_to_Boston(params)
    close_by_cities = Location.new.show_sorted_cities
    selected_characters = cached_characters(params).select { |character| close_by_cities.include?(character[:location]) }
    sort_selected_characters_by_distance(selected_characters, close_by_cities)
    # need to improve performance with redis db fetch
  end

  def sort_selected_characters_by_distance(selected_characters, close_by_cities)
    selected_characters.sort_by { |character| close_by_cities.index(character[:location])}
  end
end
