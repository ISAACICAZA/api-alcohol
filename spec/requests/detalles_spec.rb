require 'rails_helper'

RSpec.describe "ControladorControllers", type: :request do
  it "Probando metodos de controlador" do
    get "/detalles", params: {id_trago:"11007"}
    expect(response).to have_http_status(200)  
  end
end
