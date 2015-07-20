class PaymentsController < ApplicationController
  before_action :signed_in_user
  before_action :set_payment, only: [:show, :edit, :update, :destroy, :all_people]
  before_action :check_current_user_admin, only: [:new, :create, :update, :destroy]

  def all_people
    if request.path_parameters[:format] == 'xlsx'
      @people = Person.person_left_outer_payment( @payment.id)
      fileName = "payment_#{@payment.id}_all_people.xlsx"
      response.headers['Content-Disposition'] = "attachment; filename=#{fileName}"
    end
  end
  
  # GET /payments
  # GET /payments.json
  def index
    @search = PaymentSearch.new params[:f], params[:page]
    @payments = @search.results
#    @payments = Payment.all
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    @payment = Payment.new
  end

  # GET /payments/1/edit
  def edit
    store_current_payment_id(@payment.id)
    PersonPaymentSearch.set_payment_id(@payment.id)
    @search = PersonPaymentSearch.new params[:f], params[:page], {payment_id: @payment.id}
    @people = @search.results
#    @people = Person.all
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(payment_params)

    respond_to do |format|
      if @payment.save
        format.html { 
          flash[:success] = t(:item_created, name: t('activerecord.models.payment'))
          redirect_to edit_payment_path(@payment)  
        }
        format.json { render action: 'show', status: :created, location: @payment }
      else
        format.html { render action: 'new' }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { 
          flash[:success] = t(:item_updated, name: t('activerecord.models.payment')) 
          redirect_to edit_payment_path(@payment) 
        }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:description, :payment_date, :payment_type_id)
    end
end
