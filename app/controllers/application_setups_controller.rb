class ApplicationSetupsController < ApplicationController
  before_action :signed_in_user
  before_action :set_application_setup, only: [:show, :edit, :update, :destroy]
  before_action :check_current_user_admin, only: [:new, :create, :update, :destroy]

  def upload
    uploaded_io = params[:picture]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
  end

  # GET /application_setups
  # GET /application_setups.json
  def index
    @application_setups = ApplicationSetup.all
  end

  # GET /application_setups/1
  # GET /application_setups/1.json
  # def show
  # end

  # GET /application_setups/new
  # def new
  #   @application_setup = ApplicationSetup.new
  # end

  # GET /application_setups/1/edit
  def edit
  end

  # POST /application_setups
  # POST /application_setups.json
  # def create
  #   @application_setup = ApplicationSetup.new(application_setup_params)

  #   respond_to do |format|
  #     if @application_setup.save
  #       format.html { redirect_to @application_setup, notice: 'Application setup was successfully created.' }
  #       format.json { render action: 'show', status: :created, location: @application_setup }
  #     else
  #       format.html { render action: 'new' }
  #       format.json { render json: @application_setup.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /application_setups/1
  # PATCH/PUT /application_setups/1.json
  def update
    respond_to do |format|
      
      uploaded_io = params[:application_setup][:picture]
      if !uploaded_io.nil?
        newfileName =  "#{ DateTime.now.to_i}_#{uploaded_io.original_filename}"
        File.open(Rails.root.join('app', 'assets', 'images', 'uploads', newfileName), 'wb') do |file|
          file.write(uploaded_io.read)
        end
        params[:application_setup][:str_value] = newfileName
      end
    
      if @application_setup.update(application_setup_params)
        format.html { 
          flash[:success] = t(:item_updated, name: 'Application setup was successfully updated.') 
          redirect_to edit_application_setup_path(@application_setup) 
        }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @application_setup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /application_setups/1
  # DELETE /application_setups/1.json
  # def destroy
  #   @application_setup.destroy
  #   respond_to do |format|
  #     format.html { redirect_to application_setups_url }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application_setup
      @application_setup = ApplicationSetup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def application_setup_params
      params.require(:application_setup).permit(:str_value)
    end
end
