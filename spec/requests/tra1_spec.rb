require 'rails_helper'
RSpec.describe "Controlador", type: :request do
  describe "GET #tra1" do
    it "return http success" do
      get "/tra1"
      expect(response).to have_http_status(200)
    end
  end
end
