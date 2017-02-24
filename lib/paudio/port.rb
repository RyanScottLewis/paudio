require 'paudio/has_attributes'

module PAudio

  class Port

    include HasAttributes

    def initialize(attributes={})
      update_attributes(attributes)
    end

    attr_reader :name

    def name=(value)
      @name = value.to_s
    end

    attr_reader :description

    def description=(value)
      @description = value.to_s
    end

    attr_reader :priority

    def priority=(value)
      @priority = value.to_i
    end

    attr_reader :available

    def available=(value)
      @available = !!value
    end

    def to_h
      {
        name:        @name,
        description: @description,
        priority:    @priority,
        available:   @available
      }
    end

  end

end
