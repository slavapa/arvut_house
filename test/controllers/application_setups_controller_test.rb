require 'test_helper'

class ApplicationSetupsControllerTest < ActionController::TestCase
  setup do
    @application_setup = application_setups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:application_setups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create application_setup" do
    assert_difference('ApplicationSetup.count') do
      post :create, application_setup: { app_setup_type_id: @application_setup.app_setup_type_id, code_id: @application_setup.code_id, description: @application_setup.description, language_code_id: @application_setup.language_code_id, str_value: @application_setup.str_value }
    end

    assert_redirected_to application_setup_path(assigns(:application_setup))
  end

  test "should show application_setup" do
    get :show, id: @application_setup
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @application_setup
    assert_response :success
  end

  test "should update application_setup" do
    patch :update, id: @application_setup, application_setup: { app_setup_type_id: @application_setup.app_setup_type_id, code_id: @application_setup.code_id, description: @application_setup.description, language_code_id: @application_setup.language_code_id, str_value: @application_setup.str_value }
    assert_redirected_to application_setup_path(assigns(:application_setup))
  end

  test "should destroy application_setup" do
    assert_difference('ApplicationSetup.count', -1) do
      delete :destroy, id: @application_setup
    end

    assert_redirected_to application_setups_path
  end
end
