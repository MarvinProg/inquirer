class UsersController < ApplicationController
  before_action :load_user, except: [:index, :create, :new]
  before_action :authorize_user, except: [:index, :new, :create, :show]

  def index
    @users = User.all
    @hashtags = Hashtag.only_have_question
  end

  def new
    redirect_to root_path, alert: 'Вы уже вошли в профиль' if current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_path, alert: 'Вы уже вошли в профиль' if current_user.present?

    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Пользователь успешно зарегестрирован.'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Данные успешно обновлены.'
    else
      render 'edit'
    end
  end

  def show
    @questions = @user.questions.by_recent
    @new_question = @user.questions.build

    @questions_count = @questions.count
    @answers_count = @questions.answered.count
    @unanswered_count = @questions.unanswered.count
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Пользователь удален.'
  end

  private

  def authorize_user
    reject_user unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :username, :avatar_url, :color_background_user)
  end

  def load_user
    @user ||= User.find params[:id]
  end
end
