require 'rails_helper'

RSpec.describe BlogsController, type: :controller do
  let(:user) { create(:user) }
  
  before do
    token = JsonWebToken.encode(user_id: user.id)
    request.headers['Authorization'] = "Bearer #{token}"
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

  end

  describe 'POST #create' do
    let(:valid_attributes) { { title: 'Test Blog', content: 'This is a test blog.', author: 'John Doe' } }

    context 'with valid params' do
      it 'creates a new blog' do
        expect {
          post :create, params: { blog: valid_attributes }
        }.to change(Blog, :count).by(1)
      end

      it 'returns a created response' do
        post :create, params: { blog: valid_attributes }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'returns an unprocessable entity response' do
        post :create, params: { blog: { title: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    let(:blog) { create(:blog) }

    context 'with valid params' do
      it 'updates the requested blog' do
        put :update, params: { id: blog.to_param, blog: { title: 'Updated Title' } }
        blog.reload
        expect(blog.title).to eq('Updated Title')
      end

      it 'returns a success response' do
        put :update, params: { id: blog.to_param, blog: { title: 'Updated Title' } }
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      it 'returns a not found response' do
        put :update, params: { id: 'invalid_id', blog: { title: 'Updated Title' } }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:blog) { create(:blog) }

    it 'destroys the requested blog' do
      blog # Create the blog
      expect {
        delete :destroy, params: { id: blog.to_param }
      }.to change(Blog, :count).by(-1)
    end

    it 'returns a no content response' do
      delete :destroy, params: { id: blog.to_param }
      expect(response).to have_http_status(:no_content)
    end

    context 'with invalid params' do
      it 'returns a not found response' do
        delete :destroy, params: { id: 'invalid_id' }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
