require 'test_helper'

module Knock
  class AuthTokenControllerTest < ActionController::TestCase
    setup do
      @routes = Engine.routes
    end

    def user
      @user ||= users(:one)
    end

    test "responds with 404 if user does not exist" do
      post :create, auth: { email: 'wrong@example.net', password: '' }
      assert_response :not_found
    end

    test "responds with 404 if password is invalid" do
      post :create, auth: { email: user.email, password: 'wrong' }
      assert_response :not_found
    end

    test "responds with 201" do
      post :create, auth: { email: user.email, password: 'secret' }
      assert_response :created
    end
  end
end
