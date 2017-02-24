module PAudio
  module Formatter

    # Formatter for `asod_cat`
    class ASODCat < Base
      def initialize(sink)
        @sink = sink
      end

      def to_s
        volumes = @sink.volume.values
        volumes.uniq(&:percent)
        #volumes.first.show_channel = false if volumes.length == 1 # TODO

        volumes.collect!(&:to_s).join(' ')
      end
    end

  end
end
