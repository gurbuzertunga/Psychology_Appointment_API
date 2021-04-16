require 'rails_helper'
RSpec.describe 'Appointments API', type: :request do
  # Initialize the test data
  let!(:consultancy) { create(:consultancy) }
  let!(:consultancy_id) { consultancy.id }
  let!(:appointments) { create_list(:appointment, 20, consultancy_id: consultancy.id) }
  let(:id) { appointments.first.id }
  #   # Test suite for GET /appointments
  describe 'GET /appointments' do
    before { get '/appointments' }
    context 'when consultancy exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'returns all consultancy items' do
        expect(json.size).to eq(20)
      end
    end
  end
  context 'when consultancy does not exist' do
    let(:consultancy_id) { 99_999 }
    before { get "/appointments/#{consultancy_id}" }
    it 'returns status code 404' do
      expect(response).to have_http_status(404)
    end
    it 'returns a not found message' do
      expect(response.body).to match(/Couldn't find Appointment/)
    end
  end
  #
  # Test suite for GET /consultancies/:consultancy_id/appointments/:id
  describe 'GET /appointments/:id' do
    before { get "/appointments/#{id}" }
    context 'when an appointment exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
      it 'returns the appointment' do
        expect(json[id]).to eq(id)
      end
    end
    context 'when an appointment does not exist' do
      let(:id) { 0 }
      it 'returns a status code 404' do
        expect(response).to have_http_status(404)
      end
      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Appointment/)
      end
    end
  end
  # Test suite for PUT /consultancies/:consultancy_id/appointments
  describe 'PUT /appointments' do
    let(:valid_attributes) { { problem: 'I hate my life', date: '13/02/2021', time: '13:30' } }
    context 'when request attributes are valid' do
      before { post '/appointments', params: valid_attributes }
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
    context 'when an invalid request' do
      before { post '/appointments', params: {} }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Consultancy must exist/)
      end
    end
  end
  #
  # Test suite for PUT /consultancies/:consultancy_id/appointments/:id
  describe 'PUT /appointments/:id' do
    let(:valid_attributes) { { problem: 'I hate my life' } }
    before { put "/appointments/#{id}", params: valid_attributes }
    context 'when appointment exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
      it 'updates the appointment' do
        updated_appointment = Appointment.find(id)
        expect(updated_appointment.problem).to match(/I hate my life/)
      end
    end
    context 'when the appointment does not exist' do
      let(:id) { 0 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Appointment/)
      end
    end
  end
  #
  # Test suite for DELETE /consultancies/:id
  describe 'DELETE /appointments/:id' do
    before { delete "/appointments/#{id}" }
    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end