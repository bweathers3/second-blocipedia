
require 'stripe_mock'
require 'rails_helper'

describe 'Blocipedia Stripe test' do
  let(:stripe_helper) { StripeMock.create_test_helper }

  before { StripeMock.start }
  after { StripeMock.stop }

  it 'creates a stripe customer' do
    customer = Stripe::Customer.create({
      email: 'testemail@blocipedia.com',
      card: stripe_helper.generate_card_token
    })
    expect(customer.email).to eq('testemail@blocipedia.com')
  end

  it "creates a new stripe plan" do
    plan = stripe_helper.create_plan( :name => 'Default Plan', :currency => 'usd', :amount => 1500)
    expect(plan.name).to eq('Default Plan')
    expect(plan.currency).to eq('usd')
    expect(plan.amount).to eq(1500)
  end

  it "mocks a declined card error" do
  StripeMock.prepare_card_error(:card_declined)

  expect { Stripe::Charge.create(amount: 1, currency: 'usd') }.to raise_error {|e|
    expect(e).to be_a Stripe::CardError
    expect(e.http_status).to eq(402)
    expect(e.code).to eq('card_declined')
  }
end

end
