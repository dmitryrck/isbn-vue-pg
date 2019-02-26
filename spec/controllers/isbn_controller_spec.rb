require "rails_helper"

describe IsbnController do
  describe "POST create" do
    let(:json_response) { JSON.parse(response.body) }

    context "when request is valid" do
      before do
        post :create, params: { isbn: "1234567890123" }
      end

      it "should return 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "should return the http error code" do
        expect(json_response["status"]).to eq 422
      end

      it "should return the error message" do
        expect(json_response["error"]).to eq "Unprocessable Entity"
      end
    end

    context "when request is not valid" do
      before do
        post :create, params: { isbn: "978014300723" }
      end

      it "should return 200" do
        expect(response).to have_http_status(:ok)
      end

      it "should return the http code" do
        expect(json_response["status"]).to eq 200
      end

      it "should return the correct digit" do
        expect(json_response["digit"]).to eq "4"
      end

      it "should return the id digit" do
        expect(json_response["id"]).to be_a_kind_of(Integer)
      end
    end
  end
end
