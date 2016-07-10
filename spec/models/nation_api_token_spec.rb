require 'rails_helper'

describe "A Nation API Token" do
  let(:token) { NationApiToken.new }

  it "has a nation slug" do
    token.valid?

    expect(token.errors[:nation_slug]).to include("can't be blank")
  end

  it "has a site slug" do
    token.valid?

    expect(token.errors[:nation_slug]).to include("can't be blank")
  end

  it "has a token" do
    token.valid?

    expect(token.errors[:api_token]).to include("can't be blank")
  end
end