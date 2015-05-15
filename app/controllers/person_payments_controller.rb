class PersonPaymentsController < ApplicationController
  before_action :check_current_user_admin
   before_action :set_person_payment, only: [:update]
  
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
    if params[:amount].nil?
      redirect_to people_url
    else
      if @person_payment.update_attributes(amount: params[:amount])
        flash[:success] = t(:person_updated) 
      else
        #render 'edit'
      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person_payment
      @person_payment = PersonPayment.find(params[:id])
    end
   
end
