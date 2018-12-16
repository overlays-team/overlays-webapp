class ScoresController < ApplicationController

  ##basic authentication
  #http_basic_authenticate_with name: "over", password: "laylay", except: [:index, :show]

  ## GET /scores/new
  def new
    @score = Score.new
  end


  ## POST /scores
  def create
    ##render plain: params[:score].inspect

    ##association
    @score = Score.new(score_params)


    if @score.save     ## save to db
      redirect_to @score     ##redirect to score list
    else
      render "new"
    end

  end


  def show
    @score = Score.find(params[:id])
  end

  def index
    @scores = Score.all
  end

  def edit
    @score = Score.find(params[:id])
  end

  def update
    @score = Score.find(params[:id])

    if @score.update(score_params) ## if update successed
      redirect_to @score
    else
      reder "edit"
    end

  end

  def destroy
    @score = Score.find(params[:id])
    @score.destroy

    redirect_to scores_path
  end

  private
    def score_params
      params.require(:score).permit(:score, :player)
    end

end
