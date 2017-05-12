class CharactersController < ApplicationController

  def index
    @characters = Character.new.top_characters(params)
  end
end
