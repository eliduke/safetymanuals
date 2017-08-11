class ManualsController < ApplicationController

  def index
    @manuals = Manual.all.order(:carrier)
  end

  def show
    @manual = Manual.find_by(permalink: params[:id])
  end

end
