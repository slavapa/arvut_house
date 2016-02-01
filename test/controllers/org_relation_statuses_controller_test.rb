require 'test_helper'

class OrgRelationStatusesControllerTest < ActionController::TestCase
  setup do
    @org_relation_status = org_relation_statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:org_relation_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create org_relation_status" do
    assert_difference('OrgRelationStatus.count') do
      post :create, org_relation_status: { name: @org_relation_status.name }
    end

    assert_redirected_to org_relation_status_path(assigns(:org_relation_status))
  end

  test "should show org_relation_status" do
    get :show, id: @org_relation_status
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @org_relation_status
    assert_response :success
  end

  test "should update org_relation_status" do
    patch :update, id: @org_relation_status, org_relation_status: { name: @org_relation_status.name }
    assert_redirected_to org_relation_status_path(assigns(:org_relation_status))
  end

  test "should destroy org_relation_status" do
    assert_difference('OrgRelationStatus.count', -1) do
      delete :destroy, id: @org_relation_status
    end

    assert_redirected_to org_relation_statuses_path
  end
end
