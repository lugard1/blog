require 'rails_helper'

RSpec.describe 'User Index Page', type: :feature do
  before do
    @user1 = User.create(name: 'Mucha', posts_counter: 0)
    @user2 = User.create(name: 'Jeddah', posts_counter: 0)

    @user1.update(photo: 'https://unsplash.com/photos/F_-0BxGuVvo')
    @user2.update(photo: 'https://unsplash.com/es/fotos/mEZ3PoFGs_k')
  end

  it 'displays the username of all other users' do
    visit users_path

    expect(page).to have_content('Mucha')
    expect(page).to have_content('Jeddah')
  end

  it 'displays the profile picture for each user' do
    visit users_path

    expect(page).to have_css('.user-image')
    expect(page).to have_css('.user-image')
  end

  it 'displays the number of posts each user has written' do
    visit users_path

    expect(page).to have_content("Number of posts: #{@user1.posts_counter}")
    expect(page).to have_content("Number of posts: #{@user2.posts_counter}")
  end

  it 'redirects to the user show page when clicking on a user' do
    visit users_path

    first(:link, @user1.name).click

    expect(current_path).to eq(current_path)
    expect(page).to have_content(@user1.name)
  end
end












