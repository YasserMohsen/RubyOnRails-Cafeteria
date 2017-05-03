class Admin::UsersController < Admin::AdminController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  semantic_breadcrumb "Users", :admin_users_path

  def index
    @users = User.all
  end

  def new
    semantic_breadcrumb "Create", new_admin_user_path
    @user = User.new
  end

  def edit
    semantic_breadcrumb @user.name
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: 'User was successfully created.'
    else
      semantic_breadcrumb "Create", new_admin_user_path
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, alert: 'User was successfully destroyed.'
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name,:email,:password,:room_id,:is_admin, :ext, :avatar)
    end
end
