require 'test_helper'

class CpanelCatesControllerTest < ActionController::TestCase
  setup do
    @cpanel_cate = cpanel_cates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cpanel_cates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cpanel_cate" do
    assert_difference('CpanelCate.count') do
      post :create, cpanel_cate: {  }
    end

    assert_redirected_to cpanel_cate_path(assigns(:cpanel_cate))
  end

  test "should show cpanel_cate" do
    get :show, id: @cpanel_cate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cpanel_cate
    assert_response :success
  end

  test "should update cpanel_cate" do
    patch :update, id: @cpanel_cate, cpanel_cate: {  }
    assert_redirected_to cpanel_cate_path(assigns(:cpanel_cate))
  end

  test "should destroy cpanel_cate" do
    assert_difference('CpanelCate.count', -1) do
      delete :destroy, id: @cpanel_cate
    end

    assert_redirected_to cpanel_cates_path
  end
end
