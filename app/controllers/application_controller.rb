class ApplicationController < ActionController::Base
  include SessionsHelper
  include NotificationsHelper

  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception
  before_action :set_locale
  layout :dynamic_layout

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_users_path
    else
      courses_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password,
      :password_confirmation, :birthday, :gender, :company, :gradution,
      :university, :address, :role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password,
      :password_confirmation, :birthday, :gender, :company, :gradution,
      :university, :address, :role])
  end

  private

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ? locale : I18n.default_locale
  end

  def dynamic_layout
    current_user&.admin? ? "admin" : "application"
  end

  def user_not_authorized
    flash[:warning] = t ".not_authorized"
    redirect_to(request.referrer || root_path)
  end

  rescue_from CanCan::AccessDenied do |_exception|
    if user_signed_in?
      flash[:danger] = t "controllers.application.not_permition"
      redirect_to courses_path
    else
      flash[:danger] = t "controllers.application.login_please"
      redirect_to new_user_session_path
    end
  end

end
