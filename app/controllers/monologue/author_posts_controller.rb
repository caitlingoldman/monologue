class Monologue::AuthorPostsController < Monologue::ApplicationController

	def index
		@user = Monologue::User.find(params[:user_id])
    @posts = @user.posts.page(@page).includes(:user).published
	end
end