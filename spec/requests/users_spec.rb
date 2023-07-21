require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET all users' do
    it 'checks whether it brings a successful response' do
      get '/users'
      expect(response).to be_successful
    end

    it 'renders the index template' do
      get '/users'
      expect(response).to render_template(:index)
    end

    it 'displays the body paragraph for users' do
      # Create users here if necessary
      get '/users'
      # expect(response).to have_http_status(200)
      expect(response.body).to include('Lugard')
      # expect(response.body).to include('index')
    end
    
  end

  describe 'GET specific user' do
    it 'checks whether it brings a successful response' do
      user = User.create!(name: 'Lugard', photo: 'www.unsplash.com', bio: 'text', posts_counter: 3)
      get user_path(user)
      expect(response).to be_successful
    end

    it 'renders the show template' do
      user = User.create!(name: 'Lugard', photo: 'www.unsplash.com', bio: 'text', posts_counter: 3)
      get user_path(user)
      expect(response).to render_template(:show)
    end

    it 'displays the body paragraph for specific user' do
      user = User.create!(name: 'Lugard', photo: 'www.unsplash.com', bio: 'text', posts_counter: 3)
      get user_path(user)
      expect(response.body).to include("Lugard")
    end
  end
end
