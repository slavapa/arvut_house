class DepartmentPersonRolesController < ApplicationController
  before_action :signed_in_user
  before_action :set_department_person_role, only: [:show, :edit, :update, :destroy]
  before_action :check_current_user_admin, only: [:new, :create, :update, :destroy]
  

  # GET /department_person_roles
  # GET /department_person_roles.json
  def index
    @search = DepartmentPersonRoleSearch.new params[:f], params[:page]
    @department_person_roles = @search.results
  end

  # GET /department_person_roles/1
  # GET /department_person_roles/1.json
  def show
  end

  # GET /department_person_roles/new
  def new
    @department_person_role = DepartmentPersonRole.new
  end

  # GET /department_person_roles/1/edit
  def edit
  end

  # POST /department_person_roles
  # POST /department_person_roles.json
  def create
    @department_person_role = DepartmentPersonRole.new(department_person_role_params)

    respond_to do |format|
      if @department_person_role.save
         format.html { 
          flash[:success] = t(:item_created, name: t('activerecord.models.department_person_role'))
          redirect_to edit_department_person_role_path(@department_person_role) 
        }
        
        format.json { render action: 'show', status: :created, location: @department_person_role }
      else
        format.html { render action: 'new' }
        format.json { render json: @department_person_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /department_person_roles/1
  # PATCH/PUT /department_person_roles/1.json
  def update
    respond_to do |format|
      #@department_person_role.person_full_name = params[:person_full_name]
      if @department_person_role.update(department_person_role_params)
        format.html { 
          flash[:success] = t(:item_updated, name: t('activerecord.models.department_person_role')) 
          redirect_to edit_department_person_role_path(@department_person_role) 
        }
        
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @department_person_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /department_person_roles/1
  # DELETE /department_person_roles/1.json
  def destroy
    @department_person_role.destroy
    respond_to do |format|
      format.html { redirect_to department_person_roles_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_department_person_role
      @department_person_role = DepartmentPersonRole.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def department_person_role_params
      params.require(:department_person_role).permit(:person_full_name, :department_id,
                      :person_id, :role_id)
    end
end
