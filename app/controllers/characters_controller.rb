class CharactersController < ApplicationController

  def index
    @characters = Character.new.top_characters(params)
    @boston_characters = Character.new.characters_close_to_Boston(params)
    @distances = Location.new.show_distance
  end
end
