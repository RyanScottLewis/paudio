module PAudio
  module Formatter

    # Formatter for `yabar`
    class Yabar < Base
      def initialize(sink)
        @sink = sink
      end

      def to_s
        @sink.to_s
      end
    end

  end
end
