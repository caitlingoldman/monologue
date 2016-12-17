class Monologue::PostsController < Monologue::ApplicationController
  def index
    @page = params[:page].nil? ? 1 : params[:page]
    @posts = Monologue::Post.page(@page).includes(:user).published
  end

  def search
    @page = params[:page].nil? ? 1 : params[:page]
    @posts = Monologue::Post
      .page(@page)
      .includes(:user)
      .published
      .joins(:tags, :user)
      .where("
        monologue_tags.name ILIKE :itext OR
        monologue_posts.title ILIKE :itext OR
        monologue_posts.content ILIKE :itext OR
        users.first_name ILIKE :itext OR
        users.last_name ILIKE :itext",
        itext: "%#{params[:text]}%")
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
end
