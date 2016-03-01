class GuestsController < ApplicationController
  before_action :signed_in_user
  before_action :correct_user,   only: [:index, :edit, :update, :show, :languages, :roles]
  before_action :admin_user,     only: [:new, :destroy]
  
  def index
    if request.path_parameters[:format] == 'xlsx'
      @guests = Person.all
    else
      atributes = Hash.new
      atributes['is_guest'] = true
      @search = PersonSearch.new(params[:f], params[:page], {'is_guest' => true})
      @guests = @search.results
    end
    
    respond_to do |format|
      format.html
      format.xlsx
    end
  end
  
  
  # GET /guest/new
  def new
    @guest = Person.new
  end
  
  
  # GET /guest/1/edit
  def edit
    @guest = Person.find(params[:id])
  end
  
  
  def update
    @person = Person.find(params[:id])
    if @person.update_attributes(person_params)
      flash[:success] = t(:person_updated) 
      redirect_to  edit_guest_path(@person)
    else
      render 'edit'
    end
  end
  
  def destroy  
    @person = Person.find(params[:id])  
    @person.destroy
    flash[:success] = t(:person_deleted, 
          name: "#{@person.name} #{@person.family_name}") 
    redirect_to guests_url
  end
  
  
  def create
    @person = Person.new(person_params)

    if @person.save
      flash[:success] = t(:person_created)
      redirect_to edit_guest_path(@person)
    else
      render 'new'
    end
  end
  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(
      :name, :email, :family_name, :email, :phone_mob, :gender, :status,
      :password, :password_confirmation,
      :id_card_number, :address, :admin,
      :birth_date, :workplace, :skills,
      :phone_additional, :computer_knowledge, :family_status,
      :car_owner, :status_id, :area, :department, :email_2, :car_number,
      :org_relation_status_id)
    end
    
    def correct_user
      unless signed_in?
        redirect_to(root_url, notice: t(:not_authorized))          
      end
    end
  
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
