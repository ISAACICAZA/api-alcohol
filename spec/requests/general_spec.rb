require 'rails_helper'

RSpec.describe "Generals", type: :request do

  context 'cuando la respuesta es 200' do
    before do
      allow_any_instance_of(Net::HTTP).to receive(:request).and_return(
        double(code: '200', body: '{"drinks": [{"name": "Margarita"}]}')
      )
      get '/search', params: { name: 'Margarita' }
    end

    it 'asigna @cocteles con los datos de la API' do
      expect(assigns(:cocteles)).to eq([{ 'name' => 'Margarita' }])
    end
  end

  context 'cuando la respuesta no es 200' do
    before do
      allow_any_instance_of(Net::HTTP).to receive(:request).and_return(
        double(code: '500', body: 'Error en la solicitud a la API')
      )
      get '/search', params: { nombre: 'Margarita' }
    end

    it 'configura el flash de error' do
      expect(flash[:error]).to eq('Ingrese un nombre de cóctel para buscar')
    end

    it 'asigna @cocteles como una matriz vacía' do
      expect(assigns(:cocteles)).to eq([])
    end
  end

  context 'cuando no se proporciona un nombre de cóctel' do
    before do
      get '/search', params: { nombre: '' }
    end

    it 'configura el flash de error' do
      expect(flash[:error]).to eq('Ingrese un nombre de cóctel para buscar')
    end

    it 'asigna @cocteles como una matriz vacía' do
      expect(assigns(:cocteles)).to eq([])
    end
  end
end
