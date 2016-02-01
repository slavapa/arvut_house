class OrgRelationStatusesController < ApplicationController
  before_action :set_org_relation_status, only: [:show, :edit, :update, :destroy]

  # GET /org_relation_statuses
  # GET /org_relation_statuses.json
  def index
    @org_relation_statuses = OrgRelationStatus.all
  end

  # GET /org_relation_statuses/1
  # GET /org_relation_statuses/1.json
  def show
  end

  # GET /org_relation_statuses/new
  def new
    @org_relation_status = OrgRelationStatus.new
  end

  # GET /org_relation_statuses/1/edit
  def edit
  end

  # POST /org_relation_statuses
  # POST /org_relation_statuses.json
  def create
    @org_relation_status = OrgRelationStatus.new(org_relation_status_params)

    respond_to do |format|
      if @org_relation_status.save
        format.html { redirect_to @org_relation_status, notice: 'Org relation status was successfully created.' }
        format.json { render action: 'show', status: :created, location: @org_relation_status }
      else
        format.html { render action: 'new' }
        format.json { render json: @org_relation_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /org_relation_statuses/1
  # PATCH/PUT /org_relation_statuses/1.json
  def update
    respond_to do |format|
      if @org_relation_status.update(org_relation_status_params)
        format.html { redirect_to @org_relation_status, notice: 'Org relation status was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @org_relation_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /org_relation_statuses/1
  # DELETE /org_relation_statuses/1.json
  def destroy
    @org_relation_status.destroy
    respond_to do |format|
      format.html { redirect_to org_relation_statuses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_org_relation_status
      @org_relation_status = OrgRelationStatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def org_relation_status_params
      params.require(:org_relation_status).permit(:name)
    end
end
