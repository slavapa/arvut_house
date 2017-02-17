require 'test_helper'

class PaymentTypeStatusesControllerTest < ActionController::TestCase
  setup do
    @payment_type_status = payment_type_statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:payment_type_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create payment_type_status" do
    assert_difference('PaymentTypeStatus.count') do
      post :create, payment_type_status: { paymet_type_id: @payment_type_status.paymet_type_id, status_id: @payment_type_status.status_id }
    end

    assert_redirected_to payment_type_status_path(assigns(:payment_type_status))
  end

  test "should show payment_type_status" do
    get :show, id: @payment_type_status
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @payment_type_status
    assert_response :success
  end

  test "should update payment_type_status" do
    patch :update, id: @payment_type_status, payment_type_status: { paymet_type_id: @payment_type_status.paymet_type_id, status_id: @payment_type_status.status_id }
    assert_redirected_to payment_type_status_path(assigns(:payment_type_status))
  end

  test "should destroy payment_type_status" do
    assert_difference('PaymentTypeStatus.count', -1) do
      delete :destroy, id: @payment_type_status
    end

    assert_redirected_to payment_type_statuses_path
  end
end
