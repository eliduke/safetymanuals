class Admin::ManualsController < ApplicationController
  http_basic_authenticate_with name: ENV['BASIC_AUTH_USERNAME'], password: ENV['BASIC_AUTH_PASSWORD']
  before_action :set_manual, only: [:show, :edit, :update, :destroy]

  def index
    @title = "Admin"

    @manuals = Manual.all.order(:carrier)
    @manuals = @manuals.by_mode(params[:mode]) if params[:mode].present?
    @manuals = @manuals.by_make(params[:make]) if params[:make].present?
    @manuals = @manuals.by_carrier(params[:carrier]) if params[:carrier].present?

    @modes = Manual::MODES
    @makes = Manual.all.pluck(:make).uniq.sort
    @carriers = Manual.all.pluck(:carrier).uniq.sort
  end

  def new
    @title = "New Manual"
    @manual = Manual.new
  end

  def edit
    @title = "Edit Manual - #{@manual.title}"
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
    params.require(:manual).permit(:mode, :carrier, :make, :model, :revision, :photo)
  end
end
