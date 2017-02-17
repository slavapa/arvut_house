class PaymentTypeStatusesController < ApplicationController
  before_action :set_payment_type_status, only: [:show, :edit, :update, :destroy]

  # GET /payment_type_statuses
  # GET /payment_type_statuses.json
  def index
    @payment_type_statuses = PaymentTypeStatus.all
  end

  # GET /payment_type_statuses/1
  # GET /payment_type_statuses/1.json
  def show
  end

  # GET /payment_type_statuses/new
  def new
    @payment_type_status = PaymentTypeStatus.new
  end

  # GET /payment_type_statuses/1/edit
  def edit
  end

  # POST /payment_type_statuses
  # POST /payment_type_statuses.json
  def create
    @payment_type_status = PaymentTypeStatus.new(payment_type_status_params)

    respond_to do |format|
      if @payment_type_status.save
        format.html { redirect_to @payment_type_status, notice: 'Payment type status was successfully created.' }
        format.json { render action: 'show', status: :created, location: @payment_type_status }
      else
        format.html { render action: 'new' }
        format.json { render json: @payment_type_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payment_type_statuses/1
  # PATCH/PUT /payment_type_statuses/1.json
  def update
    respond_to do |format|
      if @payment_type_status.update(payment_type_status_params)
        format.html { redirect_to @payment_type_status, notice: 'Payment type status was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @payment_type_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payment_type_statuses/1
  # DELETE /payment_type_statuses/1.json
  def destroy
    @payment_type_status.destroy
    respond_to do |format|
      format.html { redirect_to payment_type_statuses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment_type_status
      @payment_type_status = PaymentTypeStatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_type_status_params
      params.require(:payment_type_status).permit(:paymet_type_id, :status_id)
    end
end
