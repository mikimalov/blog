class ArticlesController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]
  before_action :find_article, except: [:index, :new, :create]
  before_action :same_user, only: [:edit, :update]

  def index
    @articles = Article.all
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    # binding.pry
    # render plain: params[:article].inspect
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      redirect_to @article
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    if valid_user?(@article.user)
     @article.destroy
     redirect_to articles_path
    else
      session_notice('danger', 'Wrong user!')
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end

  def find_article
    @article = Article.find(params[:id])
  end

  def same_user
    log_in_as?(@article.user)
  end
end
