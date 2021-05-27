require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "#index" do
    context "category is not exist" do
      before do
        get category_products_path(category_id: -1)
      end

      it "show flash danger" do
        expect(flash[:danger]).to eql(I18n.t "errors.unavailable_url")
      end

      it "redirect root" do
        expect(response).to redirect_to root_path(locale: 
                                  Rails.application.config.i18n.default_locale)
      end
    end

    it "render index when category is exist" do
      get category_products_path(category_id: create(:category).id)
      expect(response).to render_template :index
    end
  end

  describe "#show" do
    context "product is not exist" do
      before do
        get product_path(id: -1)
      end

      it "show flash danger" do
        expect(flash[:danger]).to eql(I18n.t "product.errors.not_exist")
      end

      it "redirect root" do
        expect(response).to redirect_to root_path(locale: 
                                  Rails.application.config.i18n.default_locale)
      end
    end

    it "render show when product is exist" do
      get product_path(id: create(:product))
      expect(response).to render_template :show
    end
  end

  describe "#other_in_category" do
    it "render other_in_category when category is exist" do
      get other_category_products_path(category_id: create(:category).id)
      expect(response).to render_template :other_in_category
    end
  end
end
