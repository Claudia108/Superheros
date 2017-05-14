class CharactersController < ApplicationController

  def index
    @characters = Character.new.cached_characters(params)
    @boston_characters = Character.new.characters_close_to_boston(params)
    @distances = Location.new.show_distance
  end
end
