require 'paudio/has_attributes'

module PAudio

  class Volume

    include HasAttributes

    def initialize(attributes={})
      update_attributes(attributes)
    end

    attr_reader :name

    def name=(value)
      @name = value.nil? ? nil : value.to_s
    end

    attr_reader :value

    def value=(value)
      @value = value.to_i
    end

    attr_reader :percent

    def percent=(value)
      @percent = value.to_i
    end

    attr_reader :decibels

    def decibels=(value)
      @decibels = value.to_f
    end

    def to_h
      {
        name:     @name,
        value:    @value,
        percent:  @percent,
        decibels: @decibels
      }
    end

  end

end
