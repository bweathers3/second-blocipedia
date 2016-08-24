require 'rails_helper'

RSpec.describe Wiki, type: :model do

  let(:user) { User.create!(name: "Mike", email: "Blocipedia@bloc.com", password: "password", password_confirmation: "password", confirmed_at: Date.today) }

  let(:wiki) { Wiki.create!(title: "New Wiki", body: 'Wiki Body', user: user) }

       it { is_expected.to belong_to(:user) }

       describe "attributes" do
         it "has a body attribute" do
           expect(wiki).to have_attributes(title: "New Wiki", body: "Wiki Body")
         end
       end



end
