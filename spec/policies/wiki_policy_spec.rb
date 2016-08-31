
require 'rails_helper'

RSpec.describe WikiPolicy, type: :policy do

  let(:user) { User.create!(name: "Mike", email: "Blocipedia@bloc.com", password: "password", password_confirmation: "password", confirmed_at: Date.today, role: "standard") }

  let(:my_wiki) { Wiki.create!(title: "New Wiki", body: 'Wiki Body', user: user) }


  #before :each do
    #sign_in user
  #end


  permissions :index? do

    it "blocks non signed in users" do
      get :index
      expect(response).not_to permit(nil, my_wiki)
    end

    it "allows standard user to view wikis" do
       #assign_role!(user, :standard, my_wiki)
       user.update_attributes(role: :standard)
       get :index
       expect(response).to permit(user, my_wiki)
    end


  end
end
