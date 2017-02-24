module PAudio

  module HasAttributes

    def update_attributes(attributes={})
      attributes = attributes.to_h

      attributes.each { |attribute, value| send("#{attribute}=", value) }
    end

  end

end
