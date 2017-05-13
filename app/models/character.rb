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
    cities = Location.new.cities.to_a
    total_combos = top_characters(params).each_with_index.map do |character, i|
      # change to Array if I end up calling this for sorted display
      combined = Hash.new
      combined[:hero] = character
      # filter character attributes to keep (:id, :name, :comics[:available], maybe :thumbnail,...)
      combined[:location] = cities[i]
      # can remove coordinates from cities
      combined
      # store in redis?
    end
  end

  def characters_close_by
    # call Location.new.close_by_cities or just call redis in here
    # map result with character_add_location and pick character[:name] + distance (db cities array[i][1])
    # send to view
  end

end
