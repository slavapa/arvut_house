class ApplicationSetupTypesController < ApplicationController
  before_action :set_application_setup_type, only: [:show, :edit, :update, :destroy]

  # GET /application_setup_types
  # GET /application_setup_types.json
  def index
    @application_setup_types = ApplicationSetupType.all
  end

  # GET /application_setup_types/1
  # GET /application_setup_types/1.json
  def show
  end

  # GET /application_setup_types/new
  def new
    @application_setup_type = ApplicationSetupType.new
  end

  # GET /application_setup_types/1/edit
  def edit
  end

  # POST /application_setup_types
  # POST /application_setup_types.json
  def create
    @application_setup_type = ApplicationSetupType.new(application_setup_type_params)

    respond_to do |format|
      if @application_setup_type.save
        format.html { redirect_to @application_setup_type, notice: 'Application setup type was successfully created.' }
        format.json { render action: 'show', status: :created, location: @application_setup_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @application_setup_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /application_setup_types/1
  # PATCH/PUT /application_setup_types/1.json
  def update
    respond_to do |format|
      if @application_setup_type.update(application_setup_type_params)
        format.html { redirect_to @application_setup_type, notice: 'Application setup type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @application_setup_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /application_setup_types/1
  # DELETE /application_setup_types/1.json
  def destroy
    @application_setup_type.destroy
    respond_to do |format|
      format.html { redirect_to application_setup_types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application_setup_type
      @application_setup_type = ApplicationSetupType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def application_setup_type_params
      params.require(:application_setup_type).permit(:code_id, :name, :description)
    end
end
