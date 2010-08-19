class <%=class_name.pluralize%>Controller < ApplicationController
  before_filter :require_no_<%=file_name%>, :only => [:new, :create, :confirm]
  before_filter :require_<%=file_name%>, :only => [:show, :edit, :update, :index]
  
  def new
    @<%=file_name%> = <%=class_name%>.new
  end
  
  def index
    @<%=file_name%> = <%=class_name%>.find(:all)
  end
  
  def create
    @<%=file_name%> = <%=class_name%>.new(params[:user])
    if @<%=file_name%>.save
      Mailer.deliver_confirmation!(@<%=file_name%>)
      flash[:notice] = "Account registered! Please check your email to confirm your account"
      redirect_back_or_default new_<%=file_name%>_url
    else
      render :action => :new
    end
  end

  def show
    @<%=file_name%> = <%=class_name%>.find(params[:id])
  end

  def edit
    @<%=file_name%> = <%=class_name%>.find(params[:id])
  end

  def update
    @<%=file_name%> = <%=class_name%>.find(params[:id])
    if @<%=file_name%>.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to @<%=file_name%>
    else
      render :action => :edit
    end
  end
  
  def confirm
    @<%=file_name%> = <%=class_name%>.find_using_perishable_token(params[:id], 0) 
    
    if @<%=file_name%> and @<%=file_name%>.confirm!
      <%=class_name%>Session.create(@<%=file_name%>) 
      flash[:notice] = "Your account is now active"
      redirect_to <%=file_name%>_url(@<%=file_name%>)
    else
      flash[:notice] = "We're sorry, but we could not locate your account. " +
          "If you are having issues try copying and pasting the URL " +
          "from your email into your browser or restarting the " +
          "reset password process."
      redirect_to new_<%=file_name%>_session_url
    end
  end
end
