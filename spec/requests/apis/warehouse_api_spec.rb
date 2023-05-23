require 'rails_helper'

describe 'Warehouse API' do
  context 'GET /api/v1/warehouses/:id' do
    it 'is successful' do
      warehouse = Warehouse.create!(
        name: 'Galpão Rio', description: 'Galpão do Rio de Janeiro', code: 'SDU',
        address: 'Avenida do Museu do Amanhã, 1000', city: 'Rio de Janeiro', cep: '20100-000',
        area: 60_000
      )

      get "/api/v1/warehouses/#{warehouse.id}"

      expect(response).to have_http_status 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['name']).to eq 'Galpão Rio'
      expect(json_response['code']).to eq 'SDU'
      expect(json_response['description']).to eq 'Galpão do Rio de Janeiro'
      expect(json_response['cep']).to eq '20100-000'
      expect(json_response['city']).to eq 'Rio de Janeiro'
      expect(json_response['address']).to eq 'Avenida do Museu do Amanhã, 1000'
      expect(json_response['area']).to eq 60_000
      expect(json_response.keys).not_to include 'created_at'
      expect(json_response.keys).not_to include 'updated_at'
    end

    it 'fails with non existing id' do
      get "/api/v1/warehouses/10000"

      expect(response).to have_http_status 404
    end

    it 'fails when there is an internal error' do
      warehouse = Warehouse.create!(
        name: 'Galpão Rio', description: 'Galpão do Rio de Janeiro', code: 'SDU',
        address: 'Avenida do Museu do Amanhã, 1000', city: 'Rio de Janeiro', cep: '20100-000',
        area: 60_000
      )
      allow(Warehouse).to receive(:find).and_raise(ActiveRecord::ActiveRecordError)

      get "/api/v1/warehouses/#{warehouse.id}"

      expect(response).to have_http_status 500
    end
  end

  context 'GET /api/v1/warehouses' do
    it 'is successful' do
      warehouse_a = Warehouse.create!(
        name: 'Galpão Rio', description: 'Galpão do Rio de Janeiro', code: 'SDU',
        address: 'Avenida do Museu do Amanhã, 1000', city: 'Rio de Janeiro', cep: '20100-000',
        area: 60_000
      )
      warehouse_b = Warehouse.create!(
        name: 'Galpão Maceio', description: 'Galpão de cidade de Maceio', code: 'MCZ',
        address: 'Avenida Atlantica, 50', city: 'Maceio', cep: '80000-000',
        area: 50_000
      )

      get "/api/v1/warehouses"

      expect(response).to have_http_status 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq 2
      expect(json_response[0]['name']).to eq 'Galpão Rio'
      expect(json_response[1]['name']).to eq 'Galpão Maceio'
    end

    it 'returns an empty array when there are no warehouses' do
      get "/api/v1/warehouses"

      expect(response).to have_http_status 200
      json_response = JSON.parse(response.body)
      expect(json_response).to be_empty
    end

    it 'fails when there is an internal error' do
      warehouse = Warehouse.create!(
        name: 'Galpão Rio', description: 'Galpão do Rio de Janeiro', code: 'SDU',
        address: 'Avenida do Museu do Amanhã, 1000', city: 'Rio de Janeiro', cep: '20100-000',
        area: 60_000
      )
      allow(Warehouse).to receive(:all).and_raise(ActiveRecord::ActiveRecordError)

      get "/api/v1/warehouses"

      expect(response).to have_http_status 500
    end
  end

  context 'POST /api/v1/warehouses' do
    it 'is successful' do
      warehouse_params = { warehouse: {
        name: 'Galpão Rio', description: 'Galpão do Rio de Janeiro', code: 'SDU',
        address: 'Avenida do Museu do Amanhã, 1000', city: 'Rio de Janeiro', cep: '20100-000',
        area: 60_000
      } }
  
      post '/api/v1/warehouses', params: warehouse_params
  
      expect(response).to have_http_status 201
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['name']).to eq 'Galpão Rio'
      expect(json_response['code']).to eq 'SDU'
      expect(json_response['description']).to eq 'Galpão do Rio de Janeiro'
      expect(json_response['cep']).to eq '20100-000'
      expect(json_response['city']).to eq 'Rio de Janeiro'
      expect(json_response['address']).to eq 'Avenida do Museu do Amanhã, 1000'
      expect(json_response['area']).to eq 60_000
      expect(json_response.keys).not_to include 'created_at'
      expect(json_response.keys).not_to include 'updated_at'
    end

    it 'fails with invalid data' do
      warehouse_params = { warehouse: {
        name: 'Galpão Rio', code: 'SDU'
      } }
  
      post '/api/v1/warehouses', params: warehouse_params
  
      expect(response).to have_http_status 412
      expect(response.content_type).to include 'application/json'
      expect(response.body).to include 'Descrição não pode ficar em branco'
      expect(response.body).to include 'CEP não pode ficar em branco'
      expect(response.body).to include 'Cidade não pode ficar em branco'
      expect(response.body).to include 'Endereço não pode ficar em branco'
      expect(response.body).to include 'Área não pode ficar em branco'
      expect(response.body).not_to include 'Nome não pode ficar em branco'
      expect(response.body).not_to include 'Código não pode ficar em branco'
    end

    it 'fails when there is an internal error' do
      warehouse_params = { warehouse: {
        name: 'Galpão Rio', description: 'Galpão do Rio de Janeiro', code: 'SDU',
        address: 'Avenida do Museu do Amanhã, 1000', city: 'Rio de Janeiro', cep: '20100-000',
        area: 60_000
      } }
      allow(Warehouse).to receive(:create).and_raise(ActiveRecord::ActiveRecordError)
  
      post '/api/v1/warehouses', params: warehouse_params
    end
  end
end
