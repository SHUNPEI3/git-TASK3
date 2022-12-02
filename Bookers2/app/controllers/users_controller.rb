class UsersController < ApplicationController

  def index
    @users = User.all
    sidebar_type2
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    sidebar_type3
  end

  def edit
    is_matching_login_user
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
# #############################################################################
# #############################################################################
private

  def sidebar_type2
    @userinfo = current_user
    @newbook = Book.new
  end

  def sidebar_type3
    @userinfo = User.find(params[:id])
    @newbook = Book.new
  end

  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end

  def is_matching_login_user
    user_id = params[:id].to_i
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to user_path(current_user.id)
    end
  end

end
