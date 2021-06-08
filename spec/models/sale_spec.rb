require 'rails_helper'

RSpec.describe Sale, type: :model do
  describe "associations" do
    it {should belong_to :product}
  end

  describe "delegate" do
    it {should delegate_method(:name).to(:product).with_prefix true}
  end
end
