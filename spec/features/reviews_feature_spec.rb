require 'rails_helper'
feature 'reviewing' do
  
  before do
    visit '/'
    click_link 'Sign up'
    fill_in 'Email', with: 'dan.blakeman@oxen.com'
    fill_in 'Password', with: 'five_oxes'
    fill_in 'Password confirmation', with: 'five_oxes'
    click_button 'Sign up'
  end

  before do
    user = User.where(email: 'dan.blakeman@oxen.com').last
    restaurant = Restaurant.create(name: 'KFC', user_id: user.id)
  end

  

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'So so'
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq('/restaurants')
    expect(page).to have_content('So so')
  end

  scenario 'deleting restaurants deletes the reviews' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'So so'
    select '3', from: 'Rating'
    click_button 'Leave Review'
    click_link 'Delete KFC'
    expect(Review.all.length).to be(0)
  end
end
