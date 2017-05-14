class Api::V1::CharactersController < Api::V1::ApiController

  def create
    render json: Character.new.characters_close_to_user_location(location_params) and return
  end

  private

  def location_params
    params.require(:location).permit(:long, :lat)
  end
end
