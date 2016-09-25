require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do

  let(:user) { User.create!(name: "Mike", email: "Blocipedia@bloc.com", password: "password", password_confirmation: "password", role: 2, confirmed_at: Date.today) }

  before :each do
    sign_in user
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #about" do
    it "returns http success" do
      get :about
      expect(response).to have_http_status(:success)
    end
  end

end
