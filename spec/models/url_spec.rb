require 'rails_helper'

RSpec.describe Url, type: :model do
  let(:item_with_key) do
    item = Url.new(original: Faker::Internet.url)
    item.send(:generate_key)
    item
  end

  it 'is not valid if original is not url' do
    url = Url.new(original: 'simple string')
    expect(url).not_to be_valid
    url.send(:generate_key)
    expect(url).not_to be_valid
    expect(item_with_key).to be_valid
  end

  it 'is not valid if key not uniq' do
    item_1 = Url.create(original: Faker::Internet.url)
    item_2 = Url.create(original: Faker::Internet.url)
    item_2.key = item_1.key
    expect(item_2).not_to be_valid
  end

  it 'is valid if key contains letters and digits only' do
    url = Url.create(original: Faker::Internet.url)
    url.key = '!@#[^'
    expect(url).not_to be_valid
  end
end
