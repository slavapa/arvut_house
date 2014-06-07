class PeopleController < ApplicationController
  # before_action :set_person, only: [:show, :edit, :update, :destroy] 
  before_action :signed_in_user
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:edit, :update, :destroy]
    
  def destroy
    Person.find(params[:id]).destroy
    flash[:success] = "Person deleted."
    redirect_to people_url
  end
  
  # # GET /people
  # # GET /people.json
  # def index
    # @people = Person.all
  # end
  
  def index
    @search = PersonSearch.new params[:f], params[:page]
    #@people = Person.paginate(page: params[:page]).order("name, family_name ASC")
    @people = @search.results
  end

  # GET /people/1
  # GET /people/1.json
  def show
    @person = Person.find(params[:id])
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)

    if @person.save
      flash[:success] = t(:person_created)
      redirect_to edit_person_path(@person)
    else
      render 'new'
    end
    # respond_to do |format|
      # if @person.save
        # format.html { redirect_to @person, notice: 'Person was successfully created.' }
        # format.json { render action: 'show', status: :created, location: @person }
      # else
        # format.html { render action: 'new' }
        # format.json { render json: @person.errors, status: :unprocessable_entity }
      # end
    # end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    # respond_to do |format|
      # if @person.update(person_params)
        # format.html { redirect_to @person, notice: 'Person was successfully updated.' }
        # format.json { head :no_content }
      # else
        # format.html { render action: 'edit' }
        # format.json { render json: @person.errors, status: :unprocessable_entity }
      # end
    # end
    
    if @person.update_attributes(person_params)
      flash[:success] = t(:person_updated) 
      redirect_to  edit_person_path(@person)
    else
      render 'edit'
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy  
    @person = Person.find(params[:id])  
    @person.destroy
    flash[:success] = t(:person_deleted, 
          name: "#{@person.name} #{@person.family_name}") 
    redirect_to people_url
    # respond_to do |format|
      # format.html { redirect_to people_url }
      # format.json { head :no_content }
    # end
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
      :car_owner, :status_id)
    end
    
    def correct_user
      @person = Person.find(params[:id])
      unless current_user.admin?
        redirect_to(root_url, notice: t(:not_authorized)) 
      end
    end
  
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
