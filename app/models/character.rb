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

  def character_add_location
    # transform locations in Array to pick by order
    # take character and add loation for that character.
    binding.pry
    cities = Location.new.cities.to_a
  end
end
