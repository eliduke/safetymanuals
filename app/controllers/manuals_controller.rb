class ManualsController < ApplicationController

  def index
    @manuals = Manual.all.order(:carrier)
    @manuals = @manuals.by_carrier(params[:carrier]) if params[:carrier].present?
    @manuals = @manuals.by_make(params[:make]) if params[:make].present?
    @manuals = @manuals.by_model(params[:model]) if params[:model].present?

    @carriers = Manual.all.pluck(:carrier).uniq.sort
    @makes = Manual.all.pluck(:make).uniq.sort
  end

  def list
    @manuals = Manual.all.order(:carrier)
  end

  def show
    @manual = Manual.find_by(permalink: params[:id])
  end

end
