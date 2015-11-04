require 'test_helper'

class AppSetupTypesControllerTest < ActionController::TestCase
  setup do
    @app_setup_type = app_setup_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:app_setup_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create app_setup_type" do
    assert_difference('AppSetupType.count') do
      post :create, app_setup_type: { description: @app_setup_type.description, id: @app_setup_type.id, name: @app_setup_type.name }
    end

    assert_redirected_to app_setup_type_path(assigns(:app_setup_type))
  end

  test "should show app_setup_type" do
    get :show, id: @app_setup_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @app_setup_type
    assert_response :success
  end

  test "should update app_setup_type" do
    patch :update, id: @app_setup_type, app_setup_type: { description: @app_setup_type.description, id: @app_setup_type.id, name: @app_setup_type.name }
    assert_redirected_to app_setup_type_path(assigns(:app_setup_type))
  end

  test "should destroy app_setup_type" do
    assert_difference('AppSetupType.count', -1) do
      delete :destroy, id: @app_setup_type
    end

    assert_redirected_to app_setup_types_path
  end
end
