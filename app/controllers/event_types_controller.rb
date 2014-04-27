class EventTypesController < ApplicationController
  before_action :check_current_user_admin
  before_action :set_event_type, only: [:show, :edit, :update, :destroy]

  # GET /event_types
  # GET /event_types.json
  def index
    @event_types = EventType.paginate(page: params[:page])
  end

  # GET /event_types/1
  # GET /event_types/1.json
  def show
  end

  # GET /event_types/new
  def new
    @event_type = EventType.new
  end

  # GET /event_types/1/edit
  def edit
  end

  # POST /event_types
  # POST /event_types.json
  def create
    @event_type = EventType.new(event_type_params)

    respond_to do |format|
      if @event_type.save
        format.html { 
          flash[:success] = 'Event type was successfully created.' 
          redirect_to edit_event_type_path(@event_type)
          }
        format.json { render action: 'show', status: :created, location: @event_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @event_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_types/1
  # PATCH/PUT /event_types/1.json
  def update
    respond_to do |format|
      if @event_type.update(event_type_params)
        format.html { 
          flash[:success] = 'Event type was successfully updated.'
          redirect_to edit_event_type_path(@event_type) 
          }
          
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_types/1
  # DELETE /event_types/1.json
  def destroy
    @event_type.destroy
    respond_to do |format|
      format.html { redirect_to event_types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_type
      @event_type = EventType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_type_params
      params.require(:event_type).permit(:name)
    end
end
