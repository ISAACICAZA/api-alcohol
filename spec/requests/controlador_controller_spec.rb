require 'rails_helper'

RSpec.describe "ControladorControllers", type: :request do
  it "Probando probando me copian" do
    get root_path
    expect(response).to have_http_status(200)
  end

  it "Probando metodos de controlador" do
    get "/cat", params: {categoria: "shake"}
    expect(response).to have_http_status(200)  
  end
end
