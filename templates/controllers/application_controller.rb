# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  filter_parameter_logging :password, :password_confirmation
    
  private  

  def current_<%=file_name%>
    return @current_<%=file_name%> if defined?(@current_<%=file_name%>)
    @current_<%=file_name%> = current_<%=file_name%>_session && current_<%=file_name%>_session.user
  end

  def current_<%=file_name%>_session
    return @current_<%=file_name%>_session if defined?(@current_<%=file_name%>_session)
    @current_<%=file_name%>_session = <%=class_name%>Session.find
  end

  def require_<%=file_name%>
    if current_<%=file_name%>.blank?
      store_location

      if current_<%=file_name%>.blank?
        flash[:notice] = "You must be logged in to access this page"
      else
        flash[:notice] = "You must confirm your account to access this page"
      end

      redirect_to new_<%=file_name%>_session_url
      return false
    end
  end

  def require_no_<%=file_name%>
    if current_<%=file_name%>
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to <%=file_name.pluralize%>_url
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end

