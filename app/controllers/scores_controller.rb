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
    ##for debug
    #render plain: params[:score].inspect

    ##association
    @score = Score.new(score_params)

    if @score.save  ## if successed, save to db

      ##return html
      #redirect_to @score     ##redirect to newly added score
      ##or
      redirect_to scores_debug_path  ##redirect to score list

      ##or return json
      #render json: @score, status: :created, location: @score
    else

      ##return html
      render "new"

      ##or return json
      #render json: @score.errors, status: :unprocessable_entity
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

    ## get rank by referencing @scores_desc
    create_scores_updated_at_desc_with_ranking()

    ##or return json
    #render json: @scores
  end


  ##produce json for high score list
  def scores_desc
    @scores = Score.order("score DESC") ##descendent
    render json: @scores
  end


  ##produce json for newly added socre with ranking
  def scores_updated_at_desc_with_ranking
    @scores = Score.order("score DESC") ##descendent
    create_scores_updated_at_desc_with_ranking()
    render json: @scores_updated_at_desc_with_ranking
  end


  ##create newly added socre list with ranking
  def create_scores_updated_at_desc_with_ranking
    @scores_desc = @scores
    @scores_updated_at_desc = Score.order("updated_at DESC")
    @scores_updated_at_desc_with_ranking = []
    @scores_updated_at_desc.each_with_index do |s_up,i|
      puts "======"
      puts "s_up.id: " + s_up.id.to_s + ", " + i.to_s
      puts "------"
      @scores_desc.each_with_index do |s_d,j|
        puts "s_d.id::" + s_d.id.to_s + ", s_up.id:" + s_up.id.to_s + ", jPos:" + j.to_s
        if s_up.id.to_i == s_d.id.to_i then ## to_iしないと、.idだけでは、tableのrow列そのものを引っ張ってきてしまう。
          puts "MATCH!!"
          id = s_d.id
          sc = s_d.score
          p = s_d.player
          ca = s_d.created_at
          ua = s_d.updated_at
          row = {"rank":j+1,"id":id, "score":sc, "player":p, "created_at":ca, "updated_at":ua}
          @scores_updated_at_desc_with_ranking.push(row)
          break
        end
      end
    end
  end


  def index_debug
    ##normal order(createed at)
    #@scores = Score.all

    ##sorted
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

    ## return to normal site
    #redirect_to scores_path

    ##return to debug site
    redirect_to scores_debug_path
  end


  private
    def score_params
      params.require(:score).permit(:score, :player)
    end

end
