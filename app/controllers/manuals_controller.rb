class ManualsController < ApplicationController
  before_action :set_manual, only: [:show, :edit, :update, :destroy]

  # GET /manuals
  def index
    @manuals = Manual.all
  end

  # GET /manuals/1
  def show
  end

  # GET /manuals/new
  def new
    @manual = Manual.new
  end

  # GET /manuals/1/edit
  def edit
  end

  # POST /manuals
  def create
    @manual = Manual.new(manual_params)

    if @manual.save
      redirect_to @manual, notice: 'Manual was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /manuals/1
  def update
    if @manual.update(manual_params)
      redirect_to @manual, notice: 'Manual was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /manuals/1
  def destroy
    @manual.photo = nil
    @manual.save
    @manual.destroy
    redirect_to manuals_url, notice: 'Manual was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manual
      @manual = Manual.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def manual_params
      params.require(:manual).permit(:company, :vessel_make, :vessel_model, :photo)
    end
end
