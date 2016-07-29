class NationApiTokensController < ApplicationController
  before_action :authenticate_user!, :set_user, :set_token, :require_permission

  def new
    @token = NationApiToken.new
  end

  def create
    @token = @user.nation_api_tokens.new(nation_api_token_create_params)
    if @token.save
      redirect_to show_token_path(id: @token, user_id: @current_user), notice: "API Token successfully created!"
    else
      render :new
    end
  end

  def index
  end

  def show
    @token = NationApiToken.find(params[:id])
  end

  def edit
    @token = NationApiToken.find(params[:token_id])
  end

  def update
    @token = NationApiToken.find(params[:token_id])
    if @token.update(nation_api_token_update_params)
      redirect_to show_token_path(@token), notice: "token successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    @token = NationApiToken.find(params[:token_id])
    @token.destroy
    redirect_to user_nation_api_tokens_path, alert: "API Token successfully deleted!"
  end

  private

  def set_user
    @user = current_user
  end

  def set_token
    @tokens = @user.nation_api_tokens
  end

  def nation_api_token_update_params
    params.require(:nation_api_token).permit(:note, :site_slug)
  end

  def nation_api_token_create_params
    params.require(:nation_api_token).permit(:nation_slug, :api_token, :site_slug, :note)
  end

  def require_permission
    if current_user != User.find(params["user_id"])
      redirect_to root_path, notice: "You are not authorized to view this content."
    end
  end
end
