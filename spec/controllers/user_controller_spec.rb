require 'rails_helper'

RSpec.describe UserController, type: :controller do

  let(:user) { User.create!(name: "Mike", email: "Blocipedia@bloc.com", password: "password", password_confirmation: "password", role: 1, confirmed_at: Date.today) }
  let(:my_wiki) { Wiki.create!(title: "New Wiki", body: 'Wiki Body', user: user, private: true, collaborator_email: "test@gmail.com", collaborator_drop: "test2@gmail.com") }


  before :each do
    sign_in user
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

end
