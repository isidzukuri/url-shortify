require 'rails_helper'

RSpec.feature 'Url cycle', type: :feature do
  scenario 'User create new url' do
    visit root_path
    original = Faker::Internet.url
    fill_in 'url_original', with: original
    click_button 'short now'
    item = Url.last
    expect(item.original).to eq original
    expect(current_path).to eq url_path(item.key)
    expect(find('.has-success input').value).to have_text("/#{item.key}")
  end

  scenario 'User enters not valid url' do
    visit root_path
    original = 'dummy str'
    fill_in 'url_original', with: original
    click_button 'short now'
    expect(current_path).to eq urls_path
    expect(page).to have_text('Original is invalid')
  end
end
