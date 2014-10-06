class LanguagesController < ApplicationController
  before_action :set_language, only: [:show, :edit, :update, :destroy]
  before_action :check_current_user_admin

  # GET /languages
  # GET /languages.json
  def index
    @languages = Language.all
  end

  # GET /languages/1
  # GET /languages/1.json
  def show
  end

  # GET /languages/new
  def new
    @language = Language.new
  end

  # GET /languages/1/edit
  def edit
  end

  # POST /languages
  # POST /languages.json
  def create
    @language = Language.new(language_params)

    respond_to do |format|
      if @language.save
        format.html { 
          flash[:success] = t(:item_created, name: t('activerecord.models.language'))
          redirect_to edit_language_path(@language)  
        }
        format.json { render action: 'show', status: :created, location: @language }
      else
        format.html { render action: 'new' }
        format.json { render json: @language.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /languages/1
  # PATCH/PUT /languages/1.json
  def update
    respond_to do |format|
      if @language.update(language_params)
        format.html { 
          flash[:success] = t(:item_updated, name: t('activerecord.models.language')) 
          redirect_to edit_language_path(@language)  
        }
        
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @language.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /languages/1
  # DELETE /languages/1.json
  def destroy    
    if @language.destroy
      flash[:success] = t(:language_deleted, name: @language.name) 
      respond_to do |format|
        format.html { redirect_to languages_url }
        format.json { head :no_content }
      end
    else
        flash[:error] = t(:delete_item_restrict_error, module_name: t('activerecord.models.language')) 
        redirect_to edit_language_path(@language)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_language
      @language = Language.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def language_params
      params.require(:language).permit(:name, :code)
    end
end
