require 'rails_helper'

RSpec.describe 'Post Show Page', type: :feature do
  before do
    @user = User.create(name: 'John Doe', photo: 'https://example.com/john_doe.jpg')
    @user.save # Save the user to the database
    @post = @user.posts.create(title: 'Post Title', text: 'Lorem ipsum dolor sit amet...', comments_counter: 0, likes_counter: 0)
  end
  
  it 'displays the post title and author name' do
    visit user_post_path(@user, @post)

    expect(page).to have_content('"Post Title" by John Doe')
  end

  it 'displays the post text' do
    visit user_post_path(@user, @post)

    expect(page).to have_content('Lorem ipsum dolor sit amet...')
  end

  it 'displays the number of comments and likes for the post' do
    visit user_post_path(@user, @post)

    expect(page).to have_content('Comments: 0')
    expect(page).to have_content('Likes: 0')
  end

  it 'displays a form to like the post' do
    visit user_post_path(@user, @post)

    expect(page).to have_button('Like')
  end

  it 'redirects to the comment creation page when clicking on "Add Comment" link' do
    visit user_post_path(@user, @post)

    click_link 'Add Comment'

    expect(current_path).to eq(new_user_post_comment_path(@user, @post))
  end

  it 'displays comments with author name' do
    Comment.create(text: 'Comment 1', post: @post, author: @user)
    Comment.create(text: 'Comment 2', post: @post, author: @user)

    visit user_post_path(@user, @post)

    expect(page).to have_content('John Doe : Comment 1')
    expect(page).to have_content('John Doe : Comment 2')
  end

  it 'displays a message when there are no comments for the post' do
    visit user_post_path(@user, @post)

    expect(page).to have_content('No comments available yet!!!')
  end

  it 'redirects to the root page when clicking on "Back to all users" button' do
    visit user_post_path(@user, @post)

    click_button 'Back to all users'

    expect(current_path).to eq(root_path)
  end
end