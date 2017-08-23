class PersonDefaultPaymentsController < ApplicationController
  before_action :check_current_user_admin
  before_action :set_person_default_payment, only: [:update]
   
  def create
    @payment_type = PaymentType.find(params[:person_default_payment][:payment_type_id])
    @person = Person.find(params[:person_default_payment][:person_id])
    @person_default_payment = @payment_type.add_person!(@person)
    # #Person.merge_payment_attr(@person,  @person_payment)
    # @person.merge_payment_attr(@person_payment)
    
    # respond_to do |format|
    #   format.html {redirect_to edit_payment_path(@payment)}
    #   format.js      
    # end
  end

  def destroy
    @payment_type = PaymentType.find(params[:person_default_payment][:payment_type_id])
    @person = Person.find(params[:person_default_payment][:person_id])
    @payment_type.remove_person!(@person)
    # respond_to do |format|
    #   format.html {redirect_to edit_payment_path(@payment)}
    #   format.js      
    # end
  end

  def update
    @payment_type = PaymentType.find(@person_payment.payment_type_id)
    # @person = Person.find(@person_payment.person_id)
    
    if @person_payment.update_attributes(amount: params[:amount])
      flash.now[:success] = t(:person_payment_updated) 
    
    else
      flash.now[:error] = t(:person_payment_not_updated) 
    end 
    
    # @person.merge_payment_attr(@person_payment) 
    
    respond_to do |format|
      format.html {redirect_to edit_payment_type_path(@payment_type)}
      format.js      
    end
  end
  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person_default_payment
      @person_payment = PersonDefaultPayment.find(params[:id])
    end
   
end
