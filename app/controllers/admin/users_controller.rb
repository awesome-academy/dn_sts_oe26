class Admin::UsersController < AdminController
  before_action :load_user, except: [:index, :new]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    user = User.new param_users
    if @user.save
      @user.send_activation_email
      flash[:info] = t "users.new.please_check_mail"
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    key = @user.delete ? ".delete_success" : ".delete_fail"
    flash[:info] = t(key, name: @user.name)
    redirect_to request.referrer
  end

  def update
    key = @user.activate ? ".active_success" : ".active_fail"
    flash[:info] = t(key, name: @user.name)
    redirect_to request.referrer
  end

  private

  def load_user
    @user = User.find_by(id: params[:id])
    return if @user
    render "shared/not_found"
  end

  def param_users
    params.require(:user).permit(:name, :email,
                                 :password, :password_confirmation,
                                 :birthday, :company, :gradution,
                                 :university, :address, :role, :gender )
  end
end
