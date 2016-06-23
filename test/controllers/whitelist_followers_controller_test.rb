require 'test_helper'

class WhitelistFollowersControllerTest < ActionController::TestCase
  setup do
    @whitelist_follower = whitelist_followers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:whitelist_followers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create whitelist_follower" do
    assert_difference('WhitelistFollower.count') do
      post :create, whitelist_follower: {  }
    end

    assert_redirected_to whitelist_follower_path(assigns(:whitelist_follower))
  end

  test "should show whitelist_follower" do
    get :show, id: @whitelist_follower
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @whitelist_follower
    assert_response :success
  end

  test "should update whitelist_follower" do
    patch :update, id: @whitelist_follower, whitelist_follower: {  }
    assert_redirected_to whitelist_follower_path(assigns(:whitelist_follower))
  end

  test "should destroy whitelist_follower" do
    assert_difference('WhitelistFollower.count', -1) do
      delete :destroy, id: @whitelist_follower
    end

    assert_redirected_to whitelist_followers_path
  end
end
