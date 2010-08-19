class <%=class_name%>SessionsController < ApplicationController
  before_filter :require_no_<%=file_name%>, :only => [:new, :create]
  before_filter :require_<%=file_name%>, :only => :destroy

  def new
    @<%=file_name%>_session = <%=class_name%>Session.new
  end

  def create
    @<%=file_name%>_session = <%=class_name%>Session.new(params[:<%=file_name%>_session])
    if @<%=file_name%>_session.save
      flash[:notice] = "Login successful!"
      redirect_to :controller => "index"
    else
      render :action => :new
    end
  end

  def destroy
    current_<%=file_name%>_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to :action => :new
  end

end
