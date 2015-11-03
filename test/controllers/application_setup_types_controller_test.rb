require 'test_helper'

class ApplicationSetupTypesControllerTest < ActionController::TestCase
  setup do
    @application_setup_type = application_setup_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:application_setup_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create application_setup_type" do
    assert_difference('ApplicationSetupType.count') do
      post :create, application_setup_type: { code_id: @application_setup_type.code_id, description: @application_setup_type.description, name: @application_setup_type.name }
    end

    assert_redirected_to application_setup_type_path(assigns(:application_setup_type))
  end

  test "should show application_setup_type" do
    get :show, id: @application_setup_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @application_setup_type
    assert_response :success
  end

  test "should update application_setup_type" do
    patch :update, id: @application_setup_type, application_setup_type: { code_id: @application_setup_type.code_id, description: @application_setup_type.description, name: @application_setup_type.name }
    assert_redirected_to application_setup_type_path(assigns(:application_setup_type))
  end

  test "should destroy application_setup_type" do
    assert_difference('ApplicationSetupType.count', -1) do
      delete :destroy, id: @application_setup_type
    end

    assert_redirected_to application_setup_types_path
  end
end
