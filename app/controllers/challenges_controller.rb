class ChallengesController < ApplicationController
  def new
    if session[:challenge].nil?
      challenge_hash = { challenge_number: 1, answers: [] }
      session[:challenge] = challenge_hash
    else
      challenge_hash = session[:challenge].with_indifferent_access
      challenge_hash[:challenge_number] = challenge_hash[:challenge_number] + 1
      answers = challenge_hash[:answers]
      last_challenge = answers.last
      answers.pop
      last_challenge[:user_answer] = params[:option]
      answers << last_challenge
      session[:challenge] = challenge_hash
    end

    conn = Faraday.new(url: 'https://qriusity.com')
    response = conn.get("/v1/questions/#{challenge_hash[:challenge_number]}")

    challenge_params = JSON.parse(response.body, symbolize_names: true).first
    @challenge = Challenge.new(challenge_params)

    challenge_hash[:answers] << { user_answer: nil, answer: @challenge.answer }
    session[:challenge] = challenge_hash

    @challenge_count = challenge_hash[:answers].count
    render partial: 'challenge', locals: { challenge: @challenge }
  end
end
