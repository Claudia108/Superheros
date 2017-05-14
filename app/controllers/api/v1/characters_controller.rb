class Api::V1::CharactersController < Api::ApiController

  def create
    render json: Location.store_user_locations(location_params)
  end

  private

  def location_params
    params.require(:location).permit(:long, :lat)
  end
end
