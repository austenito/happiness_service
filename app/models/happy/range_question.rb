module Happy
  class RangeQuestion
    attr_accessor :min, :max

    def initialize(params)
      @min = params['min']
      @max = params['max']
      super
    end
  end
end
