class PasswordResetsController < ApplicationController
  before_filter :load_<%=file_name%>_using_perishable_token, :only => [:edit, :update]
  before_filter :require_no_<%=file_name%>

  def new
    render
  end

  def create
    @<%=file_name%> = <%=class_name%>.find_by_email(params[:email])
    if @<%=file_name%>
      @<%=file_name%>.deliver_password_reset_instructions!
      flash[:notice] = "Instructions to reset your password have been emailed to you. " +
        "Please check your email."
      redirect_to root_url
    else
      flash[:notice] = "No <%=file_name%> was found with that email address"
      render :action => :new
    end
  end

  def edit
    render
  end
  
  def update
    @<%=file_name%>.password = params[:<%=file_name%>][:password]
    @<%=file_name%>.password_confirmation = params[:<%=file_name%>][:password_confirmation]
    if @<%=file_name%>.save
      flash[:notice] = "Password successfully updated"
      redirect_to <%=file_name%>_url(@<%=file_name%>)
    else
      render :action => :edit
    end
  end
  
  private
      
    def load_<%=file_name%>_using_perishable_token
      @<%=file_name%> = <%=class_name%>.find_using_perishable_token(params[:id])
      unless @<%=file_name%>
        flash[:notice] = "We're sorry, but we could not locate your account. " +
          "If you are having issues try copying and pasting the URL " +
          "from your email into your browser or restarting the " +
          "reset password process."
        redirect_to root_url
      end
    end
end
