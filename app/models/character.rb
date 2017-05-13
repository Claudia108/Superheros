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
      selected = character.slice(:id, :name, :thumbnail, :comics)
      selected[:location] = cities[i][0]
      # $redis.hmset("characters:#{i + 1}", "id", selected[:id], "name", selected[:name], "thumbnail", selected[:thumbnail], "available_comics", selected[:comics][:available], "location", selected[:location])
      selected
    end
  end

  # def get_characters
    # another loop needed? or try MHGETALL from lua
    # $redis.mhvals("characters:#{i + 1}")
  # end


  def characters_close_to_Boston(params)
    close_by_cities = Location.new.fifty_miles_from_Boston.flatten
    character_add_location(params).select { |character| close_by_cities.include?(character[:location]) }
    # need to improve performance with redis db fetch
  end
end
