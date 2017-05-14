require 'rails_helper'

describe CharactersController, type: :controller do
  context "characters#index" do
    it "gets index" do
      characters = Character.new.cached_characters({})
      boston_characters = Character.new.characters_close_to_Boston({})
      distances = Location.new.show_distance

      get :index

      expect(response.status).to eq(200)
      expect(assigns(:characters)).to eq(characters)
      expect(assigns(:boston_characters)).to eq(boston_characters)
      expect(assigns(:distances)).to eq(distances)
    end

    it "it renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
end
