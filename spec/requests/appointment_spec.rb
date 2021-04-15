require 'rails_helper'

RSpec.describe 'Appointments API' do
  # Initialize the test data
  let!(:consultancy) { create :consultancy }
  let!(:appointments) { create_list(:appointment, 20, consultancy_id: consultancy.id) }
  let!(:consultancy_id) { consultancy.id }
  let(:id) { appointments.first.id }

  # Test suite for GET /consultancies/:consultancy_id/appointments
  describe  'GET /consultancies/:consultancy_id/appointments'
    before { get "/consultancies/#{consultancy_id}/appointments"}

    context 'when consultancy exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all consultancy items' do
        expect(json_size).to eq(20)
      end
    end

    context 'when consultancy does not exist' do
      let(:consultancy_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find a Consultancy/)
      end
    end
  end

  # Test suite for GET /consultancies/:consultancy_id/appointments/:id
  describe 'GET /consultancies/:consultancy_id/appointments/:id' do
    before { get "/consultancies/#{consultancy_id}/appointments/#{id}"}

    context 'when an appointment exists' do
      it 'returns status code 200' do
        expect(response).to  have_http_status(200)
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
        expect(response.body).to match(/Couldn't find an appointment/)
      end
    end
  end

  # Test suite for PUT /consultancies/:consultancy_id/appointments
  describe 'PUT /consultancies/:consultancy_id/appointments' do
    let(:valid_attributes) { { problem: 'I hate my life', date: '13/02/2021', time: '13:30' } }

    context 'when request attributes are valid' do
      before { post "/consultancies/#{consultancy_id}/appointments", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/consultancies/#{consultancy_id}/appointments", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Problem can't be blank/)
      end
    end
  end

  # Test suite for PUT /consultancies/:consultancy_id/appointments/:id
  describe 'PUT /consultancies/:consultancy_id/appointments/:id' do
    let(:valid_attributes) { { problem: 'I hate my life' } }

    before { put "/consultancies/#{consultancy_id}/appointments/#{id}", params: valid_attributes }

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
        expect(response.body).to match(/Couldn't find an Appointment/)
      end
    end
  end

  # Test suite for DELETE /consultancies/:id
  describe 'DELETE /consultancies/:id' do
    before { delete "/consultancies/#{consultancy_id}/appointments/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
