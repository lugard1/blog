require 'rails_helper'

RSpec.feature 'User Post Index Page', type: :feature, js: true do
  let(:user) { create(:user) }
  let!(:post1) { create(:post, user: user) }
  let!(:post2) { create(:post, user: user) }

  before do
    visit user_posts_path(user)
  end

  It 'displays user profile picture, username, and number of posts' do
    expect(page).to have_css('.user-photo img')
    expect(page).to have_content(user.name)
    expect(page).to have_content("Number of posts: #{user.posts_counter}")
  end

  It 'displays each post with title, body, comments, likes' do
    within '.single-post:first-child' do
      expect(page).to have_content("Post: # #{post1.id}")
      expect(page).to have_content(post1.text)
      expect(page).to have_content("Comments: #{post1.comments_counter}, Likes: #{post1.likes_counter}")
    end

    within '.single-post:last-child' do
      expect(page).to have_content("Post: # #{post2.id}")
      expect(page).to have_content(post2.text)
      expect(page).to have_content("Comments: #{post2.comments_counter}, Likes: #{post2.likes_counter}")
    end
  end

  It 'displays the first comment of each post' do
    within '.single-post:first-child .comments' do
      expect(page).to have_content(post1.last_comments.first.author.name)
      expect(page).to have_content(post1.last_comments.first.text)
    end

    within '.single-post:last-child .comments' do
      expect(page).to have_content(post2.last_comments.first.author.name)
      expect(page).to have_content(post2.last_comments.first.text)
    end
  end

  It 'displays how many comments each post has' do
    within '.single-post:first-child .counter' do
      expect(page).to have_content("Comments: #{post1.comments_counter}")
    end

    within '.single-post:last-child .counter' do
      expect(page).to have_content("Comments: #{post2.comments_counter}")
    end
  end

  It 'displays how many likes each post has' do
    within '.single-post:first-child .counter' do
      expect(page).to have_content("Likes: #{post1.likes_counter}")
    end

    within '.single-post:last-child .counter' do
      expect(page).to have_content("Likes: #{post2.likes_counter}")
    end
  end

  It 'displays a message when there are no posts' do
    user.posts.destroy_all
    visit user_posts_path(user)

    expect(page).to have_content('There are no posts. Please add a post.')
  end

  It 'redirects to post show page when clicking on a post' do
    click_link "Post: # #{post1.id}"
    expect(page).to have_current_path(user_post_path(user, post1))
  end
end
