class HashtagsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :have_not_hashtag

  def show
    @hashtag = Hashtag.only_have_question.find_by!(name: params[:name])
    @hashtag_questions = @hashtag.questions
  end

  private

  def have_not_hashtag
    redirect_to root_path, alert: "Вопросы с указаным hashtag отсутствуют."
  end
end
