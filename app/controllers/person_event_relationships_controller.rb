class PersonEventRelationshipsController < ApplicationController
  before_action :check_current_user_admin
  def create 
    @event = Event.find(params[:person_event_relationship][:event_id])
    @person = Person.find(params[:person_event_relationship][:person_id])
    @event.add_person!(@person)
    respond_to do |format|
      format.html {redirect_to edit_event_path(@event)}
      format.js      
    end
  end

  def destroy
    @event = Event.find(params[:person_event_relationship][:event_id])
    @person = Person.find(params[:person_event_relationship][:person_id])
    @event.remove_person!(@person)
    respond_to do |format|
      format.html {redirect_to edit_event_path(@event)}
      format.js      
    end
  end
end
