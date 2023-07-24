require 'rails_helper'

RSpec.describe 'Single Post View', type: :feature do
  before(:each) do
    @user = User.create!(name: 'John Doe', photo: 'user_photo.jpg')
    @post1 = @user.posts.create!(text: 'This is post 1.') 
    @post2 = @user.posts.create!(text: 'This is post 2.')
    @comment1 = @post1.comments.create!(author: @user, text: 'Comment 1 for post 1')
  end

  it 'displays user information' do
    visit user_post_path(@user, @post1)
    expect(page).to have_content(@user.name)
    expect(page).to have_selector('img.user-image[src="user_photo.jpg"]')
    expect(page).to have_content("Number of posts: #{User.posts_counter}")
  end

  it 'displays posts information' do
    visit user_post_path(@user, @post1)
    expect(page).to have_content('Post: #')
    expect(page).to have_content(@post1.text)
    expect(page).to have_content("Comments: #{Post.comments_counter}, Likes: #{Post.likes_counter}")
  end

  it 'displays comments for the post' do
    visit user_post_path(@user, @post1)
    expect(page).to have_content(@comment1.author.name)
    expect(page).to have_content(@comment1.text)
  end

  it 'displays message if there are no posts' do
    @user.posts.delete_all
    visit user_post_path(@user, @post1)
    expect(page).to have_content('There are no posts. Please add a post.')
  end

  it 'displays pagination button' do
    visit user_post_path(@user, @post1)
    expect(page).to have_link('Pagination')
  end
end
