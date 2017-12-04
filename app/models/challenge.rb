class Challenge
  attr_reader :id, :question, :category, :options, :answer

  def initialize(json)
    @id = json[:id]
    @question = json[:question]
    @category = json[:category][:name]
    @options = build_options(json)
    @answer = json[:answers]
  end

  private

  def build_options(json)
    options = []

    options << json[:option1]
    options << json[:option2]
    options << json[:option3]
    options << json[:option4]

    options
  end
end
