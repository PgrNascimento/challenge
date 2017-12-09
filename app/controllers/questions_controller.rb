class QuestionsController < ApplicationController
  def new
    session[:challenge] = { challenge_number: 1, answers: [] }

    question = next_question(1)

    render partial: 'question', locals: { question: question }
  end

  def create
    challenge_hash = save_user_option

    question = next_question(challenge_hash[:challenge_number])

    @challenge_count = challenge_hash[:answers].count

    render partial: 'question', locals: { question: question }
  end

  private

  def save_user_option
    challenge_hash = session[:challenge].with_indifferent_access
    challenge_hash[:challenge_number] = challenge_hash[:challenge_number] + 1
    answers = challenge_hash[:answers]
    last_challenge = answers.pop
    last_challenge[:user_answer] = params[:option]
    answers << last_challenge
    session[:challenge] = challenge_hash
    challenge_hash
  end

  def next_question(question_id)
    challenge_hash = session[:challenge].with_indifferent_access

    question = Question.find(question_id)

    challenge_hash[:answers] << { user_answer: nil, answer: question.answer }
    session[:challenge] = challenge_hash

    question
  end
end
