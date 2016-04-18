require 'test_helper'

class VisitorStatusesControllerTest < ActionController::TestCase
  setup do
    @visitor_status = visitor_statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:visitor_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create visitor_status" do
    assert_difference('VisitorStatus.count') do
      post :create, visitor_status: { name: @visitor_status.name }
    end

    assert_redirected_to visitor_status_path(assigns(:visitor_status))
  end

  test "should show visitor_status" do
    get :show, id: @visitor_status
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @visitor_status
    assert_response :success
  end

  test "should update visitor_status" do
    patch :update, id: @visitor_status, visitor_status: { name: @visitor_status.name }
    assert_redirected_to visitor_status_path(assigns(:visitor_status))
  end

  test "should destroy visitor_status" do
    assert_difference('VisitorStatus.count', -1) do
      delete :destroy, id: @visitor_status
    end

    assert_redirected_to visitor_statuses_path
  end
end
