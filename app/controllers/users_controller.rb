class UsersController < ApplicationController

  def search
    @users = User.where('name LIKE(?)',"%#{search_params[:keyword]}%").order('name ASC').limit(20)
    respond_to do |format|
      format.json
    end
  end

  private

  def search_params
    params.permit(:keyword)
  end
end
