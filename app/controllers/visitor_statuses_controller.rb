class VisitorStatusesController < ApplicationController
  before_action :set_visitor_status, only: [:show, :edit, :update, :destroy]

  # GET /visitor_statuses
  # GET /visitor_statuses.json
  def index
    @visitor_statuses = VisitorStatus.all
  end

  # GET /visitor_statuses/1
  # GET /visitor_statuses/1.json
  def show
  end

  # GET /visitor_statuses/new
  def new
    @visitor_status = VisitorStatus.new
  end

  # GET /visitor_statuses/1/edit
  def edit
  end

  # POST /visitor_statuses
  # POST /visitor_statuses.json
  def create
    @visitor_status = VisitorStatus.new(visitor_status_params)

    respond_to do |format|
      if @visitor_status.save
        format.html { redirect_to @visitor_status, notice: 'Visitor status was successfully created.' }
        format.json { render action: 'show', status: :created, location: @visitor_status }
      else
        format.html { render action: 'new' }
        format.json { render json: @visitor_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /visitor_statuses/1
  # PATCH/PUT /visitor_statuses/1.json
  def update
    respond_to do |format|
      if @visitor_status.update(visitor_status_params)
        format.html { redirect_to @visitor_status, notice: 'Visitor status was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @visitor_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /visitor_statuses/1
  # DELETE /visitor_statuses/1.json
  def destroy
    @visitor_status.destroy
    respond_to do |format|
      format.html { redirect_to visitor_statuses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_visitor_status
      @visitor_status = VisitorStatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def visitor_status_params
      params.require(:visitor_status).permit(:name)
    end
end
