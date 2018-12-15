class ScoresController < ApplicationController

  def new
  end

  def create
    render plain: params[:score].inspect
  end

end
