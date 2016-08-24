require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { User.create!(name: "Mike", email: "Blocipedia@bloc.com", password: "password", password_confirmation: "password", confirmed_at: Date.today) }
  #let(:user) { create!(:user) }

  it { is_expected.to have_many(:wikis) }

     describe "attributes" do
       it "has name and email attributes" do
         expect(user).to have_attributes(name: user.name, email: user.email)
       end
     end


end
