require 'rails_helper'

describe Api::V1::CharactersController, type: :controller do
  scenario "character#create" do
    post :create, { location: {
                    long: "-81.681290",
                    lat: "41.505493"
                  }}

    result = JSON.parse(response.body)
    expect(result.count).to eq(2)
    expect(result[0].count).to eq(5)
    expect(result[1].count).to eq(5)

    expect(result[0][0]["name"]).to eq("Colossus")
    expect(result[0][0]["location"]).to eq("Cleveland")

    expect(result[0][4]["name"]).to eq("Wolverine")
    expect(result[0][4]["location"]).to eq("Chicago")

    expect(result[1][0]).to eq(0)
    expect(result[1][4]).to eq(308)
  end
end
