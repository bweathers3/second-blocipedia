require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { User.create!(name: "Mike", email: "Blocipedia@bloc.com", password: "password", password_confirmation: "password", confirmed_at: Date.today, role: 0) }
  #let(:user) { create!(:user) }

  it { is_expected.to have_many(:wikis) }

     describe "attributes" do
       it "has name and email attributes" do
         expect(user).to have_attributes(name: user.name, email: user.email)
       end

       it "responds to standard?" do
           expect(user).to respond_to(:standard?)
       end

       it "responds to premium?" do
           expect(user).to respond_to(:premium?)
       end

       it "responds to admin?" do
           expect(user).to respond_to(:admin?)
       end
    end

       describe "roles" do
         it "is standard by default" do
           expect(user.role).to eq("standard")
         end
       end

      context "standard user" do
           it "returns true for #standard?" do
             expect(user.standard?).to be_truthy
           end

           it "returns false for #premium?" do
             expect(user.premium?).to be_falsey
           end

           it "returns false for #admin?" do
             expect(user.admin?).to be_falsey
           end
      end

      context "premium user" do
            before do
              user.premium!
            end

           it "returns false for #standard?" do
             expect(user.standard?).to be_falsey
           end

           it "returns true for #premium?" do
             expect(user.premium?).to be_truthy
           end

           it "returns false for #admin?" do
             expect(user.admin?).to be_falsey
           end
      end

         context "admin user" do
           before do
             user.admin!
           end

           it "returns false for #standard?" do
             expect(user.standard?).to be_falsey
           end

           it "returns false for #premium?" do
             expect(user.premium?).to be_falsey
           end

           it "returns true for #admin?" do
             expect(user.admin?).to be_truthy
           end
         end

end
