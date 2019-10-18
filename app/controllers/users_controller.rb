class UsersController < ApplicationController
  authorize_resource
  before_action :load_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def show
    @course_users = @user.course_users.select_subject
                         .with_course_course_subject_subject.joinning
  end

  def create
    @user = User.new user_params
    if @user.valid?
      session[:code] = rand(100_000..999_999)
      session[:user_params] = user_params
      UserMailer.confirm_email(user_params[:email], session).deliver_now
      flash[:info] = t ".check_mail_code"
      render :confirm_email
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "users.show.update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :birthday, :gender, :company, :gradution,
      :university, :address, :role
  end

  def load_user
    @user = User.find_by(id: params[:id])
    return if @user
    flash["danger"] = t "courses.notfound.notfound"
    redirect_to notfound_path
  end
end
