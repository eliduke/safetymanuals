class Admin::ManualsController < ApplicationController
  http_basic_authenticate_with name: ENV['BASIC_AUTH_USERNAME'], password: ENV['BASIC_AUTH_PASSWORD']
  before_action :set_manual, only: [:show, :edit, :update, :destroy]

  def index
    @manuals = Manual.all.order(:carrier)
  end

  def new
    @manual = Manual.new
  end

  def edit
  end

  def create
    @manual = Manual.new(manual_params)

    if @manual.save
      redirect_to admin_manuals_path, notice: 'Manual was successfully created.'
    else
      render :new
    end
  end

  def update
    if @manual.update(manual_params)
      redirect_to admin_manuals_path, notice: 'Manual was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @manual.photo = nil
    @manual.save
    @manual.destroy
    redirect_to admin_manuals_path, notice: 'Manual was successfully destroyed.'
  end

  private

  def set_manual
    @manual = Manual.find_by(permalink: params[:id])
  end

  def manual_params
    params.require(:manual).permit(:carrier, :make, :model, :photo)
  end
end
