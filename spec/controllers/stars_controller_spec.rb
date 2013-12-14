# coding: utf-8
require 'spec_helper'

describe StarsController do
  let(:user)    { Fabricate(:user)    }
  let(:message) { Fabricate(:message) }

  before do
    controller.stub(:current_user) { user }
    request.env["HTTP_ACCEPT"] = 'application/json'
  end

  def valid_attributes
    { message_id: message.id }
  end

  describe "POST create" do
    context "when star record is not found" do
      it "should return http success" do
        post :create, valid_attributes
        expect(response.status).to eq 200
      end

      it "should return json response" do
        post :create, valid_attributes
        expect(ActiveSupport::JSON.decode(response.body)).to_not be_nil
      end

      it "count should be 1 in json response" do
        post :create, valid_attributes
        expect(ActiveSupport::JSON.decode(response.body)["count"]).to eq 1
      end

      it "should create star record" do
        expect {
          post :create, valid_attributes
        }.to change { Star.count }.by(1)
      end
    end

    context "when star record is found" do
      before do
        Fabricate(:star, user: user, message: message, count: 1)
      end

      it "should return http success" do
        post :create, valid_attributes
        expect(response.status).to eq 200
      end

      it "should return json response" do
        post :create, valid_attributes
        expect(ActiveSupport::JSON.decode(response.body)).to_not be_nil
      end

      it "count should be 2 in json response" do
        post :create, valid_attributes
        expect(ActiveSupport::JSON.decode(response.body)["count"]).to eq 2
      end

      it "should not create star record" do
        expect {
          post :create, valid_attributes
        }.to change { Star.count }.by(0)
      end

      context "when error is raised" do
        before do
          allow_any_instance_of(Star).to receive(:increment).and_raise
        end

        it "should rollback" do
          allow_any_instance_of(Star).to receive(:rollback)
          post :create, valid_attributes
        end

        it "should return 422 status code" do
          post :create, valid_attributes
          expect(response.status).to eq 422
        end
      end
    end
  end
end
