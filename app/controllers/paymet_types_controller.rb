class PaymetTypesController < ApplicationController
  before_action :set_paymet_type, only: [:show, :edit, :update, :destroy]
  before_action :check_current_user_admin

  # GET /paymet_types
  # GET /paymet_types.json
  def index
    #@search = PaymetType.new params[:f], params[:page]
    #@paymet_types = @search.results
    @paymet_types = PaymetType.all
  end

  # GET /paymet_types/1
  # GET /paymet_types/1.json
  def show
  end

  # GET /paymet_types/new
  def new
    @paymet_type = PaymetType.new
  end

  # GET /paymet_types/1/edit
  def edit
  end

  # POST /paymet_types
  # POST /paymet_types.json
  def create
    @paymet_type = PaymetType.new(paymet_type_params)

    respond_to do |format|
      if @paymet_type.save
        format.html { 
          flash[:success] = t(:paymet_type_created)
          redirect_to edit_paymet_type_path(@paymet_type)           
          }
        format.json { render action: 'show', status: :created, location: @paymet_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @paymet_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /paymet_types/1
  # PATCH/PUT /paymet_types/1.json
  def update
    respond_to do |format|
      if @paymet_type.update(paymet_type_params)
        format.html { 
          flash[:success] = t(:paymet_type_updated) 
          redirect_to edit_paymet_type_path(@paymet_type)           
          }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @paymet_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paymet_types/1
  # DELETE /paymet_types/1.json
  def destroy
    @paymet_type.destroy
    respond_to do |format|
      format.html { redirect_to paymet_types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paymet_type
      @paymet_type = PaymetType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def paymet_type_params
      params.require(:paymet_type).permit(:name, :frequency)
    end
end
