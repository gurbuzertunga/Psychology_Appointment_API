# spec/requests/consultancies_spec.rb
require 'rails_helper'

RSpec.describe 'Consultancies API', type: :request do
  # initialize test data
  let!(:consultancies) { create_list(:consultancy, 10) }
  let(:consultancy_id) { consultancies.first.id }

  # Test suite for GET /consultancies
  describe 'GET /consultancies' do
    # make HTTP get request before each example
    before { get '/consultancies' }

    it 'returns consultancies' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /consultancies/:id
  describe 'GET /consultancies/:id' do
    before { get "/consultancies/#{consultancy_id}" }

    context 'when the record exists' do
      it 'returns the consultancy' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(consultancy_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:consultancy_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Consultancy/)
      end
    end
  end

  # Test suite for POST /consultancies
  describe 'POST /consultancies' do
    # valid payload
    let(:valid_attributes) { { type: 'Couples Counselling', area: 'Family' } }

    context 'when the request is valid' do
      before { post '/consultancies', params: valid_attributes }

      it 'creates a consultancy' do
        expect(json['type']).to eq('Couples Counselling')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/consultancies', params: { type: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Area by can't be blank/)
      end
    end
  end

  # Test suite for PUT /consultancies/:id
  describe 'PUT /consultancies/:id' do
    let(:valid_attributes) { { type: 'Couples Counselling' } }

    context 'when the record exists' do
      before { put "/consultancies/#{consultancy_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /consultancies/:id
  describe 'DELETE /consultancies/:id' do
    before { delete "/consultancies/#{consultancy_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end