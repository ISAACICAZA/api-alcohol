require 'rails_helper'

RSpec.describe "ControladorControllers", type: :request do
it "Probando el buscador" do
  get root_path
  expect(response).to have_http_status(200)  
end
end
