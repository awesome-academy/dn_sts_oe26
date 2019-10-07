require "rails_helper"

RSpec.describe UsersController, type: :controller do
  include SessionsHelper

  let(:user){FactoryBot.create :user}
  let(:invalid_attributes) do
    { name: '' }
  end

  describe "before action" do
    it do
      is_expected.to use_before_action :check_login
      is_expected.to use_before_action :load_user
    end
  end

  describe "GET #new" do
    context "when user not login" do
      it "render new" do
        get :new
        expect(response).to render_template :new
      end
    end

    context "when user login" do
      it "redirect to courses_path when user login" do
        log_in user
        logged_in?
        get :new
        response.should redirect_to courses_path
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new user" do
        post :create, params: {user: FactoryBot.attributes_for(:user)}
        response.should redirect_to root_path
      end
    end
    context "with invalid params" do
      it "creates a new user" do
        post :create, params: {user: invalid_attributes}
        expect(response).to render_template :new
      end
    end
  end

  describe "GET #edit" do
    it "render edit" do
      get :edit, params: { id: user.id }
      expect(response).to render_template :edit
    end
  end

  describe "POST #update" do
    context "with valid params" do
      it "update a user" do
        put :update, params: {id: user.id, user: FactoryBot.attributes_for(:user)}
        response.should redirect_to user
      end
    end
    context "with invalid params" do
      it "update a user" do
        put :update, params: {id: user.id, user: invalid_attributes}
        expect(response).to render_template :edit
      end
    end
  end
end
