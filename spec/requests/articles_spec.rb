require 'rails_helper'

RSpec.describe 'Article API', type: :request do
  # initialize test data
  let(:user) { create(:user) }
  let!(:articles) { create_list(:article, 10) }
  let(:article_id) { articles.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /articles
  describe 'GET /articles' do
    before { get '/articles', params: {}, headers: headers }

    it 'returns articles' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /articles/:id
  describe 'GET /articles/:id' do
    before { get "/articles/#{article_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the article' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(article_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:article_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Article/)
      end
    end
  end

  # Test suite for POST /articles
  describe 'POST /articles' do
    let(:valid_attributes) do
      {
        title: 'Andela Darling',
        slug: 'andela',
        body: "I will be glad to work for Andela",
        description: 'desires',
        favorites_count: 1,
        user_id: 1
      }.to_json
    end

    context 'when the request is valid' do
      before { post '/articles', params: valid_attributes, headers: headers }

      it 'creates an article' do
        expect(json['title']).to eq('Andela Darling')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { title: nil }.to_json }
      before { post '/articles', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  # Test suite for PUT /articles/:id
  describe 'PUT /articles/:id' do
    let(:valid_attributes) { { title: 'Shopping' }.to_json }

    context 'when the record exists' do
      before { put "/articles/#{article_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /articles/:id
  describe 'DELETE /articles/:id' do
    before { delete "/articles/#{article_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end