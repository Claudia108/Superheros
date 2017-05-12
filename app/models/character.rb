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
    # transform locations in Array to pick by order
    cities = Location.new.cities.to_a
    # take character and add loation for that character.

    total_combos = top_characters(params).each_with_index.map do |character, i|
      combined = Hash.new
      combined[:hero] = character
      combined[:location] = cities[i]
      combined
    end
  end
end
