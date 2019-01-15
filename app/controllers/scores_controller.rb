class ScoresController < ApplicationController

  ##basic authentication
  #http_basic_authenticate_with name: "over", password: "laylay", except: [:index, :show]

  ##don't check AuthenticityToken
  skip_before_action :verify_authenticity_token


  ## GET /scores/new
  def new
    @score = Score.new
  end


  ## POST /scores
  def create
    ##render plain: params[:score].inspect

    ##association
    @score = Score.new(score_params)

    if @score.save     ## if successed, save to db

      ##return normal html
      #redirect_to @score     ##redirect to added score
      ##or
      #redirect_to score_path  ##score list

      ##return json
      render json: @score, status: :created, location: @score
    else

      ##return normal html
      #render "new"

      ##return json
      render json: @score.errors, status: :unprocessable_entity
    end

  end


  def show
    @score = Score.find(params[:id])
  end


  def index
    ##return all
    ##@scores = Score.all

    ##return all, sorted
    ##@scores = Score.order :score ##ascendent
    @scores = Score.order("score DESC") ##descendent

    ##sorted with updated_at DESC row, descendent
    @scores_updated_at_desc = Score.order("updated_at DESC")

    ##a = "abc"
    ##@scores_updated_at_desc.put[a]

    ##score_n_d = Score.order("updated_at DESC")
    ##score_n_d.each_with_index do |s, i|
    ##@scores.each_with_index do |s, i|
    ##  if @scores_new_desc[i] == s then

    ##  end
    ##end


    ##or return json
    #render json: @scores
  end

  def index_debug
    #@scores = Score.all

    @scores = Score.order("score DESC")
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

    ##redirect_to scores_path ## original
    redirect_to scores_debug_path

  end

  private
    def score_params
      params.require(:score).permit(:score, :player)
    end

end
