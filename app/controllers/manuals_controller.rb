class ManualsController < ApplicationController
  before_action :set_filters, only: [:index, :list]

  def index
  end

  def list
  end

  def show
    @manual = Manual.find_by(permalink: params[:id])
  end

  private

  def set_filters
    @manuals = Manual.all.order(:carrier)
    @manuals = @manuals.by_mode(params[:mode]) if params[:mode].present?
    @manuals = @manuals.by_make(params[:make]) if params[:make].present?
    @manuals = @manuals.by_carrier(params[:carrier]) if params[:carrier].present?

    @modes = Manual::MODES
    @makes = Manual.all.pluck(:make).uniq.sort
    @carriers = Manual.all.pluck(:carrier).uniq.sort
  end

end
