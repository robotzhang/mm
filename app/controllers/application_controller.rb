class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to(new_user_session_path(back: request.url), :alert => "请先登陆以继续该操作") }
      format.js {render :js => "alert('请先登录');"}
    end
  end
end
