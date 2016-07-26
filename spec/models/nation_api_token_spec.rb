require 'rails_helper'

describe "A Nation API Token" do
  let(:token) { NationApiToken.new }

  it "must have a nation slug" do
    token.valid?

    expect(token.errors[:nation_slug]).to include("can't be blank")
  end

  it "must have a site slug" do
    token.valid?

    expect(token.errors[:nation_slug]).to include("can't be blank")
  end

  it "must have a token" do
    token.valid?

    expect(token.errors[:api_token]).to include("can't be blank")
  end

  it "must have a User" do
    token.valid?
    expect(token.errors[:user]).to include("can't be blank")
  end
end