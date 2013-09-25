class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter do
    # hack for cancan
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)

    if devise_controller?
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(*User::ACCESSABLE_ATTRS) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(*User::ACCESSABLE_ATTRS) }
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(*User::ACCESSABLE_ATTRS) }
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to(new_user_session_path(next: request.url), :alert => "请先登陆以继续该操作") }
      format.js {render :js => "alert('请先登录');"}
    end
  end

  # devise注销成功后返回的url
  def after_sign_out_path_for(resource_or_scope)
    params[:next] || root_path
  end

  # devise登陆成功后返回的url
  def after_sign_in_path_for(resource_or_scope)
    params[:next] || root_path
  end
end
