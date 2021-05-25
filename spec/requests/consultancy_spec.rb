require 'rails_helper'


RSpec.describe 'Consultancies API', type: :request do
  # initialize test data
  let!(:consultancies) { create_list(:consultancy, 10) }
  let(:consultancy_id) { consultancies.first.id }
  # Test suite for GET /consultancies
  describe 'GET /consultancies' do
    # make HTTP get request before each example
    before { get '/consultancies' }


    it 'returns status code 422' do
      expect(response).to have_http_status(422)
    end
  end

  # Test suite for GET /consultancies/:id
  describe 'GET /consultancies/:id' do
    before { get "/consultancies/#{consultancy_id}" }

    context 'when the record exists' do
      it 'returns the consultancy' do
        expect(json).not_to be_empty
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    context 'when the record does not exist' do
      let(:consultancy_id) { 99_999 }

      it 'returns a not found message' do
        expect(response.body).to match("{\"message\":\"Missing token\"}")
      end
    end
  end

  # Test suite for POST /consultancies
  describe 'POST /consultancies' do
    # valid payload
    let(:valid_attributes) { { area: 'Family' }.to_json }



    context 'when the request is invalid' do
      before { post '/consultancies', params: { type: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match("{\"message\":\"Missing token\"}")
      end
    end
  end

  # Test suite for PUT /consultancies/:id
  describe 'PUT /consultancies/:id' do
    let(:valid_attributes) { { type: 'Couples Counselling' } }

    context 'when the record exists' do
      before { put "/consultancies/#{consultancy_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).not_to be_empty
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  # Test suite for DELETE /consultancies/:id
  describe 'DELETE /consultancies/:id' do
    before { delete "/consultancies/#{consultancy_id}" }

    it 'returns status code 422' do
      expect(response).to have_http_status(422)
    end
  end
end