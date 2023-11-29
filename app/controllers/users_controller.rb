class UsersController < ApplicationController
  
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(email: params['email'], encrypted_password: params['password'])
    @event.avatar.attach(params[:avatar])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update
  end

  def destroy
    @event = Event.find(params[:id])
    @user.destroy
  end
end
