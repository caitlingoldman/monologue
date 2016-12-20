class Monologue::PostsController < Monologue::ApplicationController
  before_filter :set_page, only: [:index, :search]

  def index
    @posts = Monologue::Post.page(@page).includes(:user).published
  end

  def search
    @posts = Monologue::Post.search(params[:text], @page)
  end

  def show
    if monologue_current_user
      @post = Monologue::Post.default.where("url = :url", {url: params[:post_url]}).first
    else
      @post = Monologue::Post.published.where("url = :url", {url: params[:post_url]}).first
    end
    if @post.nil?
      not_found
    end
  end

  def feed
    @posts = Monologue::Post.published.limit(25)
  end

  private

  def set_page
    @page = params[:page].nil? ? 1 : params[:page]
  end
end
