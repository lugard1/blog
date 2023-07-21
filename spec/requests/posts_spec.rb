require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET all posts for the user' do
    it 'checks whether it brings successful response' do
      user = User.create!(name: 'Lugard', photo: 'www.unsplash.com', bio: 'Test', posts_counter: 3)
      get user_posts_path(user_id: user.id)
      expect(response).to be_successful
    end

    it 'renders the index template' do
      user = User.create!(name: 'Lugard', photo: 'www.unsplash.com', bio: 'Test', posts_counter: 3)
      get user_posts_path(user_id: user.id)
      expect(response).to render_template(:index)
    end

    it 'displays the body paragraph for users' do
      user = User.create!(name: 'Lugard', photo: 'www.unsplash.com', bio: 'Test', posts_counter: 3)
      get user_posts_path(user_id: user.id)
      expect(response.body).to include('Lugard') # Change this to match the user's name or other relevant content
    end
  end

  describe 'GET specific post for the user' do
    it 'checks whether it brings successful response' do
      user = User.create!(name: 'Lugard', photo: 'www.unsplash.com', bio: 'Test', posts_counter: 3)
      post = Post.create!(title: 'Test Post', author_id: user.id, comments_counter: 3, likes_counter: 5)
      get user_post_path(user_id: user.id, id: post.id)
      expect(response).to be_successful
    end

    it 'renders the show template' do
      user = User.create!(name: 'Lugard', photo: 'www.unsplash.com', bio: 'Test', posts_counter: 3)
      post = Post.create!(title: 'Test Post', author_id: user.id, comments_counter: 3, likes_counter: 5)
      get user_post_path(user_id: user.id, id: post.id)
      expect(response).to render_template(:show)
    end

    it 'displays the body paragraph for users' do
      user = User.create!(name: 'Lugard', photo: 'www.unsplash.com', bio: 'Test', posts_counter: 3)
      post = Post.create!(title: 'Test Post', author_id: user.id, comments_counter: 3, likes_counter: 5)
      get user_post_path(user_id: user.id, id: post.id)
      expect(response.body).to include("Post # #{post.id} by #{user.name}") # Change this to match the relevant content
    end
  end
end
