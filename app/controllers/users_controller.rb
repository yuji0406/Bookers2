class UsersController < ApplicationController

  before_action :ensure_current_user,{only: [:edit,:update]}
  def ensure_current_user
    @user =User.find(params[:id])
    if current_user.id != @user.id
      redirect_to user_path(current_user.id),notice: '権限がありません'
    end
  end

  def edit
    @user=User.find(params[:id])
  end

  def show
    @user=User.find(params[:id])
    @book=Book.new
    @books=Book.where(user_id:@user.id)
  end

  def index
    @user=User.all
    @book=Book.new
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user ,notice: "You have updated user successfully"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end
end
