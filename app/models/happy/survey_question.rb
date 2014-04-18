module Happy
  class SurveyQuestion
    attr_accessor :id, :text, :answer, :links

    def initialize(params)
      @id = params['id']
      @text = params['text']
      @answer = params['answer']
      @links = Hashie::Mash.new(params['_links'])
    end
  end
end
