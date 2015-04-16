class PersonPaymentsController < ApplicationController
  before_action :check_current_user_admin
  
  def create
    @payment = Payment.find(params[:person_payment][:payment_id])
    @person = Person.find(params[:person_payment][:person_id])
    @payment.add_person!(@person)
    respond_to do |format|
      format.html {redirect_to edit_payment_path(@payment)}
      format.js      
    end
  end

  def destroy
    @payment = Payment.find(params[:person_payment][:payment_id])
    @person = Person.find(params[:person_payment][:person_id])
    @payment.remove_person!(@person)
    respond_to do |format|
      format.html {redirect_to edit_payment_path(@payment)}
      format.js      
    end
  end

  def update
  end
end
