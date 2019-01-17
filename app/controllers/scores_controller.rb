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

    @scores_desc = @scores
    ##for s in @scores_desc do
    @table = []
    @scores_desc.each_with_index do |s, i|
      id = s.id
      sc = s.score
      p = s.player
      ca = s.created_at
      ua = s.updated_at
      row = {"rank":i+1,"id":id, "score":sc, "player":p, "created_at":ca, "updated_at":ua}
      @table.push(@row)
    end

    ##sorted with updated_at DESC row, descendent
    @scores_updated_at_desc = Score.order("updated_at DESC")

    j_rank = []
    i_index = []
    @scores_updated_at_desc_with_ranking = []
    @scores_updated_at_desc.each_with_index do |s_up,i|
      puts "======"
      s_up_id = s_up.id
      puts "s_up_id: " + s_up_id.to_s + ", " + i.to_s
      ##puts s_d_id.to_s + ", " + i.to_s
      i_index.push(s_up_id)

      puts "------"
      @scores_desc.each_with_index do |s_d,j|
        s_d_id = s_d.id
        #puts "s_u_id*" + s_u_id.to_s + ", " + j.to_s

        puts "s_d_id::" + s_d_id.to_s + ", s_up_id:" + s_up_id.to_s + ", jPos:" + j.to_s
        ##if s_up_id == s_d_id then
        if s_up.id.to_i == s_d.id.to_i then ## to_iしないと、.idだけでは、tableのrow列そのものを引っ張ってきてしまう。
          #j_rank.push([s_d_id, s_u_id, j])
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
