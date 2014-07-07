class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :check_current_user_admin

  # GET /events
  # GET /events.json
  def index
    @search = EventSearch.new params[:f], params[:page]
    @events = @search.results
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
    #@event.event_date = Date.today
  end

  # GET /events/1/edit
  def edit
    store_current_event_id(@event.id)
    PersonEventSearch.set_event_id(@event.id)
    @search = PersonEventSearch.new params[:f], params[:page], {event_id: @event.id}
    @people = @search.results
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { 
          flash[:success] = t(:event_created)
          redirect_to edit_event_path(@event) 
          }
          
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { 
          flash[:success] = t(:event_updated) 
          redirect_to edit_event_path(@event)
          }          
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    flash[:success] = t(:event_type_deleted, 
          name: "#{@event.event_types_name}-#{@event.event_date.to_formatted_s(:long)}") 
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:event_date, :event_type_id, :description)
    end
end
