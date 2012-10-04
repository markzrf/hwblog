# -*- coding: utf-8 -*-
# This controller handles the login/logout function of the site.
class UserSessionsController < ApplicationController

  # render new.rhtml
  def new
    #session[:return_to] = request.referer
    respond_to do |format|
      format.html do
        render :layout => false if request.xhr?
      end

    end
  end

  def create
    session[:user_id]=nil
    user = User.authenticate(params[:login], params[:password])

    if user
      session[:user_id]= user.id
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_user = user
      respond_to do |format|
        format.html{
          redirect_to('/')
        }
      end
    else
      respond_to do |format|
        format.any(:html){
          flash[:error] = "用户名或密码错误，请重试..."
          render :action => 'new'
        }
      end
    end
  end

  def destroy
   session[:user_id]=nil
    # flash[:notice] = "You have been logged out."
    respond_to do |format|
      format.any( :html){
        redirect_to('/')
      }
      format.js {
        render :nothing => true
      }
    end
  end

end
