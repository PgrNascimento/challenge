class Question
  API_URL = 'https://qriusity.com'.freeze
  PATH = 'v1/questions'.freeze

  attr_reader :id, :description, :category, :options, :answer

  def initialize(params)
    @id = params[:id]
    @description = params[:question]
    @category = params[:category][:name]
    @options = build_options(params)
    @answer = params[:answers]
  end

  def self.find(question_id)
    conn = Faraday.new(url: API_URL, ssl: { verify: false })
    response = conn.get("#{PATH}/#{question_id}")
    params = JSON.parse(response.body, symbolize_names: true).first
    new(params)
  end

  private

  def build_options(params)
    options = []

    options << params[:option1]
    options << params[:option2]
    options << params[:option3]
    options << params[:option4]

    options
  end
end
