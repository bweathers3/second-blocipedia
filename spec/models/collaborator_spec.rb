require 'rails_helper'

RSpec.describe Collaborator, type: :model do

    let(:user) { create(:user) }
    let(:wiki) { create(:wiki) }
    let(:collaborator) { Collaborator.create(user: user, wiki: wiki) }

    it { is_expected.to belong_to(:wiki) }
    it { is_expected.to belong_to(:user) }

    describe "attributes" do
      it "has user and wiki attribute" do
        expect(collaborator).to have_attributes(user_id: user.id, wiki_id: wiki.id)
      end
    end


end
