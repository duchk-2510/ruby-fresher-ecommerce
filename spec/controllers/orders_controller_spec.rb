require 'rails_helper'
include SessionsHelper

RSpec.describe OrdersController, type: :controller do
  # describe "#index" do
  #   context "when user is not logged in" do
  #     before do
  #       log_out
  #       get :index
  #     end

  #     it {should set_flash[:warning].to(I18n.t :have_to_login)}
  #     it {should redirect_to(root_path)}
  #   end

  #   it "render orders when user logged in" do
  #     log_in create(:customer)
  #     get :index
  #     expect(response).to render_template :index
  #   end
  # end
  let!(:user){FactoryBot.create :customer}
  let!(:order){FactoryBot.create order, user_id: user.id}
  describe "#show" do
    before(:each) do |test|
      request.session[:user_id] = user.id
      byebug
      get order_path(id: order.id)
    end
    context "when user is not permitted" do
      # it {should set_flash[:warning].to(I18n.t :have_to_login)}
      it {should redirect_to(root_path)}
    end
  end
end
