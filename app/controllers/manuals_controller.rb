class ManualsController < ApplicationController
  before_action :set_filters, only: [:index, :list]

  def index
    @title = "Home"
    @index_selected = true
  end

  def list
    @title = "Master List"
    @list_selected = true
  end

  def show
    @manual = Manual.find_by(permalink: params[:id])
    @title = @manual.title
  end

  def about
    @title = "About"
  end

  private

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

end
