class Character < OpenStruct
  attr_reader :service

  def initialize
    @service = MarvelService.new
  end

  def sort_characters
    @service.characters.sort_by { |character| character[:comics][:available] }.reverse
  end

  def top_characters
    sort_characters[0..14]
  end
end
