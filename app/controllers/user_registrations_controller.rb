class UserRegistrationsController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
    @user.account_activation_code = (0...16).map{ o[rand(o.length)] }.join
    if @user.save_with(session[:referer])
      UserMailer.confirmation_instructions(@user).deliver
      sign_in(:user, @user, :bypass => true)
      redirect_to after_sign_in_path_for(@user)
    else
      render :action => :new
    end
  end
  
  def resend_confirmations
    @user = current_user
    if @user.account_activation_code != nil
      o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
      @user.account_activation_code = (0...16).map{ o[rand(o.length)] }.join
      @user.save
      UserMailer.confirmation_instructions(@user).deliver
      flash[:notice] = "You will receive an email with instructions about how to confirm your account in a few minutes."
    else
      flash[:notice] = "Your account is already confirmed." 
    end
    redirect_to root_path
  end
  
  def confirm_account
    @user = User.find_by_account_activation_code(params[:confirm_token])
    @user.update_attributes({
        :account_activation_code => nil,
        :confirmed_at => Time.now
      })
    sign_in(:user,@user,:bypass => true)
    redirect_to after_sign_in_path_for(@user)
  end
end
