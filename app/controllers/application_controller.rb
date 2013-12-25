class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  helper :all
  protect_from_forgery with: :exception
  include SessionsHelper

  before_filter :check_for_mobile

  private

  def mobile_device?
  	if session[:mobile_param]
  		session[:mobile_param] == "1"
  	else
		  (request.user_agent =~ /Mobile|iPhone|iPod|Android|webOS/) && (request.user_agent !~ /iPad/)
	 end
  end
  helper_method :mobile_device?

  def check_for_mobile
  	session[:mobile_param] = params[:mobile] if params[:mobile]
  	prepare_for_mobile if mobile_device?
  end

  def prepare_for_mobile
  	prepend_view_path Rails.root + 'app' + 'views_mobile'
  end
end
