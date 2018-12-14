class ArticlesController < ApplicationController

  def show
    @article = Article.find(params[:id])
  end

  ## 注釈：@から始まるのは変数名である。
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
   #render plain: params[:article].inspect

   ## desn't work
    ##render plain: params[:title].inspect
    ##render plain: params[:text].inspect

    ## Railsのすべてのモデルは初期化時に属性(フィールド)を与えられ、それらはデータベースカラムに自動的に対応付けられます。
    ##@article = Article.new(params[:article])
    @article = Article.new(article_params)

    ## 次の@article.saveで、このモデルをデータベースに保存します。
    ## @article.save

    if @article.save

    ##実環境では、リダイレクトは必要ないかも。
    ##最後に、ユーザーをshowアクションにリダイレクトします (showアクションはこの後定義します)。訳注: モデルを保持している@articleを指定するだけで、そのモデルを表示するためのshowアクションにリダイレクトされる点にご注目ください。
      redirect_to @article
    else
      render 'new'
    end

  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end


  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path

    ##こちらも動く
    ##redirect_to @article
  end


  private
    def article_params
      params.require(:article).permit(:title, :text)
    end


end
