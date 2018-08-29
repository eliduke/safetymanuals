class ManualsController < ApplicationController
  http_basic_authenticate_with name: ENV['BASIC_AUTH_USERNAME'], password: ENV['BASIC_AUTH_PASSWORD'], only: [:new, :create, :edit, :update, :destroy]
  before_action :set_manual, only: [:show, :edit, :update, :destroy]
  before_action :set_filters, only: [:index, :list]

  def index
    @title = filter_present? ? active_filter : "Home"
    @index_selected = true
  end

  def list
    @title = filter_present? ? "#{active_filter} : Master List" : "Master List"
    @list_selected = true
  end

  def show
    @manual = Manual.find_by(permalink: params[:id])
    @title = @manual.title
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
      redirect_to @manual, notice: 'Manual was successfully created.'
    else
      render :new
    end
  end

  def update
    if @manual.update(manual_params)
      redirect_to @manual, notice: 'Manual was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @manual.photo = nil
    @manual.save
    @manual.destroy
    redirect_to manuals_path, notice: 'Manual was successfully destroyed.'
  end

  def about
    @title = "About"
  end

  private

  def filter_present?
    params[:mode].present? || params[:make].present? || params[:carrier].present?
  end

  def active_filter
    params[:mode]&.pluralize || params[:make] || params[:carrier]
  end

  def set_filters
    @manuals = Manual.all.order(:carrier)
    @cleaned_params = {}

    if params[:mode].present?
      @manuals = @manuals.by_mode(params[:mode])
      @cleaned_params.merge!({ mode: params[:mode] })
    end

    if params[:make].present?
      @manuals = @manuals.by_make(params[:make])
      @cleaned_params.merge!({ make: params[:make] })
    end

    if params[:carrier].present?
      @manuals = @manuals.by_carrier(params[:carrier])
      @cleaned_params.merge!({ carrier: params[:carrier] })
    end

    @modes = Manual::MODES
    @makes = Manual.all.pluck(:make).uniq.sort
    @carriers = Manual.all.pluck(:carrier).uniq.sort
  end

  def set_manual
    @manual = Manual.find_by(permalink: params[:id])
  end

  def manual_params
    params.require(:manual).permit(
      :mode,
      :carrier,
      :make,
      :model,
      :revision,
      :photo,
      :notes
    )
  end
end
