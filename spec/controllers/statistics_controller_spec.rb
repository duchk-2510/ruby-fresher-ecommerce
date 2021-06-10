require 'rails_helper'

RSpec.describe StatisticsController, type: :controller do
  let!(:admin){create :admin}
  before do 
    sign_in admin
  end

  describe "#show" do
    before {get :show}

    it {should render_template :show}
  end

  describe "#chart_data" do  
    it "returns http success when type :day" do
      get :chart_data, params: {type: :day, page: 1}
      expect(response).to have_http_status(:success)
    end

    it "returns http success when type :month" do
      get :chart_data, params: {type: :month, page: 1}
      expect(response).to have_http_status(:success)
    end

    it "returns http success when type :year" do
      get :chart_data, params: {type: :year, page: 1}
      expect(response).to have_http_status(:success)
    end
  end
end
